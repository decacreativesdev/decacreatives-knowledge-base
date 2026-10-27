#!/usr/bin/env bash
# session.sh - one file per live AI session under sessions/, so several terminals
# can work on this brain at once and a dead session still leaves a handoff.
#   start <slug> [--tool T] [--intent "..."] [--scope P ...]   create the file, report overlaps
#   list                                                         live sessions, age, staleness
#   touch <id> <path>...                                         record changed paths
#   checkpoint <id> [--where "..."] [--next "..."] [--needs "..."]
#   end <id> [--keep]                                            print log entry + git add line, delete
# The file shape is documented in sessions/README.md and checked by scripts/lint.sh.
# Portable to macOS bash 3.2 and BSD tools: no associative arrays, no date -d, no stat flags.

set -u
cd "$(dirname "$0")/.." || exit 2
DIR=sessions
STALE_MIN=720          # a file untouched this long is a handoff to adopt or close
TODAY=$(date +%Y-%m-%d)
NOW=$(date '+%Y-%m-%d %H:%M')

die()  { printf 'session: %s\n' "$*" >&2; exit 1; }
file() { printf '%s/%s.md' "$DIR" "$1"; }
live() { find "$DIR" -maxdepth 1 -name '*.md' ! -name README.md 2>/dev/null | sed 's|.*/||; s|\.md$||' | sort; }
field() { awk -v k="- $2:" 'index($0,k)==1{sub(/^[^:]*: */,""); print; exit}' "$(file "$1")"; }
section() {  # section <id> <heading>  -> body lines
  awk -v h="## $2" '$0==h{on=1; next} /^## /{on=0} on' "$(file "$1")" | sed '/^[[:space:]]*$/d'
}
set_field() {  # set_field <id> <key> <value>
  f=$(file "$1"); awk -v k="- $2:" -v v="$3" 'index($0,k)==1{print k " " v; next} {print}' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
}
set_section() {  # set_section <id> <heading> <body>  (body may hold \n)
  f=$(file "$1")
  awk -v h="## $2" -v body="$3" '
    $0==h {print; print body; print ""; skip=1; next}
    /^## / {skip=0}
    !skip {print}' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
}
append_section() {  # append_section <id> <heading> <line> - keeps the list tidy and one blank line after it
  f=$(file "$1")
  awk -v h="## $2" -v line="$3" '
    $0==h {print; inside=1; next}
    inside && /^## / {for(i=1;i<=n;i++) print items[i]; print line; print ""; inside=0; n=0}
    inside {if($0 ~ /^- / && $0!="- (none yet)") items[++n]=$0; next}
    {print}
    END {if(inside){for(i=1;i<=n;i++) print items[i]; print line}}' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
}
is_stale() { [ -n "$(find "$(file "$1")" -mmin +"$STALE_MIN" 2>/dev/null)" ]; }

# paths <id> -> every Scope and Touched entry, one per line
paths() { { section "$1" Scope; section "$1" Touched; } | sed 's/^- //' | grep -v '^(none'; }

# overlaps <id> -> lines "<other id>\t<path>" where a path of <id> sits under a path of <other>
overlaps() {
  mine=$(paths "$1")
  for o in $(live); do
    [ "$o" = "$1" ] && continue
    paths "$o" | while IFS= read -r p; do
      printf '%s\n' "$mine" | while IFS= read -r m; do
        case "$m" in "$p"*|"${p%/}"*) printf '%s\t%s\n' "$o" "$m";; esac
        case "$p" in "$m"*) printf '%s\t%s\n' "$o" "$p";; esac
      done
    done
  done | sort -u
}

cmd=${1:-}; shift 2>/dev/null || true
mkdir -p "$DIR"

case "$cmd" in
start)
  slug=${1:-}; [ -n "$slug" ] || die "usage: start <slug> [--tool T] [--intent \"...\"] [--scope P ...]"
  shift
  printf '%s' "$slug" | grep -qE '^[a-z0-9]+(-[a-z0-9]+)*$' || die "slug must be kebab-case: $slug"
  tool="unknown"; intent="(not given)"; scope=""
  while [ $# -gt 0 ]; do
    case "$1" in
      --tool)   tool=$2; shift 2;;
      --intent) intent=$2; shift 2;;
      --scope)  shift; while [ $# -gt 0 ] && [ "${1#--}" = "$1" ]; do scope="$scope- $1"$'\n'; shift; done;;
      *) die "unknown option: $1";;
    esac
  done
  id="$TODAY-$slug"; f=$(file "$id")
  [ -e "$f" ] && die "already exists: $f (adopt it, or pick another slug)"
  [ -n "$scope" ] || scope="- (none yet)"$'\n'
  {
    printf '# Session %s\n\n' "$id"
    printf -- '- Started: %s\n- Checkpoint: %s\n- Tool: %s\n- Intent: %s\n\n' "$NOW" "$NOW" "$tool" "$intent"
    printf '## Scope\n%s\n' "$scope"
    printf '## Touched\n- (none yet)\n\n'
    printf '## Where it is\nJust started.\n\n## Next\n(not written yet)\n\n## Needs from the operator\nNothing.\n'
  } > "$f"
  printf 'started %s -> %s\n' "$id" "$f"
  others=$(live | grep -vx "$id")
  if [ -n "$others" ]; then
    printf 'live sessions:\n'
    for o in $others; do
      s=""; is_stale "$o" && s="  STALE - adopt or close it"
      printf '  %s  checkpoint %s  %s%s\n' "$o" "$(field "$o" Checkpoint)" "$(field "$o" Intent)" "$s"
    done
    ov=$(overlaps "$id")
    if [ -n "$ov" ]; then
      printf 'OVERLAP - report this before changing anything:\n'
      printf '%s\n' "$ov" | while IFS=$'\t' read -r o p; do printf '  %s also has %s\n' "$o" "$p"; done
    fi
  else
    printf 'no other live sessions\n'
  fi
  ;;

list)
  n=0
  for o in $(live); do
    n=$((n+1)); s="live"; is_stale "$o" && s="STALE"
    printf '%-6s %s  started %s  checkpoint %s  %s\n' "$s" "$o" "$(field "$o" Started)" "$(field "$o" Checkpoint)" "$(field "$o" Intent)"
  done
  [ "$n" -eq 0 ] && printf 'no live sessions\n'
  exit 0
  ;;

touch)
  id=${1:-}; [ -n "$id" ] && [ -f "$(file "$id")" ] || die "usage: touch <id> <path>...  (no such session: ${id:-?})"
  shift; [ $# -gt 0 ] || die "give at least one path"
  for p in "$@"; do
    p=${p#./}
    section "$id" Touched | grep -qxF -- "- $p" || append_section "$id" Touched "- $p"
  done
  set_field "$id" Checkpoint "$NOW"
  printf 'touched:\n'; section "$id" Touched
  ;;

checkpoint)
  id=${1:-}; [ -n "$id" ] && [ -f "$(file "$id")" ] || die "usage: checkpoint <id> [--where ...] [--next ...] [--needs ...]"
  shift
  while [ $# -gt 0 ]; do
    case "$1" in
      --where) set_section "$id" "Where it is" "$2"; shift 2;;
      --next)  set_section "$id" "Next" "$2"; shift 2;;
      --needs) set_section "$id" "Needs from the operator" "$2"; shift 2;;
      *) die "unknown option: $1";;
    esac
  done
  set_field "$id" Checkpoint "$NOW"
  printf 'checkpoint %s at %s\n' "$id" "$NOW"
  ov=$(overlaps "$id")
  if [ -n "$ov" ]; then
    printf 'OVERLAP with another live session:\n'
    printf '%s\n' "$ov" | while IFS=$'\t' read -r o p; do printf '  %s also has %s\n' "$o" "$p"; done
  fi
  ;;

end)
  id=${1:-}; [ -n "$id" ] && [ -f "$(file "$id")" ] || die "usage: end <id> [--keep]"
  keep=0; [ "${2:-}" = "--keep" ] && keep=1
  slug=${id#????-??-??-}
  touched=$(section "$id" Touched | sed 's/^- //' | grep -v '^(none')
  printf '\n--- paste into brain/wiki/LOG.md, newest first ---\n'
  printf '## [%s] session | %s\n\n' "$TODAY" "$slug"
  printf -- '- Ran %s to %s with %s. Intent: %s\n' "$(field "$id" Started)" "$NOW" "$(field "$id" Tool)" "$(field "$id" Intent)"
  if [ -n "$touched" ]; then printf -- '- Touched: %s\n' "$(printf '%s' "$touched" | paste -sd ',' - | sed 's/,/, /g')"; else printf -- '- Touched: nothing\n'; fi
  printf -- '- Where it ended: %s\n' "$(section "$id" 'Where it is' | paste -sd ' ' -)"
  printf -- '- Next: %s\n' "$(section "$id" Next | paste -sd ' ' -)"
  needs=$(section "$id" 'Needs from the operator' | paste -sd ' ' -)
  [ -n "$needs" ] && [ "$needs" != "Nothing." ] && printf -- '- Needs from the operator: %s\n' "$needs"
  printf '\n--- one row for STATE.md -> Session Handoff ---\n'
  printf '| %s | %s | [log %s](brain/wiki/LOG.md) |\n' "$id" "$(field "$id" Intent)" "$TODAY"
  if [ -n "$touched" ]; then
    printf '\n--- stage exactly what this session changed ---\n'
    printf 'git add'; printf '%s\n' "$touched" | while IFS= read -r p; do printf ' %s' "$p"; done; printf '\n'
  fi
  if [ "$keep" -eq 1 ]; then printf '\nkept %s\n' "$(file "$id")"; else rm -f "$(file "$id")"; printf '\nremoved %s\n' "$(file "$id")"; fi
  ;;

*)
  sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'
  exit 2
  ;;
esac
