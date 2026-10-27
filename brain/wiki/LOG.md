# Log

The chronological record of this brain: every ingest, every filed answer, every brief, every lint pass, every decision, every session. Append-only, newest first, never rewritten. Correct an earlier entry with a newer one that names it.

This file is **never loaded at session start**. It exists so `STATE.md` can stay short. Read it when you need to know what happened or why.

**Entry format.** Every entry heading has the same shape, so the file is parseable with plain tools:

```
## [YYYY-MM-DD] <operation> | <title>
```

The operation is one of `ingest`, `ask`, `brief`, `lint`, `decision`, `session`. The body is one to four bullets: what came in or was done, which pages changed (as real links), what was flagged, what is still open. The last five entries are `grep "^## \[" brain/wiki/LOG.md | head -5`.

## [2026-10-28] session | repo-remotes

- Ran 2026-10-28 00:52 to 00:58 with Claude Code. Intent: record GitHub remotes for the four client repos.
- Touched: the [remotes note](../sources/2026/10/2026-10-28-note-repo-remotes.md), [Systems](systems/README.md) and its four pages, [Tasks](tasks.md), this log, `STATE.md`.
- Where it ended: remotes filed; AIP repo page restored after an overwrite; lint 0 errors.
- Next: clone or scaffold indusolutions, khoury-construction, micheline-paquette into `repos/`; update `repos/auto-industrial-paints/STATE.md` (still says "No remote yet") from inside that repo.

## [2026-10-28] session | aip-suppliers-flag

- Recorded the operator's answer on AIP suppliers; touched one source and this log. Lint 0 errors.

## [2026-10-28] decision | AIP suppliers are site content, not External pages

- Rise Distributors and PYM Coatings, named in the AIP mockups, get no External pages: they are content on the client's site, not studio relations. Resolves the flag in the AIP ingest entry below. [operator note](../sources/2026/10/2026-10-28-note-aip-suppliers.md)

## [2026-10-28] session | aip-repo-setup

- Ran 2026-10-28 00:17 to 00:36 with Claude Code. Intent: install ai-driven-template into repos/auto-industrial-paints and assess AIP sources.
- Touched: repos/auto-industrial-paints/ (not committed here), the two AIP sources, the AIP project, external and system pages, [Decisions](decisions/README.md), hubs, the map, [Tasks](tasks.md), this log, `STATE.md`.
- Where it ended: repo setup done; brain ingest done; lint 0 errors.
- Next: send Camille the AIP open questions; quote AIP with WP Care; create the remote.

## [2026-10-28] ingest | Auto Industrial Paints brief and repo setup

- Captured the [AIP quote brief](../sources/2026/10/2026-10-24-aip-quote-brief.md) (Dropbox link redacted) and the [operator note](../sources/2026/10/2026-10-28-note-aip-repo-setup.md); repo `repos/auto-industrial-paints/` set up from `ai-driven-template` v4.1.
- Changed: [AIP website](projects/auto-industrial-paints-website.md), [AIP](external/auto-industrial-paints.md), [AIP repo](systems/auto-industrial-paints.md), new [Decisions](decisions/README.md) hub with [mockups reference only](decisions/2026-10-28-aip-html-mockups-reference-only.md) (accepted) and [quote open questions](decisions/2026-10-28-aip-quote-open-questions.md) (open), [Tasks](tasks.md) (quote row updated, one row added), hubs and the map.
- Flagged: AIP brief dated the same day Camille pitched an Indusolutions group business (operator says different companies); review rounds 3 vs 2; suppliers Rise Distributors and PYM Coatings named in mockups, no pages created.
- Open: the clarifications doc and WhatsApp transcript are still not captured in full.

## [2026-10-28] ingest | GitHub remotes created for the four client repos

- Source: [operator note](../sources/2026/10/2026-10-28-note-repo-remotes.md).
- Changed: [Systems](systems/README.md) and all four repo pages ([auto-industrial-paints](systems/auto-industrial-paints.md), [indusolutions](systems/indusolutions.md), [khoury-construction](systems/khoury-construction.md), [micheline-paquette](systems/micheline-paquette.md)). Completed and removed from [Tasks](tasks.md): "Create the GitHub remotes for the four client repos" (owner Joshua Clifford Reyes).
- Flagged: repo not ready - `repos/auto-industrial-paints/STATE.md` says the final design is blocked on Figma and quote accuracy depends on its open questions a to e; it also still says "No remote yet". Remote there is named `deca-industrial`.
- Correction: this ingest rewrote the body of the AIP repo page over the aip-repo-setup session's version without re-reading it; the setup facts were restored from the [setup note](../sources/2026/10/2026-10-28-note-aip-repo-setup.md), but the earlier wording is lost.

## [2026-10-28] session | setup

- Brain set up from `ai-knowledge-base-template` v2 for Decacreatives; perspective `both`; operator [Joshua Clifford Reyes](people/joshua-clifford-reyes.md); tool config `CLAUDE.md` only; vendored LLM Wiki source kept. Answers captured in [setup answers](../sources/2026/10/2026-10-28-setup-answers.md).
- Seeded: [People](people/README.md) (5), [Projects](projects/README.md) (4), [External](external/README.md) (4), [Systems](systems/README.md) (4 repo index pages, folders empty, no remotes), 9 rows in [Tasks](tasks.md). Confirmed inferences: org name from the git remote; four projects, people and deadlines from `docs-local/` and the WhatsApp transcript; `repos/indosolutions` and `docs-local/specs/indosolutions` renamed to `indusolutions`.
- Assumptions in `STATE.md` -> "Active Decisions": operator owns all four projects studio-side; Auto Industrial Paints is a client, unconfirmed.
- Next session: ingest `docs-local/transcripts/whatsapp/10272026.md` (redact phone numbers), then the briefs in `docs-local/specs/` and the 2026-10-08 clarifications doc; send the overdue Indusolutions quote; add repo remotes and the Figma link once they exist.

---

_Linked from [the map](README.md)._
