# Decacreatives - Brain

Decacreatives is a web design and development studio that builds client websites, mostly on SiteGround hosting with WordPress and Elementor Pro. This brain tracks the studio's client projects, quotes and commitments: who asked for what, by when, and what has been agreed. It covers the whole studio, with the daily brief filtered to the operator. The AI maintains it from what people tell it, and answers questions with sources.

**Operator:** Joshua Clifford Reyes (Dash), Lead Developer

## How to talk to it

Open your AI tool in this folder. It reads `AGENTS.md` and `STATE.md` on its own; everything else it reaches by following links.

- **Tell it things.** Type what happened, or drop a file in `brain/inbox/`. Answer its questions until it says the input is filed. It will not file a task without an owner, a date, and a home.
- **Ask it things.** "What do I need to finish today?", "Where are we on X?", "Who owns Y?". Every answer names its source.
- **Work in a repo from here.** Clone a repo into `repos/`, ask the AI to index it, then say "let's build it". The AI follows that repo's own rules and marks the task done here when finished.
- **Health-check weekly.** Ask for a lint. The AI runs `scripts/lint.sh` and then reads for contradictions and gaps.

## Layout

| Path | What it is |
|---|---|
| `AGENTS.md` | The rules the AI follows: page types, mandatory fields, edge-case checks, safeguards |
| `STATE.md` | The current view: focus, blockers, a pointer per session, lint status. Always short |
| `brain/` | The vault: everything the AI writes, markdown and attachments only. Open it in Obsidian |
| [brain/wiki/README.md](brain/wiki/README.md) | The map. One link per hub; start here |
| [brain/wiki/tasks.md](brain/wiki/tasks.md) | Every open item: owner, due date, home, source |
| [brain/wiki/LOG.md](brain/wiki/LOG.md) | What happened and when, newest first |
| [brain/sources/](brain/sources/README.md) | Every input, as a dated file. Never edited |
| [brain/inbox/](brain/inbox/README.md) | Drop zone for files not yet ingested |
| [repos/](repos/README.md) | Code repositories cloned here, ignored by git, indexed under Systems |
| [prompts/](prompts/README.md) | Standing queries: daily brief, weekly review, lint |
| [sessions/](sessions/README.md) | One file per AI session that is open right now, so several terminals can work here at once. Ignored by git |
| `scripts/lint.sh` | Structural health check |
| `scripts/session.sh` | Start, checkpoint and end a session file |

Hub folders under `brain/wiki/` (people, projects, external, systems, processes, decisions, topics) are created by the AI the first time a page belongs there.

## References

- [Clarifications and questions for the 3 projects](https://docs.google.com/document/d/1qGNDIlJEaZrE8TgGYMnH38nEt1-c3nk1l4ukFTF5VZU/edit) - Google Doc, client answers maintained by Camille Malloch
- [decacreativesdev on GitHub](https://github.com/decacreativesdev) - the studio's GitHub organization
- WhatsApp group with Camille Malloch, Madz and the operator - day-to-day project chat (no link)
- Figma - studio-wide, link to be added

## Template Version

<!-- ai-knowledge-base-template:version=v2 -->
Generated from [ai-knowledge-base-template](https://github.com/LordDashMe/ai-knowledge-base-template) v2. The pattern is Karpathy's [LLM Wiki](brain/sources/llm-wiki.md); see [brain/wiki/WIKI.md](brain/wiki/WIKI.md).
