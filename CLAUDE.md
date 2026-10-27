# Brain Guidelines
@AGENTS.md
@STATE.md

<!-- README.md intentionally NOT imported - it is reference material, and importing it
     every session wastes context. Read it on demand. -->
<!-- The `@` lines are Claude Code import directives, not wiki links - they must stay `@`.
     This file is a wiki *root*: it needs no inbound link, but the real `[Title](file.md)`
     links below are its outbound edges into the graph. -->

The `@` lines above import the rules ([AGENTS.md](AGENTS.md)) and the current state
([STATE.md](STATE.md)) into every session, so items 1-2 of the contract are already done -
start by reading Session Handoff in `STATE.md`.

## Session start

3. The wiki is entered at [brain/wiki/README.md](brain/wiki/README.md) (the map) and traversed by links -
   never loaded wholesale. Open items are in [brain/wiki/tasks.md](brain/wiki/tasks.md). History is in
   [brain/wiki/LOG.md](brain/wiki/LOG.md), read on demand. See [brain/wiki/WIKI.md](brain/wiki/WIKI.md).
4. Every input is captured to [brain/sources/](brain/sources/README.md) first, and filed only when the five
   mandatory fields are complete and the edge-case checks have run and been reported -
   `AGENTS.md` -> "How to Work Here".
5. Before working inside `repos/<name>/`, read that repo's own `AGENTS.md` and `STATE.md`; its
   rules govern its code. See [repos/README.md](repos/README.md).
6. When instructions conflict, follow the Instruction Hierarchy in `AGENTS.md`.
7. Sessions run side by side. Create your own file first with `scripts/session.sh start <slug>`,
   read the other live files under [sessions/](sessions/README.md), report any overlap, checkpoint
   there rather than in `STATE.md`, and close it into the log when you finish.

## Working on long tasks

Claude Code's sub-agents are the mechanism for the delegation rule in `AGENTS.md` - a sweep
across many pages or a triage through a long transcript goes to a sub-agent with a
self-contained brief that asks for page links, not page contents. During a long ingest, keep
findings outside the context window by checkpointing your session file.

## Context and checkpoints

Another Claude Code window may be open on this same brain. Re-read `STATE.md`, the log, the
tasks table and any hub immediately before editing it, edit in place with an anchored change,
and treat a "file changed on disk" notice as a conflict to merge, not noise. Stage only the
paths in your session's Touched list - never `git add -A`.

Answer plainly, ground what you assert, and never file incomplete - `AGENTS.md` carries all
three rules, and they are the ones that matter most here.
