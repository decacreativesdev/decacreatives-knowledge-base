# Inbox

The drop zone. Put a file here when you have something for the brain but are not in a conversation with it: a transcript, an export, a PDF, a screenshot, a note you wrote on your phone.

**How it drains.** At the start of a session, or when asked, the AI lists what is here and ingests each file: it moves the file to `brain/sources/YYYY/MM/` with a capture header, asks you for any mandatory field it cannot infer, runs the edge-case checks, updates the pages and [the tasks](../wiki/tasks.md), and logs it. A file leaving this folder is the signal that it has been processed.

**Rules.**

- Nothing in here is knowledge yet. The wiki does not cite inbox files.
- The lint script reports the number of unprocessed files. More than a few for more than a few days means the brain is falling behind; ask for an ingest pass.
- Do not edit a file after dropping it. If you have a correction, drop a second file.
- This `README.md` is the only permanent file here.

Back to [the map](../wiki/README.md).
