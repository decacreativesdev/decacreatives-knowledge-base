# Wiki

How this brain's markdown stays **traversable** - for a person in an editor and for an agent following links - instead of piling up as disconnected notes. The rule spans the whole repo: no markdown file, wherever it lives, may be an orphan. `repos/` is the one exception, because it holds other projects that keep their own wikis.

`AGENTS.md` -> "Safeguards" -> "Markdown conventions" points here and carries none of the detail itself. These rules fire when you create, move, or link a file, not otherwise, so they live here rather than in every session's preamble.

## The layers

| Layer | Lives in | Holds | Loaded every session? |
|---|---|---|---|
| The schema | `AGENTS.md` | The rules the agent follows: page types, mandatory fields, edge-case checks, safeguards | Yes |
| Live index | `STATE.md` | The operator's focus, blockers, last handoff, active decisions, lint status | Yes - kept under 60 lines |
| The map | [brain/wiki/README.md](README.md) | The entry point: one link per hub plus the standing pages | No - entered, then traversed |
| Hubs | `brain/wiki/<type>/README.md` | Every page of one type, one line each with a summary | No - reached from the map |
| Pages | `brain/wiki/<type>/*.md` | Durable, cross-linked knowledge: one page per person, project, external org, system, process, decision, topic | No - reached from a hub or another page |
| Tasks | [brain/wiki/tasks.md](tasks.md) | Every open item with owner, due date, home, and source | No - read by the brief and by ingest |
| Raw sources | [brain/sources/](../sources/README.md) | Every input, saved as a dated file. Immutable | No - cited, never loaded wholesale |
| Inbox | [brain/inbox/](../inbox/README.md) | Files dropped but not yet ingested | No - drained by ingest |
| History | [brain/wiki/LOG.md](LOG.md) | One dated line per operation, newest first | No - read when history matters |
| Standing queries | [prompts/](../../prompts/README.md) | The daily brief, weekly review, and lint procedures | No - opened when run |
| Live sessions | [sessions/](../../sessions/README.md) | One file per AI session open right now: intent, scope, touched paths, where it is, next. Ephemeral, ignored by git | Read at session start, rewritten at each checkpoint |
| Linked repos | [repos/](../../repos/README.md) | Cloned code repositories, ignored by git, indexed under Systems | No - entered only when working in one |

The point of the split: the session preamble stays roughly constant-size however large the brain grows. Everything else is pulled in by following links. That is agentic search - follow links, grep, read on demand - not wholesale loading, and not embedding-based retrieval.

## Who writes it

**The AI writes the wiki; the operator reads it.** The tedious part of a knowledge base is not the thinking, it is the bookkeeping: cross-references, current summaries, noticing where new information contradicts an old claim. People abandon wikis because that cost grows faster than the value. An agent does not get bored and can touch a dozen pages in one pass, so the cost stays near zero.

The operator's job is to supply inputs, answer the intake questions, resolve the flags, and ask questions. Filing, cross-linking, updating hubs and the map, and keeping the tasks table true is the AI's job, done without being asked. The one layer neither of you rewrites is `brain/sources/`.

## Five operations

Everything that touches the wiki is one of these. `AGENTS.md` -> "Operations" carries the definition of done for each.

**Capture.** An input arrives - a sentence in chat, a file in the inbox, a forwarded email, a transcript. Before anything else, it is written as a dated file under `brain/sources/YYYY/MM/` with the header described in [Sources](../sources/README.md): who said it, when, through which channel, and what was redacted. Capture is what makes every later claim traceable. It is the first half of ingest, never skipped.

**Ingest.** The captured source is read and its facts extracted. Each fact that will change a page or create a commitment must carry the mandatory fields in `AGENTS.md`; the AI proposes what it can infer, with evidence, and asks for the rest one question at a time. Each completed fact is then run through the edge-case checks against the current wiki, and every hit is reported with both sources named before any page changes. Only then does the AI integrate: update every affected page, cross-link both ways, update the hub, update [Tasks](tasks.md), and append one entry to [the log](LOG.md). Where a new source contradicts a page, the contradiction is stated on the page with both sources linked. A silent overwrite loses the fact that two sources disagree.

**Ask.** A question is answered by entering at the map and following links, never by loading `brain/wiki/` wholesale and never from memory of an earlier session. Each claim in the answer names the page it came from. An answer with lasting value - a comparison, a timeline, a who-owns-what - is filed back as a page and logged as `ask`. A question the wiki cannot answer is logged as a gap.

**Brief.** A standing query with a fixed output shape, run from [prompts/](../../prompts/README.md). The daily brief reads [Tasks](tasks.md) filtered to the operator, the focus and blockers in `STATE.md`, upcoming dates, and the last few log entries. It is logged as `brief`, not filed as a page.

**Session.** Not an operation on the wiki but the frame around all of them, and the reason several terminals can share one brain. A session begins by writing its own file under [sessions/](../../sessions/README.md) and reading the others, checkpoints there instead of in `STATE.md`, and ends by closing that file into [the log](LOG.md) as a `session` entry with one pointer row left in `STATE.md`. The shared files - `STATE.md`, the log, the tasks table, the hubs, the map - are re-read immediately before every edit and changed in place, never rewritten from a stale copy.

**Lint.** A health check in two parts. `scripts/lint.sh` catches structure: orphans, broken links, missing frontmatter, tasks without owner or date, overdue items, unprocessed inbox files, filename casing. The AI catches meaning: contradictions between pages, claims a newer source has superseded, concepts referenced everywhere with no page of their own, missing cross-references. Run the script after every ingest and the full pass weekly.

## Roots, hubs, and edge cases

A **root** is an always-loaded entry point: `README.md`, `AGENTS.md`, `STATE.md`, and any tool config that plays the same part (`CLAUDE.md`, `.cursorrules`, `.windsurfrules`, `.github/copilot-instructions.md`). A root needs no inbound link. Everything else hangs off a **hub**: pages off their type hub, type hubs off the map, `brain/sources/`, `brain/inbox/`, `repos/`, and `prompts/` READMEs off the map, standing queries off `prompts/README.md`.

- **A markdown root should still link out**, or it is an island. A tool's `@` import is not an edge. Give each root at least one real `[Title](file.md)` link into the wiki.
- **A source is linked from the page or log entry that cites it.** Sources are not listed on the map; they are reached from whatever rests on them. A source nothing cites is an orphan, which usually means an ingest was never finished.
- **Links into `repos/` are external.** The folder is not committed, so the lint script reports them as unchecked rather than broken. Everything else under `repos/` is out of scope for sweeps.
- **Session files are ephemeral and exempt.** `sessions/<id>.md` is one live session's working state, ignored by git and deleted when the session ends, so it needs no inbound link and is checked for shape rather than for orphanhood. Only `sessions/README.md` is part of the graph.
- **Backticks mean "this literal string".** Use them when naming a file, never as a cross-reference.

## Markdown conventions

These are the structural Safeguards `AGENTS.md` defers to. The operator can override one by name, and the override is recorded in `STATE.md` -> "Active Decisions".

**Filenames.** Six system files are all-caps, and the list is **closed**: `README.md`, `AGENTS.md`, `CLAUDE.md`, `STATE.md`, `LOG.md`, `WIKI.md`. Never rename one and never add a seventh; the list is revised only by the template, at a version boundary, through a migration in `patches/`. **Every other markdown file is a lowercase kebab-case slug**: `marco-lee.md`, `halcyon-storefront-launch.md`, `2026-09-15-note-halcyon-launch.md`. Sources carry a date prefix. Decisions carry a date prefix. Exception: a name a platform resolves by exact spelling keeps its form (`CONTRIBUTING.md`, `LICENSE.md`, `SECURITY.md`, `.github/` templates). Non-markdown sources keep their original names.

**Frontmatter.** Every page under a hub folder opens with YAML frontmatter carrying at least `type` and `updated`, plus the fields its page type requires in `AGENTS.md` -> "Page Types". A `sources` list of relative links to the files the page rests on is expected on every page. Hub READMEs, the map, `tasks.md`, and `LOG.md` carry no frontmatter.

**Dates.** Always `YYYY-MM-DD`, in filenames, frontmatter, tables, prose, and log headings. Never "Friday" or "next week" in anything that is filed.

**No orphans.** Every `.md` file in the repo, outside `repos/`, must be reachable by a real link from a root. Link it in the same change that creates or moves it, and cross-link related pages both ways. A `[[wikilink]]` does not render on GitHub and creates no edge; a backtick path fails the same test.

**Two constructs that break renderers.** Never leave an angle-bracket placeholder as bare text: CommonMark treats `<name>` as a raw HTML tag and the page renders blank from there down. Wrap it in backticks. And never put a `#` heading inside a `>` blockquote; keep the prose in the blockquote and the shape in a fenced block beneath it.

## Further reading

The pattern - immutable sources, an AI-owned wiki, a schema file, an index, an append-only log, and the ingest, query, and lint operations - is Andrej Karpathy's LLM Wiki. A verbatim copy is vendored at [brain/sources/llm-wiki.md](../sources/llm-wiki.md) with its origin, pinned revision, and body hash in a header comment. Three things here are this template's own additions: the constant-size preamble, the repo-wide no-orphan rule, and the intake gate - mandatory fields and edge-case checks before anything is filed. The setup machinery is shared with its sibling, the `ai-driven-template` for code projects, whose generated repos this brain indexes under Systems. Back to [the map](README.md).
