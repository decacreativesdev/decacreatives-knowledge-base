# Lint

The health check, in two parts. The script catches structure; the AI catches meaning. Run the script after every ingest. Run both parts weekly.

## Part 1 - the script

```sh
LINT_SESSION=<your session id> scripts/lint.sh
```

It exits non-zero on errors and prints one line per finding. Errors: orphan pages, broken links, pages missing frontmatter, task rows missing an owner or a due date, filenames off the closed list and not kebab-case, malformed log headings, malformed session files. Warnings: overdue tasks, unprocessed inbox files, stale session files. Fix every error before reporting an ingest done. Never silence a finding by deleting the thing it points at unless that is the correct fix.

**Another session's work in progress is not your error.** A finding whose path sits in another live session's Scope or Touched list under `sessions/` is printed as `INFO in progress by <id>`, not `ERROR`. Leave it alone; that session will finish it. `LINT_SESSION` tells the script which session is yours, so your own half-done work is still reported as yours to fix.

## Part 2 - the meaning check

Enter at [the map](../brain/wiki/README.md) and traverse the hubs. Look for:

- **Contradictions between pages.** Two pages that claim different owners, dates, or statuses for the same thing. Flag on both pages with both sources.
- **Superseded claims.** A page claim that a newer source in `brain/sources/` contradicts and that was never updated.
- **Missing pages.** A person, project, organization, system, or term referenced from two or more pages with no page of its own.
- **Missing cross-references.** Two pages that obviously relate and do not link to each other.
- **Stale tasks.** Rows in [tasks](../brain/wiki/tasks.md) whose project page is closed, or whose owner has left.
- **Decisions never recorded.** Pages that describe a change of course with no entry in the Decisions hub.
- **Stale sessions.** A file under `sessions/` with no checkpoint for twelve hours or more. Adopt it and finish, or close it into the log as `session | <slug> (abandoned)`. Never delete one silently.

## Output shape

```
Lint <YYYY-MM-DD>

Script: <N> errors, <N> warnings - <fixed | listed below>
Meaning:
- <finding> - <pages> - <fixed | needs the operator: one question>
```

Fix what needs no human judgment. Ask one question per finding that does. Log as `## [YYYY-MM-DD] lint | <script only | full pass>`, and record the script result in `STATE.md` -> "Lint Status".

_Indexed in [Standing Queries](README.md)._
