# Standing Queries

The questions this brain is asked on a schedule, each with a fixed procedure and a fixed output shape so the answer looks the same every time. `AGENTS.md` -> "Operations" names when each runs. A standing query is logged in [the log](../brain/wiki/LOG.md); it is not filed as a page unless the answer has lasting value.

| Query | Run | What it produces |
|---|---|---|
| [Daily brief](daily-brief.md) | Each working day, or on "what do I need to finish today?" | Overdue and due-today items for the operator, then the week, then blockers and open decisions |
| [Weekly review](weekly-review.md) | Once a week | What moved, what slipped, what is due next week, what the wiki is missing |
| [Lint](lint.md) | After every ingest (script only) and weekly (full pass) | Structural findings from `scripts/lint.sh`, then the AI's meaning check |

Add a query here when you find yourself asking the same shaped question a third time. Keep the procedure short; the reasoning belongs in [Wiki](../brain/wiki/WIKI.md).

_Linked from [the map](../brain/wiki/README.md)._
