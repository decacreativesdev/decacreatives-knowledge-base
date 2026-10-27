#!/usr/bin/env bash
# lint.sh - structural health check for this brain.
# Prints one line per finding. Exits 1 if any ERROR was found, 0 otherwise.
# Errors: orphans, broken links, missing frontmatter, task rows missing owner/date,
#         filenames off the closed list, malformed log headings, leftover placeholders.
# Warnings: overdue tasks, unprocessed inbox files, stale session files.
# Skips: .git/, node_modules/, repos/*/ (other projects), templates/ and patches/ (deleted at setup),
#        sessions/*.md except its README (ephemeral, one per live session - checked for shape instead).
# Sessions: a path inside another live session's Scope or Touched list (sessions/<id>.md) is reported as
#           "in progress", not as an error. Set LINT_SESSION=<id> so your own scope stays yours to fix.
# Portable to macOS bash 3.2 and BSD tools: no associative arrays, no date -d.

set -u
cd "$(dirname "$0")/.." || exit 2
ROOT=$(pwd -P)
TODAY=$(date +%Y-%m-%d)
errors=0
warnings=0
err()  { printf 'ERROR  %s\n' "$*"; errors=$((errors + 1)); }
warn() { printf 'WARN   %s\n' "$*"; warnings=$((warnings + 1)); }
info() { printf 'INFO   %s\n' "$*"; }

TMP=$(mktemp -d 2>/dev/null || mktemp -d -t lint)
trap 'rm -rf "$TMP"' EXIT

# ---- files in scope -----------------------------------------------------------
{
  find . -name '*.md' \
    -not -path './.git/*' -not -path './node_modules/*' \
    -not -path './repos/*/*' -not -path './templates/*' -not -path './patches/*' \
    -not -path './sessions/*' -not -path './docs-local/*'
  [ -f sessions/README.md ] && echo ./sessions/README.md
} | sed 's|^\./||' | sort > "$TMP/md"

# ---- 0. live sessions' scopes --------------------------------------------------
# "<session id>\t<path>" for every Scope and Touched entry of every live session but this one.
: > "$TMP/scopes"
if [ -d sessions ]; then
  for sf in sessions/*.md; do
    [ -f "$sf" ] || continue
    [ "$(basename "$sf")" = "README.md" ] && continue
    sid=$(basename "$sf" .md)
    [ "$sid" = "${LINT_SESSION:-}" ] && continue
    awk -v id="$sid" '/^## (Scope|Touched)$/{on=1; next} /^## /{on=0}
         on && /^- / && $0!="- (none yet)" {sub(/^- /,""); print id "\t" $0}' "$sf" >> "$TMP/scopes"
  done
fi
in_progress() {  # in_progress <repo-relative path> -> prints the owning session id, exit 1 if none
  [ -s "$TMP/scopes" ] || return 1
  awk -F'\t' -v p="$1" 'index(p,$2)==1 {print $1; found=1; exit} END{exit !found}' "$TMP/scopes"
}

# Link sources also include tool configs that are not .md.
cp "$TMP/md" "$TMP/linksrc"
for f in .cursorrules .windsurfrules; do [ -f "$f" ] && echo "$f" >> "$TMP/linksrc"; done

is_root() {
  case "$1" in
    README.md|AGENTS.md|CLAUDE.md|STATE.md|.github/copilot-instructions.md) return 0 ;;
  esac
  return 1
}

# ---- 1. filename casing ---------------------------------------------------------
while IFS= read -r f; do
  base=$(basename "$f")
  case "$base" in
    README.md|AGENTS.md|CLAUDE.md|STATE.md|LOG.md|WIKI.md) continue ;;
    CONTRIBUTING.md|CHANGELOG.md|LICENSE.md|SECURITY.md|CODE_OF_CONDUCT.md|PULL_REQUEST_TEMPLATE.md) continue ;;
  esac
  if printf '%s' "$base" | grep -qE '[A-Z]'; then
    case "$f" in
      sources/*) warn "source filename is not kebab-case (kept as received?): $f" ;;
      *) err "filename must be on the closed all-caps list or a kebab-case slug: $f" ;;
    esac
  fi
done < "$TMP/md"

# ---- 2. resolve every relative link ---------------------------------------------
# Output: "<source file>\t<resolved absolute target>\t<raw target>"
: > "$TMP/links"
while IFS= read -r f; do
  dir=$(dirname "$f")
  # Skip fenced code blocks and inline code spans: an example path is not an edge.
  awk '/^[[:space:]]*(```|~~~)/{fence=!fence; next} !fence{print}' "$f" 2>/dev/null \
    | sed -E 's/`[^`]*`//g' \
    | grep -oE '\]\([^)]+\)' | sed -E 's/^\]\(//; s/\)$//' | while IFS= read -r raw; do
    target=${raw%%#*}; target=${target%% *}; target=${target%%\?*}
    [ -z "$target" ] && continue
    case "$target" in
      http://*|https://*|mailto:*|/*) continue ;;
    esac
    tdir=$(dirname "$target"); tbase=$(basename "$target")
    if abs=$(cd "$dir" 2>/dev/null && cd "$tdir" 2>/dev/null && pwd -P); then
      printf '%s\t%s\t%s\n' "$f" "$abs/$tbase" "$raw" >> "$TMP/links"
    else
      printf '%s\t%s\t%s\n' "$f" "UNRESOLVED:$dir/$target" "$raw" >> "$TMP/links"
    fi
  done
done < "$TMP/linksrc"

# ---- 3. broken links ----------------------------------------------------------
while IFS=$'\t' read -r src abs raw; do
  case "$abs" in
    "$ROOT"/repos/*/*|UNRESOLVED:*repos/*/*)
      [ -e "${abs#UNRESOLVED:}" ] || info "external link into repos/ not checked: $src -> $raw" ;;
    UNRESOLVED:*)
      rel=${abs#UNRESOLVED:}; rel=${rel#./}
      if sid=$(in_progress "$src") || sid=$(in_progress "$rel"); then
        info "in progress by $sid - broken link: $src -> $raw"
      else err "broken link: $src -> $raw"; fi ;;
    *)
      if [ ! -e "$abs" ]; then
        rel=${abs#$ROOT/}
        if sid=$(in_progress "$src") || sid=$(in_progress "$rel"); then
          info "in progress by $sid - broken link: $src -> $raw"
        else err "broken link: $src -> $raw"; fi
      fi ;;
  esac
done < "$TMP/links"

# ---- 4. orphans -----------------------------------------------------------------
cut -f2 "$TMP/links" | sort -u > "$TMP/targets"
while IFS= read -r f; do
  is_root "$f" && continue
  case "$f" in templates/*|patches/*) continue ;; esac
  abs="$ROOT/$f"
  if ! grep -qxF "$abs" "$TMP/targets"; then
    if sid=$(in_progress "$f"); then info "in progress by $sid - orphan: $f"; else err "orphan - no real link points at it: $f"; fi
  else
    # a file linked only from itself is still an orphan
    if ! awk -F'\t' -v a="$abs" -v s="$f" '$2==a && $1!=s {found=1} END {exit !found}' "$TMP/links"; then
      if sid=$(in_progress "$f"); then info "in progress by $sid - orphan: $f"; else err "orphan - only linked from itself: $f"; fi
    fi
  fi
done < "$TMP/md"

# ---- 5. frontmatter on hub pages ----------------------------------------------
for f in brain/wiki/*/*.md; do
  [ -f "$f" ] || continue
  [ "$(basename "$f")" = "README.md" ] && continue
  if [ "$(head -1 "$f")" != "---" ]; then
    err "page has no frontmatter: $f"; continue
  fi
  fm=$(awk 'NR==1{next} /^---$/{exit} {print}' "$f")
  printf '%s\n' "$fm" | grep -qE '^type:' || err "frontmatter missing 'type': $f"
  printf '%s\n' "$fm" | grep -qE '^updated:' || err "frontmatter missing 'updated': $f"
  printf '%s\n' "$fm" | grep -qE '^sources:' || warn "frontmatter has no 'sources' list: $f"
done

# ---- 6. tasks table -----------------------------------------------------------
if [ -f brain/wiki/tasks.md ]; then
  open=0; overdue=0
  # real rows only: skip the fenced example and the header/separator rows
  awk '/^```/{fence=!fence; next} !fence && /^\| /{print}' brain/wiki/tasks.md \
    | grep -vE '^\| *(Due|---)' > "$TMP/rows" || true
  while IFS= read -r row; do
    due=$(printf '%s' "$row" | awk -F'|' '{gsub(/^ +| +$/,"",$2); print $2}')
    owner=$(printf '%s' "$row" | awk -F'|' '{gsub(/^ +| +$/,"",$3); print $3}')
    task=$(printf '%s' "$row" | awk -F'|' '{gsub(/^ +| +$/,"",$4); print $4}')
    [ -z "$task" ] && continue
    open=$((open + 1))
    [ -z "$owner" ] && err "task has no owner: $task"
    if [ -z "$due" ]; then
      err "task has no due date (use a date or 'open'): $task"
    elif [ "$due" != "open" ]; then
      if ! printf '%s' "$due" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'; then
        err "task due date is not YYYY-MM-DD: $task ($due)"
      elif [ "$due" \< "$TODAY" ]; then
        overdue=$((overdue + 1)); warn "overdue since $due: $task ($owner)"
      fi
    fi
  done < "$TMP/rows"
  info "tasks: $open open, $overdue overdue"
fi

# ---- 7. log headings ----------------------------------------------------------
if [ -f brain/wiki/LOG.md ]; then
  # process substitution, not a pipe: err() must run in this shell so the count survives
  while IFS= read -r h; do err "log heading not in '## [YYYY-MM-DD] <op> | <title>' form: $h"; done \
    < <(awk '/^```/{fence=!fence; next} !fence && /^## /{print}' brain/wiki/LOG.md \
        | grep -vE '^## \[[0-9]{4}-[0-9]{2}-[0-9]{2}\] (ingest|ask|brief|lint|decision|session) \| .+')
fi

# ---- 8. inbox -----------------------------------------------------------------
if [ -d brain/inbox ]; then
  n=$(find brain/inbox -type f -not -name 'README.md' -not -name '.gitkeep' -not -name '.DS_Store' | wc -l | tr -d ' ')
  if [ "$n" -gt 0 ]; then warn "inbox has $n unprocessed file(s)"; else info "inbox empty"; fi
fi

# ---- 9. leftover setup placeholders (only once setup has run) ------------------
if [ ! -d templates ]; then
  for f in README.md AGENTS.md STATE.md; do
    [ -f "$f" ] || continue
    while IFS= read -r l; do err "setup instruction or placeholder left in $f: $l"; done \
      < <(grep -nE '^>|<operator-name>|<operator-slug>|<perspective>|<organization-name>|SETUP-BANNER' "$f")
  done
else
  info "templates/ present - setup has not run; placeholder check skipped"
fi

# ---- 10. live sessions ----------------------------------------------------------
# One file per live session under sessions/, in the shape sessions/README.md documents.
if [ -d sessions ]; then
  n=0
  for sf in sessions/*.md; do
    [ -f "$sf" ] || continue
    [ "$(basename "$sf")" = "README.md" ] && continue
    n=$((n + 1)); sid=$(basename "$sf" .md)
    printf '%s' "$sid" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$' \
      || err "session id must be YYYY-MM-DD-<kebab-slug>: $sf"
    [ "$(head -1 "$sf")" = "# Session $sid" ] || err "session file must open with '# Session $sid': $sf"
    for k in Started Checkpoint Tool Intent; do
      grep -q "^- $k:" "$sf" || err "session file missing '- $k:': $sf"
    done
    for h in Scope Touched "Where it is" Next; do
      grep -qx "## $h" "$sf" || err "session file missing '## $h': $sf"
    done
    [ -n "$(find "$sf" -mmin +720 2>/dev/null)" ] \
      && warn "session stale - no checkpoint for 12h+; adopt it or close it into the log: $sid"
  done
  if [ "$n" -gt 0 ]; then info "live sessions: $n${LINT_SESSION:+ (this one: $LINT_SESSION)}"; else info "no live sessions"; fi
fi
# STATE.md points at finished sessions' log entries, never at a file in sessions/ - those are not committed.
if [ -f STATE.md ] && grep -qE 'sessions/[0-9]{4}-[0-9]{2}-[0-9]{2}-' STATE.md; then
  warn "STATE.md points at a live session file; list finished sessions only, as links to their log entries"
fi

# ---- summary --------------------------------------------------------------------
printf 'lint: %d error(s), %d warning(s)\n' "$errors" "$warnings"
[ "$errors" -eq 0 ]
