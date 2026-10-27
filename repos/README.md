# Repos

Code repositories the organization works in, cloned here one per subfolder. **Everything in this folder except this file is ignored by git.** The brain never tracks the clones and never copies anything out of them. Each repo keeps its own memory in its own files.

## Adding a repository

1. Clone it: `git clone <url> repos/<name>` - use the repo's own name as the folder.
2. Tell the AI: "Index the repo in repos/`<name>`". It creates one page at `brain/wiki/systems/<name>.md` with `kind: repo` and links it from the Systems hub and, if relevant, from the projects and people it serves.

## What the index page holds

Pointers and connections only, never code facts and never copied status:

- Purpose in one line, the remote URL, the local path `repos/<name>/`.
- Real links into the repo: its `README.md`, `AGENTS.md`, `STATE.md`, its docs map and its Canvas index if it was generated from the `ai-driven-template`.
- Which projects, external organizations, and people in the brain it serves, as links.
- Open decisions that concern it, as links into `brain/wiki/decisions/`.

When you ask about the repo, the AI follows the links and reads its `STATE.md` live, so the answer is current without anything being duplicated.

## Working in a repository from here

Before touching anything under `repos/<name>/`, the AI reads that repo's `AGENTS.md` and `STATE.md`. The repo's rules govern its code; this brain's rules govern knowledge, tasks, and people. The repo's session handoffs, decisions, and build status stay in the repo. When the work is done, the AI marks the task in [the tasks table](../brain/wiki/tasks.md) and logs it here; it does not paste the repo's handoff into the brain.

If a task names a repo whose `STATE.md` shows a blocker or a failing build, the AI flags it before starting. That is the "repo not ready" check in `AGENTS.md`.

## Lint

Links from wiki pages into `repos/` are reported as external and unchecked, because the target is not committed. Repo-wide greps and the orphan sweep skip everything here except this file.

Back to [the map](../brain/wiki/README.md).
