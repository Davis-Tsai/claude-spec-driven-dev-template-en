---
title: Reference Registry
status: Ongoing
---

# Reference Registry

> Norms are in `references/README.md`. **In this file: you set the Base; the registry table below is auto-maintained by Claude (you don't hand-edit the table).**
>
> **Filling in this registry = authorizing Claude to read**: once you declare the Base here, it means
> **Claude may read all files and subfolders under the `references\` directory tree at that Base**, to consult as reference during analysis.
> The table below is an **index** you keep (for `REF-ID` citation and quick lookup); it is **not a whitelist that limits reading** — Claude can also read files in the directory that aren't listed in the table.
> (For efficiency, Claude reads what's relevant to the current task and reads only the needed sections of large PDFs, rather than loading everything into context.)

## Base (root paths)

**How to fill in** (this section is for you to edit, not an example):
- One Base per Drive; **if you only use one Drive, keep just the `BASE-A` line**; add `BASE-B`, `BASE-C`… only when spanning Drives.
- Format per line: `` `LABEL`: `path` ``. Fill the path up to the **parent folder of `references`**, ending with `\`.
- The trailing parenthesis `(…)` is a **note for yourself** — keep, edit, or delete it; it does not affect Claude's reading.
- **Full path = the Base here + the "Location" column below.** When you change machine / move the project / switch Drive → change only the corresponding Base line; the table stays untouched.

**Fill-in area** (replace the below with your actual paths; delete lines you don't use):
- `BASE-A`: `G:\Shared drives\<your-project>\`  (company / Shared Drive)
- `BASE-B`: `G:\My Drive\<your-folder>\`  (personal / My Drive; delete this line if none)

> When Claude reads, it concatenates "Base + Location", e.g. `G:\Shared drives\<your-project>\` + `references\datasheets\ICM-42688.pdf`.

## Registry table
> ⚠️ Example — delete when starting real content: the rows below are format demonstrations (Claude clears these example rows when it first logs a real item).
> This table is auto-maintained by Claude: after reading the references directory or receiving a file you provide, it adds/updates the corresponding REF row.

| REF-ID | Category | Title | Base | Location (relative to that Base) | Version / Date consulted | One-liner |
|--------|----------|-------|------|----------------------------------|--------------------------|-----------|
| REF-001 | datasheet | Example: some IMU datasheet | BASE-A | `references\datasheets\ICM-42688.pdf` | Rev C / 2026-09-14 | gyro range, register settings |
| REF-002 | standard | Example: some protocol spec | BASE-A | `references\standards\xxx.pdf` | 2026-09 | packet format & timing |
| REF-003 | note | Example: personal research note | BASE-B | `references\notes\meeting-20260914.md` | 2026-09-14 | early selection discussion |

> **Category** (reference): `datasheet` | `standard` | `vendor-doc` | `note` | `capture` | other.
