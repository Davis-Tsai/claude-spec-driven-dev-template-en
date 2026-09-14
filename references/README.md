---
title: References — Guide
status: Ongoing
---

# References

> Input materials consulted when writing specs (datasheets, communication standards, vendor docs, research/meeting notes, screenshots…).
> **The registry to fill in is `references/registry.md`.** This file holds only the norms; the actual files live in Google Drive and are **not committed to git**.

## Scope & boundaries (important)
- **References are input, not the truth.** The project's truth is always in `contracts/`.
- **Extract key facts into `contracts/` / ADRs** (a spec must not depend on a link or file staying alive — it remains valid even if the link/file breaks).
- **Actual files live in Google Drive, not in git** (to avoid bloating the repo).

## Where to put files in Drive
- **Personal projects → My Drive.**
- **Company projects → must use a Shared Drive** (files are owned by the team; links don't break when someone leaves, and a successor gets access via team membership).
- In Drive, organize by category (`datasheets` / `standards` / `vendor-docs` / `notes` / `captures`…), matching the "Category" column in the registry.

## How Claude reads them
- Claude **may read all files and subfolders under the `references\` directory tree at the declared Base** (see the authorization note in `registry.md`).
- Mounted as a local `G:\` path, Claude can read it (PDFs too); a **`https://drive.google.com/...` URL cannot be opened directly** — use the `G:\` path.
- For efficiency: when you know which file, **name that file/section**; for large PDFs read only the needed sections rather than loading everything into context.

## How to cite
- When you need traceability in `requirements/PRD.md`, an ADR, or `charter/reverse-spec-provenance.md`, write "per `REF-003`" to trace back to the source.

## Who maintains it
- **Base (paths) → set by the user**: Claude cannot know your Drive path / drive letter, so you fill this line (or Claude asks you once).
- **The registry (REF rows) → auto-maintained by Claude**: after Claude reads the references directory, or you hand it a file, it **automatically adds/updates the corresponding REF row** (id, category, title, Base, location, version, one-liner); you do not hand-edit the table.
- **What "auto" means**: Claude syncs the table **while working on this project** (reading the references directory / receiving a file you give it), not as a background watcher. If you drop files into Drive outside a session, next time just ask Claude to "sync references".
- The registry is a **living index**: its status stays "Ongoing" and it is **not subject to the finalize / change-management flow** (what needs strict control is `contracts/`).
