# Tasks

Every open item this brain knows about, in one table. This is what the daily brief reads, so it has to be complete and current: a commitment that is not here does not exist.

## Rules

- **One row per open item.** A row needs all six columns. A row missing an owner or a due date is a lint error, because "Never file incomplete" in `AGENTS.md` applies here first.
- **Sorted by due date, earliest first.** Overdue rows sit at the top. Items with no fixed date use `open` in the Due column and sit at the bottom.
- **Belongs to** is a real link to the project, external, or system page the item attaches to. Never a bare name.
- **Source** is a real link to the file under `brain/sources/` that created or last changed the item.
- **Done items leave this table.** Move the row to [the log](LOG.md) as a dated `## [YYYY-MM-DD] ingest | ...` entry that says it was completed, and update the owner's and the project's page in the same change.
- **Status** is one of `open`, `waiting` (on someone or something named in Notes), `blocked` (with the blocker named in Notes and mirrored in `STATE.md` -> "Blockers").

| Due | Owner | Task | Belongs to | Source | Status / Notes |
|---|---|---|---|---|---|
| 2026-10-26 | [Joshua Clifford Reyes](people/joshua-clifford-reyes.md) | Send the Indusolutions quote and timeline to Camille | [Indusolutions website](projects/indusolutions-website.md) | [setup answers](../sources/2026/10/2026-10-28-setup-answers.md) | open - wanted before Camille's second Indusolutions budget meeting |
| open | [Joshua Clifford Reyes](people/joshua-clifford-reyes.md) | Review Camille's updated clarifications and questions doc | [Indusolutions website](projects/indusolutions-website.md), [Micheline Paquette website](projects/micheline-paquette-website.md), [Khoury Construction website](projects/khoury-construction-website.md) | [setup answers](../sources/2026/10/2026-10-28-setup-answers.md) | open - doc updated 2026-10-19; the quotes depend on it |
| open | [Joshua Clifford Reyes](people/joshua-clifford-reyes.md) | Send the Micheline Paquette quote and timeline; answer whether completion by end of Dec 2026 is possible | [Micheline Paquette website](projects/micheline-paquette-website.md) | [setup answers](../sources/2026/10/2026-10-28-setup-answers.md) | waiting - on the doc review |
| open | [Joshua Clifford Reyes](people/joshua-clifford-reyes.md) | Send the Khoury Construction quote and timeline | [Khoury Construction website](projects/khoury-construction-website.md) | [setup answers](../sources/2026/10/2026-10-28-setup-answers.md) | waiting - on the doc review |
| open | [Joshua Clifford Reyes](people/joshua-clifford-reyes.md) | Send the Auto Industrial Paints quote, with a separate monthly WP Care price | [Auto Industrial Paints website](projects/auto-industrial-paints-website.md) | [quote brief](../sources/2026/10/2026-10-24-aip-quote-brief.md) | open - Camille wants it "as soon as you can"; basis depends on [open questions](decisions/2026-10-28-aip-quote-open-questions.md) |
| open | [Joshua Clifford Reyes](people/joshua-clifford-reyes.md) | Send Camille the Auto Industrial Paints open questions (repo `docs/open-questions.md`, a to l) | [Auto Industrial Paints website](projects/auto-industrial-paints-website.md) | [operator note](../sources/2026/10/2026-10-28-note-aip-repo-setup.md) | open |
| open | [Joshua Clifford Reyes](people/joshua-clifford-reyes.md) | Review the brief for the other business in the Indusolutions group (pitched 2026-10-24) | [Indusolutions](external/indusolutions.md) | [setup answers](../sources/2026/10/2026-10-28-setup-answers.md) | open - business not yet identified |
| open | [Joshua Clifford Reyes](people/joshua-clifford-reyes.md) | Add the studio-wide Figma link | [Joshua Clifford Reyes](people/joshua-clifford-reyes.md) | [setup answers](../sources/2026/10/2026-10-28-setup-answers.md) | open |
| open | [Madz](people/madz.md) | Virtual coffee with Camille | [Madz](people/madz.md) | [setup answers](../sources/2026/10/2026-10-28-setup-answers.md) | open - Madz offered a Friday; not confirmed |

---

_Linked from [the map](README.md). Completed items live in [the log](LOG.md)._
