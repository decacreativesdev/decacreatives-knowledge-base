# Sources

Every input this brain has ever received, saved as a dated file the moment it arrived: a sentence the operator typed in chat, a meeting transcript, an email, a document, an exported chat thread. This is the raw-sources layer of [the wiki](../wiki/WIKI.md), and every claim on every page links back to a file in here.

## Rules

- **Don't edit sources.** They are the record of what was received. A source that turns out to be wrong gets a newer source that says so; the old one stays.
- **This brain's writing conventions stop at this folder.** A source keeps its author's dashes, headings, spelling, and formatting. If a compliance sweep flags a file in here, the sweep is wrong.
- **Chat counts.** When the operator says something that will change the wiki, the AI writes it down here first, as a note, with the operator as the source. Provenance for a fact told in conversation is exactly as important as for a pasted document.
- **Filing.** `brain/sources/YYYY/MM/YYYY-MM-DD-<slug>.md`, where the date is when the input was received and the slug says what it is: `2026-09-15-note-halcyon-launch.md`, `2026-09-16-standup-transcript.md`, `2026-09-16-email-priya-sso-credentials.md`. Non-markdown inputs (`.pdf`, `.csv`, `.json`) keep their original filename under the same dated folder.
- **Every source has a header.** The header is the only thing the AI writes into a captured file, and it sits above the content as an HTML comment so the content stays verbatim:

  ```markdown
  <!-- SOURCE
       Captured:   2026-09-15
       From:       Joshua Reyes (operator), relaying Priya Nair
       Channel:    chat note | email | meeting | document | export | repo
       Fidelity:   verbatim | paraphrased by the AI from chat | converted from PDF (tables lost)
       Redactions: none | credentials removed at line 12
       Ingested:   2026-09-15 - see brain/wiki/LOG.md -->
  ```

- **Redact at capture, and say so.** Credentials, tokens, personal identifiers the organization has said not to store: remove them before the file is written and name the redaction in the header. A source with a secret in it is a Safeguard violation, not a source.
- **Curate, don't rewrite.** Durable knowledge derived from a source lives in a wiki page that links to and summarizes it. The page changes; the source does not.
- **A source you cannot store still gets a record.** Behind a login, too large, or licensed against copying: write a citation file instead - what it is, who wrote it, when it was read, a version or hash if available, and which pages rest on it.
- **Flag contradictions, don't absorb them.** Where a new source disagrees with a page, the page says so with both sources linked.
- **A file in here is not done until it is ingested.** Ingest means: read, mandatory fields complete, edge-case checks run, pages updated, tasks updated, one log entry, lint clean. Until then it belongs in [the inbox](../inbox/README.md).

## What ships here

- **[llm-wiki.md](llm-wiki.md)** - Andrej Karpathy's "LLM Wiki", the pattern this brain is built on. [Wiki](../wiki/WIKI.md) is the page that summarizes it, which makes the pair a worked example of capture and ingest: raw source here, untouched; the reading of it in a wiki page that links back. The header carries the origin URL, the pinned revision, and a `sha256` of the body. Delete it if the organization has no use for the provenance - only that one citation depends on it.

Back to [the map](../wiki/README.md).
