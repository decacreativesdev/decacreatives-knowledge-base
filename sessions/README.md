# Sessions

One file per AI session that is open right now. This is how two or more terminals work on the same brain without overwriting each other, and how a session that dies mid-task still leaves a current handoff behind.

The handoff used to be one paragraph in `STATE.md`. One slot can describe one session and survives only until the next write. Here every session owns its own file while it runs, and `ls sessions/` answers "what is running" without asking anyone. Nothing here is committed: a file's durable content becomes a `session` entry in the log when the session ends, and `STATE.md` -> "Session Handoff" points at those log entries, never at a file in this folder.

## Rules

- **Start by creating your file, before touching anything else.** `scripts/session.sh start <slug>` writes it and lists the other live sessions. The id is `YYYY-MM-DD-<slug>`, and the slug says what you are here to do: `2026-09-23-template-review`, `2026-09-24-inbox-drain`.
- **Read the others.** If a live session's Scope or Touched list overlaps what you are about to change, say so before starting - the "live session overlap" check in `AGENTS.md`. Then coordinate, work elsewhere first, or ask the operator.
- **Checkpoint here, not in `STATE.md`.** At each milestone rewrite your own file: what you have touched, where you are, what is next. `scripts/session.sh checkpoint <id>` stamps the time. `STATE.md` is shared and changes rarely; this file is yours and changes often.
- **Record every path you change** with `scripts/session.sh touch <id> <path>...`. The Touched list is the exact set you stage at commit time - never `git add -A` on a shared tree, because it sweeps in the other session's half-written files.
- **End by closing into the log.** `scripts/session.sh end <id>` prints a ready `## [date] session | <slug>` entry for `brain/wiki/LOG.md` and the `git add` line, then deletes the file. Add one row to `STATE.md` -> "Session Handoff" pointing at that log entry. That table lists finished sessions only; the live ones are this folder.
- **A stale file is a handoff, not litter.** No checkpoint for twelve hours means the session is gone. The next session either **adopts** it - adds `- Resumed: <date> by <id>` and continues from Next - or **closes** it into the log as `session | <slug> (abandoned)`. Never delete one silently; the lint pass warns until it is handled.
- **These files are not knowledge and are not committed.** `.gitignore` keeps everything here out of git except this `README.md`. Anything durable a session learned goes to a wiki page and the log, in that session's own end step.

## The file

Fixed headings, so the scripts and the lint pass can read it. Eight lines or so; a handoff is not an essay.

```markdown
# Session 2026-09-23-template-review

- Started: 2026-09-23 14:10
- Checkpoint: 2026-09-23 15:40
- Tool: Claude Code
- Intent: review ai-knowledge-base-template for use from several terminals

## Scope
- repos/ai-knowledge-base-template/
- brain/wiki/systems/ai-knowledge-base-template.md

## Touched
- brain/wiki/systems/ai-knowledge-base-template.md

## Where it is
Review delivered. Waiting on the operator to choose an option.

## Next
Implement the sessions convention as template v2, then apply the patch to this brain.

## Needs from the operator
Pick an option.
```

Scope is what you expect to change - directories with a trailing slash, or single files. Touched is what you actually changed. Both are read by `scripts/lint.sh`: an orphan or broken link inside another live session's Scope is reported as in progress rather than as an error, so one session's half-finished page is never "fixed" by another.

## The scripts

| Command | Does |
|---|---|
| `scripts/session.sh start <slug> [--tool T] [--intent "..."] [--scope P ...]` | Creates the file, prints the id, lists live sessions and any overlap |
| `scripts/session.sh list` | Every live session with its age, and which are stale |
| `scripts/session.sh touch <id> <path>...` | Adds paths to Touched |
| `scripts/session.sh checkpoint <id> [--where "..."] [--next "..."] [--needs "..."]` | Stamps the time and rewrites those sections |
| `scripts/session.sh end <id> [--keep]` | Prints the log entry and the `git add` line, deletes the file unless `--keep` |
| `LINT_SESSION=<id> scripts/lint.sh` | Lint that treats your own scope as yours to fix and other live scopes as in progress |

Back to [the map](../brain/wiki/README.md).
