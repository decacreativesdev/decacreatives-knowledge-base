# Brain State

A lean, living **index** of where things stand right now - the current view, not history. History lives in `brain/wiki/LOG.md`, knowledge in the wiki (`brain/wiki/README.md`), every open item in `brain/wiki/tasks.md`; see [brain/wiki/WIKI.md](brain/wiki/WIKI.md) for the split.

## Context Maintenance

This file loads into every session, so it stays roughly constant-size however large the brain grows. **Budget: 50 lines. When it is over, prune before you append.** It is shared by every session that is open, so it holds only what all of them need: never a running handoff, which belongs in that session's own file under `sessions/`.

| Section | Keep only | Move the rest to |
|---|---|---|
| Focus | the operator's next few days, as pointers into `brain/wiki/tasks.md` - never a copy of the table | nowhere - the table is the record |
| Blockers | items with status `blocked`, one line each | `brain/wiki/tasks.md` Notes column |
| Session Handoff | the last three finished sessions, as pointers to their log entries - never the handoff text, never a live session (`ls sessions/` is that list) | `brain/wiki/LOG.md` as a `session` entry |
| Active Decisions | decisions and assumptions that still shape current work | a page under `brain/wiki/decisions/`, plus a `decision` log entry |
| Known Gotchas | at most 8, unresolved and still relevant | a page under `brain/wiki/processes/` or `brain/wiki/topics/` |

**Checkpoint cadence:** checkpoint your session file under `sessions/` at every milestone - an ingest done, a decision, a blocker - because sessions close abruptly. Touch this file only when something every session needs has changed: focus, a blocker, a decision, the lint result, a finished handoff row. Re-read it immediately before editing; another session may have changed it.

## Lint Status

2026-11-27 - lint: 0 error(s), 0 warning(s); inbox empty.

## Focus

- Madz, due 2026-11-30: November reports for the two Haulage sites, waiting on Bitwarden - see [Tasks](brain/wiki/tasks.md)
- Madz: waiting on Camille's replies to the 2026-11-27 WhatsApp round-up - see [Tasks](brain/wiki/tasks.md)
- Confirm whether timelines and add-ons reached Camille - see [Tasks](brain/wiki/tasks.md)

## Blockers

- All quotes depend on the client answers in Camille's updated [clarifications doc](https://docs.google.com/document/d/1qGNDIlJEaZrE8TgGYMnH38nEt1-c3nk1l4ukFTF5VZU/edit), not yet reviewed (updated 2026-10-19).

## Session Handoff

| Session | Intent | Log entry |
|---|---|---|
| 2026-11-01-ocean-blue-whatsapp | Ocean Blue quote v2 and quote sheets recorded as sent | [log 2026-11-01](brain/wiki/LOG.md) |
| 2026-11-09-camille-catch-up | Camille catch-up, WP Care invoices and Haskour quotes sent | [log 2026-11-27](brain/wiki/LOG.md) |
| 2026-11-27-haskour-cpa-repo-setup | Haskour CPA repo set up; quote amounts and build approach recorded | [log 2026-11-27](brain/wiki/LOG.md) |

## Active Decisions

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-10-28 | Perspective `both`: wiki org-wide, brief filtered to the operator | operator, setup |
| 2026-10-28 | Standard stack: SiteGround + WordPress + Elementor Pro | operator's org description |
| 2026-11-25 | Deadlines: Indusolutions end Dec (Jan fine, no hard date); Micheline hard 2027-01-15; Haskour CPA hard 2027-02-15; other projects pushed to 2027 | Camille, WhatsApp |
| 2026-10-28 | Each client site has its own repo under `repos/`, never committed here | operator, setup |
| 2026-11-01 | Camille holds the sheet prices, not the 2026-10-28 drafts | [sheets sent](brain/wiki/decisions/2026-11-01-quote-sheets-sent.md) |
| 2026-11-24 | WP Care is USD 20 per site per month, reports on the last day of each month, Madz owns it | [WP Care](brain/wiki/projects/wp-care-website-management.md) |
| 2026-10-28 | Assumption: operator owns all four projects on the studio side | the operator is quoting; owners not otherwise known |
| 2026-10-28 | Assumption: Auto Industrial Paints is a client, unconfirmed | operator: "I think so" |

## Known Gotchas

- Sessions may be run by Madz, not the operator named in `AGENTS.md`: confirm who "I" is before crediting a note.
- Micheline's deadline moved within a day (end Jan, then mid Jan, end Dec preferred): always use the latest message.
- Madz may miss WhatsApp notifications on their laptop.
- WhatsApp timestamps are in the sender's local zone; Camille is in Australia (+61), so dates can be a day off.

