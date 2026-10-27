# Brain Context

## How to Work Here

- **Ground what you assert.** Any claim about this organization is backed by a wiki page or a source file you read this session, named by path. If you have not checked, say you have not checked rather than describing it.
- **Check, don't recall.** A date, an owner, a status, whether a page exists: if reading a file settles it, read it. Never answer from memory of an earlier session.
- **Capture before you integrate.** Every input that will change the wiki is saved first as a dated file under `brain/sources/`, including something the operator says in chat. The header is in [Sources](brain/sources/README.md). Then integrate.
- **Never file incomplete.** A fact or commitment needs the five fields under "Mandatory Fields". Propose what you can infer, with the evidence, and ask for the rest one question at a time. Never fill a blank by guessing.
- **Check before you file.** Run every item under "Edge-Case Checks" against the current wiki. Report each hit with both sources named, and wait for the operator to resolve it or accept the flag on the page.
- **Integrate in one pass.** Update every affected page, cross-link both ways, update the hub, update [Tasks](brain/wiki/tasks.md), append one entry to [the log](brain/wiki/LOG.md), run `scripts/lint.sh`.
- **Where a page and its source disagree, the source wins.** Correct the page, flag the correction on it, and log it.
- **Answer plainly.** Answer first. One idea per sentence. Dates as `YYYY-MM-DD`, names as they appear on the person page, numbers as the source gives them. After an ingest: what was filed, which pages changed, what was flagged - three short lines. One question at a time. End with what you need from the operator, or say the work is done. No preamble, no filler, no closing offers.
- **Enter the wiki through the map.** Start at [brain/wiki/README.md](brain/wiki/README.md) and follow links. Never load `brain/wiki/` wholesale. `brain/sources/` is immutable and `repos/` belongs to other projects - skip both in repo-wide sweeps.
- **You maintain the wiki; the operator reads it.** Filing, cross-linking, hubs, the map, and the tasks table are your job, done without being asked. An answer with lasting value is filed back as a page. See [Wiki](brain/wiki/WIKI.md).
- **Working in a linked repo.** Before touching anything under `repos/`, read that repo's own `AGENTS.md` and `STATE.md`. Its rules govern its code; this file governs knowledge, tasks, and people. Its handoffs and decisions stay there. When the work is done, mark the task in [Tasks](brain/wiki/tasks.md) and log it here. See [Repos](repos/README.md).
- **Delegate work that reads far more than it writes.** A sweep across many pages, a triage through a long transcript: hand it to a sub-agent with a self-contained brief, ask for page links rather than page contents, and re-check anything you are about to act on.
- **Sessions run side by side.** Before any other work, create your session file with `scripts/session.sh start <slug>`, read the other live files under `sessions/`, and report any overlap in scope. Checkpoint there at each milestone - an ingest done, a decision, a blocker - not in `STATE.md`, which is shared and changes rarely. End by closing the file into [the log](brain/wiki/LOG.md) and adding one row to `STATE.md` -> "Session Handoff". When the conversation turns to unrelated work, end the session and suggest a fresh one. See [Sessions](sessions/README.md).
- **Re-read before you write, and edit in place.** `STATE.md`, the log, the tasks table, every hub and the map can change under you while another session runs. Re-read one immediately before editing it, never from the copy loaded at session start. Change it with an anchored edit that names the text it replaces, never a whole-file rewrite. A file that changed since you read it is a conflict: re-read, merge, and say so.

## Organization

Decacreatives is a web design and development studio that builds client websites, mostly on SiteGround hosting with WordPress and Elementor Pro. This brain tracks the studio's client projects, quotes and commitments: who asked for what, by when, and what has been agreed. Camille Malloch owns the studio and brings in the clients; Joshua Clifford Reyes (Lead Developer) and Madz (Developer) build the sites. Each client site has its own code repository under `repos/`.

- **Perspective:** `both`

## Operator

The operator is the person this brain works for. "I", "me", and "my" in a question mean the operator. The daily brief is filtered to the operator by default.

- **Operator:** Joshua Clifford Reyes - page: `brain/wiki/people/joshua-clifford-reyes.md`

## Page Types

One page per entity, one folder per type, one `README.md` hub per folder listing every page with a one-line summary. **No folder is pre-created.** Create a hub the first time a page belongs there, and link the hub from [the map](brain/wiki/README.md) in the same change. Frontmatter fields listed here are required on every page of that type, in addition to `type`, `updated`, and `sources`.

| Folder | One page per | Create it when | Required frontmatter |
|---|---|---|---|
| `brain/wiki/people/` | Person, internal or external. A team gets a page here only if work is attributed to it rather than to a person | Named as owner, contact, or participant | `role`, `org` |
| `brain/wiki/projects/` | Stream of work with a goal and an end | A commitment attaches to it | `status` (`active`, `paused`, `done`), `owner`, `due` |
| `brain/wiki/external/` | Client, partner, vendor of this organization | An outside organization is named | `kind`, `contact` |
| `brain/wiki/systems/` | Product, tool, internal system, or the index page of a code repo | A fact is about how it works or who runs it, or a repo is cloned into `repos/` | `kind` (`repo` for a repository, then `path`, `remote`), `owner` |
| `brain/wiki/processes/` | Repeatable way of doing something | The same steps are described a second time | `owner` |
| `brain/wiki/decisions/` | Dated decision, or an open one | Something was decided, or should have been | `status` (`open`, `accepted`, `superseded`), `date` |
| `brain/wiki/topics/` | Concept or domain term | Referenced from two pages with no page of its own | none beyond the common three |

Decision filenames carry the date: `2026-09-15-halcyon-date-change.md`. Everything else is a plain kebab-case slug.

## Mandatory Fields

Required for any fact that will change a page or create a commitment. Infer what you can from the input and the wiki, show each inference with its evidence, ask for the rest. One question at a time. Nothing is filed until all five are answered.

| Field | Question it answers | Where it lands |
|---|---|---|
| What | The fact or commitment, in one sentence | The page body, or a row in `brain/wiki/tasks.md` |
| Who | People involved, and the single owner if it is a commitment | Person pages, the Owner column |
| When | The date it applies, and the due date if it is a commitment | Frontmatter, the Due column, the log heading |
| Where it belongs | Which project, external organization, system, or topic it attaches to | Which page changes, which hub |
| Source | Who said it, when, through which channel | The capture header of the source file |

## Edge-Case Checks

Run every check against the current wiki for every completed fact, before any page changes. Report each hit with both sources named. The operator resolves it or accepts the flag on the page.

1. **Contradiction** - a page currently claims a different deadline, owner, status, or number.
2. **Cascade** - the change moves other things: dependent tasks after a shifted deadline, items owned by someone who is leaving.
3. **Ambiguity** - the name matches two people, two projects, or a project and a client.
4. **Unknown entity** - a person, project, organization, or system with no page. Ask for the minimum facts and create the page.
5. **Stale reference** - the input concerns something the wiki marks done, closed, or superseded.
6. **Overcommitment** - one owner now holds two items due the same day, or an item due after its project ends.
7. **Orphan fact** - it attaches to no existing page and no page type. It needs a home before it is filed.
8. **Unanswered question** - the input implies a decision nobody recorded. Name it and file it in `brain/wiki/decisions/` as `open`.
9. **Repo not ready** - a task names a repo under `repos/` whose own `STATE.md` shows a blocker or a failing build.
10. **Live session overlap** - a path you are about to change sits in another live session's Scope or Touched list under `sessions/`. Report it, then coordinate, work elsewhere first, or ask the operator.

## Operations

| Operation | When | Done when |
|---|---|---|
| **Capture + Ingest** | Any input arrives, in chat or in `brain/inbox/` | Source file written with header; five fields complete; checks run and reported; every affected page updated and cross-linked; hub and `brain/wiki/tasks.md` current; one log entry; `scripts/lint.sh` clean |
| **Ask** | Any question | Answered from pages reached via the map; each claim names its page; lasting answers filed as a page and logged as `ask` |
| **Brief** | Each working day, and weekly | Run per [prompts/daily-brief.md](prompts/daily-brief.md) or [prompts/weekly-review.md](prompts/weekly-review.md); logged as `brief` |
| **Lint** | Script after every ingest; full pass weekly | Per [prompts/lint.md](prompts/lint.md); errors fixed; result recorded in `STATE.md` -> "Lint Status"; logged as `lint` |
| **Session** | First and last thing in every session | File created under `sessions/` before other work and the others read; checkpoints written to it; at the end one `session` log entry, one row in `STATE.md` -> "Session Handoff", and the file removed |

Never report an ingest done with a lint error outstanding, and never make lint pass by deleting what it points at unless that is the correct fix.

## Git Workflow

- **Commits.** One commit per ingest, brief, or lint pass, on `main`, prefixed with the operation: `ingest: Halcyon launch moved to 2026-09-18`, `lint: weekly pass`, `chore: ...` for anything else. Small and atomic.
- **Before committing or pushing.** Confirm with the operator first, unless they have said to proceed.
- **Stage only what your session touched.** Never `git add -A` or `git commit -a` on a shared working tree; either sweeps in another session's half-written files. The Touched list in your session file is the staging list, and `scripts/session.sh end` prints it as a `git add` line.
- **`repos/` is never committed from here.** Work inside a linked repo follows that repo's own git workflow.

## Safeguards

**Never overridable:**

- **Never edit a source.** Not reformatted, not corrected. A wrong source gets a newer source that says so.
- **Never delete knowledge.** A claim is superseded by a dated entry naming what replaced it; a page is marked, not removed.
- **No invented facts.** Every claim on a page links to a source. A claim with no source is labeled unverified.
- **No guessing at intake.** A missing mandatory field is a question, never an assumption.
- **No secrets.** Credentials, tokens, and anything the organization has said not to store are redacted at capture, and the redaction is named in the source header.
- **No destructive command without confirmation** - `rm -rf`, `git reset --hard`, force push, anything inside `repos/` that the repo's own Safeguards would gate.

**Structural** - the operator can override one by name, and the override is recorded in `STATE.md` -> "Active Decisions":

- **Page Types**, above.
- **Markdown conventions** - the closed all-caps set, kebab-case slugs, dated filenames for sources and decisions, frontmatter, `YYYY-MM-DD` everywhere, no orphans, no bare angle-bracket placeholders, no headings inside blockquotes. The rules and their reasons live in [Wiki](brain/wiki/WIKI.md).

**House style:**

- Plain hyphen `-` in prose you write, never an em dash or en dash. Anything under `brain/sources/` and `repos/` is unaffected.
- No `Co-Authored-By:` lines in commits.

**Decacreatives:**

- **No client credentials.** Never store SiteGround, WordPress admin, hosting, or API credentials. Record only where they are kept.
- **No personal contact details on pages.** Phone numbers and personal emails (for example from WhatsApp exports) stay out of wiki pages unless the operator asks; redact them at capture.
- **`docs-local/` is never committed.** It holds local client briefs, transcripts and mockups; ingest from it by capturing into `brain/sources/`.
- **`repos/` is never committed here.** Each client site has its own repository.
- **Spelling.** **Indusolutions** (never Indosolutions or Indudolutions); **Decacreatives** as one word.

## Instruction Hierarchy

When instructions conflict:

1. **Safety and security** - the never-overridable Safeguards above.
2. **The operator's explicit instruction** in this session, including a deliberate override of a lower tier. Name the rule you are setting aside and record the decision.
3. **What the sources say** - a file under `brain/sources/` you read this session. Where a page disagrees with its source, the source wins; fix the page and flag it.
4. **What the wiki says** - pages reached through the map. Where this file disagrees with a page about a fact, the page wins and this file is corrected.
5. **Structural Safeguards** - Page Types and the markdown conventions.
6. **The rest of this file.**

Inside `repos/<name>/`, that repo's own `AGENTS.md` takes the place of tiers 4 to 6 for anything about its code.

## State Tracking

`STATE.md` is the live index - read it at the start of every session. It carries its own maintenance rules; follow them. History goes to [the log](brain/wiki/LOG.md) and knowledge to the wiki ([the map](brain/wiki/README.md)); see [Wiki](brain/wiki/WIKI.md) for the split. Your own session's handoff lives under [sessions/](sessions/README.md) while it runs and in the log once it ends; `STATE.md` -> "Session Handoff" points only at finished sessions' log entries.

---

<!-- ai-knowledge-base-template:version=v2 -->
_Generated from `ai-knowledge-base-template` v2. When migrating to a future version, update this line via the corresponding migration in the template's `patches/` directory._
