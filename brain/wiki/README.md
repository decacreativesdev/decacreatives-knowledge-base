# Map

The single entry point into this brain. Start here and follow links to what the task needs; never load `brain/wiki/` wholesale.

> **Standing convention - keep this blockquote.** Every markdown file in the repo must be reachable by a real link, from here or from another hub. Add a doc's link in the same change that creates or moves it, one line each, so the map stays scannable. An unlinked file is an orphan - treat it as a bug, not a style nit. Use real markdown links (`[Title](file.md)`), never backtick paths: a backtick path renders as code and creates no traversable edge. See [Wiki](WIKI.md) for the full convention.

## How this brain is organized

- **[Wiki](WIKI.md)** - the layers, the page types, the five operations, the linking and naming rules. Read this first if you are new here.
- **[Tasks](tasks.md)** - every open item: owner, due date, what it belongs to, and the source that created it. The daily brief reads this.
- **[Log](LOG.md)** - what happened and when, newest first. One line per operation, grep-able. Read on demand.
- **[Sources](../sources/README.md)** - every input, saved as a dated file the moment it arrives. Immutable.
- **[Inbox](../inbox/README.md)** - the drop zone for files not yet ingested.
- **[Repos](../../repos/README.md)** - how code repositories are cloned here and indexed under Systems.
- **[Standing queries](../../prompts/README.md)** - the daily brief, the weekly review, and the lint pass.
- **[Sessions](../../sessions/README.md)** - one file per AI session that is open right now: its intent, scope, touched paths and handoff. How several terminals share this brain.

## Hubs

Each hub is a folder with its own `README.md` listing every page inside it with a one-line summary. **No hub ships with the template.** Create one the first time a page belongs there, per `AGENTS.md` -> "Page Types", and link it here in the same change.

- **[People](people/README.md)** - one page per person: studio members, client contacts, the operator
- **[Projects](projects/README.md)** - one page per client website
- **[External](external/README.md)** - the clients Decacreatives builds for
- **[Systems](systems/README.md)** - one index page per code repository
- **[Decisions](decisions/README.md)** - dated decisions, accepted or open

---

_This map is the top of the wiki - see [Wiki](WIKI.md)._
