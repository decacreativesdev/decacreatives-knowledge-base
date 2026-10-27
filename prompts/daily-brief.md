# Daily brief

What the operator needs to do and know today. Answered from the wiki, never from memory.

## Procedure

1. Read `STATE.md` -> "Focus" and "Blockers".
2. Read [brain/wiki/tasks.md](../brain/wiki/tasks.md). Keep rows whose Owner is the operator (per `AGENTS.md` -> "Operator"), plus rows with status `blocked` regardless of owner.
3. Read the last five entries of [the log](../brain/wiki/LOG.md) for anything filed since the last brief.
4. Read the Decisions hub, if it exists, for pages with `status: open`.
5. Run `scripts/session.sh list` for the other AI sessions open right now, and which of them are stale.
6. Do not read anything else unless a row's link is needed to explain it in one clause.

## Output shape

```
Today, <weekday> <YYYY-MM-DD>:

Overdue
- <task> - due <date> - <belongs to> - source <link>

Today
- ...

This week
- <task> - <date> - <belongs to>

Blocked
- <task> - waiting on <who or what> since <date>

Open decisions
- <title> - <link>

Live sessions
- <id> - <intent> - last checkpoint <time> - <live | STALE, adopt or close>

Since last brief: <one line, or "nothing filed">.
```

Omit an empty section. If nothing is overdue or due today, say so in one line. Every item names its source. End with the one thing the operator should do first, or say the day is clear. Log as `## [YYYY-MM-DD] brief | daily`.

_Indexed in [Standing Queries](README.md)._
