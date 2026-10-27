# Weekly review

What moved, what slipped, and what the brain is missing. Run once a week, after the lint pass.

## Procedure

1. Read the log entries since the last `brief | weekly` entry in [the log](../brain/wiki/LOG.md).
2. Read [brain/wiki/tasks.md](../brain/wiki/tasks.md): rows completed this week (from the log), rows overdue, rows due in the next seven days, rows with status `waiting` or `blocked` older than seven days.
3. Read `STATE.md` -> "Active Decisions" and the Decisions hub for pages with `status: open` older than fourteen days.
4. Note pages under any hub whose `updated` is older than ninety days and that are linked from an open task or an active project.

## Output shape

```
Week of <YYYY-MM-DD>:

Done this week
- <task> - <owner> - <belongs to>

Slipped
- <task> - was due <date>, now <date or "no new date"> - <owner>

Due next week
- <date> - <task> - <owner>

Stuck
- <task> - <waiting on / blocked by> since <date>

Decisions still open
- <title> - open since <date> - <link>

The brain is missing
- <a person, project, or term referenced but with no page; a stale page an open task depends on>
```

End with at most three suggested inputs the operator could supply to close the gaps. Log as `## [YYYY-MM-DD] brief | weekly`. If the review itself produced a lasting insight, file it as a page and log that as `ask`.

_Indexed in [Standing Queries](README.md)._
