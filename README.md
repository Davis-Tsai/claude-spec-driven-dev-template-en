# Spec-Driven Development Repo

> Core idea: **Documents are the "source code"; software and firmware are "compiled artifacts".**
> Keep `requirements/`, `contracts/`, and `acceptance/`, and even if you delete `src/`,
> you can regenerate a **functionally equivalent** piece of software/firmware that **passes all acceptance tests**.

---

## How to Start a New Project (Quick Start)

This is a **GitHub template repository**. There are three ways to get a clean project:

- **A. Use this template (most recommended)**: on this repo's page, click **Use this template → Create a new repository**,
  and GitHub produces a **brand-new repo with no build history**; just `git clone` it, and it inherently contains no template history.
- **B. Download ZIP**: download → unzip → the folder is your new project (no `.git`).
- **C. Clone then reset**: `git clone` this repo → delete `.git` and re-run `git init` (to avoid carrying over the template build history).

Then:
1. Open Claude Code in your new project folder.
2. **As your very first message, simply say:**

   > Please initialize this project per CLAUDE.md

   Claude Code will run the version-control self-check (if there is no Git, `git init` + first commit, and install the pre-commit hook), then begin development.
   The GitHub remote is handled by you; the AI will not connect or push on your behalf.

---

## Regenerable vs. Must-Preserve (Important Boundary)

| Object | Strategy | Reason |
|------|------|------|
| Software code (`src/`) | **Regenerable from documents** | Contracts + automated tests provide a hard guarantee |
| Firmware logic | **Regenerable from documents** | Logic is determined by pinout/timing/requirements |
| PCB, schematics, layout (`hardware_build/`) | **Kept in Git together, not regenerated** | Routing/EMC/analog depend heavily on physical tuning and cannot be restored from plain text |

---

## Deterministic Anchors (Rebuilding Relies on These Three)

| Anchor | Software | Hardware | Location |
|------|------|------|------|
| 1. Intent | What to do, for whom | Same as left | `requirements/PRD.md` |
| 2. Contract | Data model, API | Pinout, timing, electrical, BOM | **`contracts/` (single source of truth)** |
| 3. Correctness | Automated tests | Manual measurement procedures | `acceptance/` |

Plus **ADR** (`requirements/decisions/`) to lock in "why it was chosen this way", avoiding architectural drift on rebuild.

> **Single-source-of-truth principle**: the data model/interface is governed by `contracts/`. The diagrams in `requirements/ERD.md` are only a reading aid;
> on conflict, `contracts/` wins. **When generating code, I read only `contracts/`.**

---

## Folder Structure (Organized by Function)

```
.
├── charter/         Planning (scope, timeline, design decisions, open questions, glossary, DoD, risk register)
├── requirements/    Requirements and design (PRD, ERD, ADR, UI)
├── contracts/       Deterministic anchors: DB schema, API, hardware specs ← single source of truth
├── acceptance/      Acceptance: software automated tests + hardware manual measurement
├── changes/         Change log (modification history of finalized documents)
├── ops/             Deployment and operations (CI/CD, runbook, environment and secrets)
├── src/             Software artifact (disposable, can be rebuilt)
└── hardware_build/  Hardware artifact (PCB/schematics/firmware, kept under version control)
```

---

## Collaboration Loop (Together with Claude Code)

1. **Requirements**: you describe an idea → I write it as PRD / ERD / ADR.
2. **Contracts**: confirm and freeze `contracts/` (schema / API / hardware specs).
3. **Acceptance**: define "what counts as correct" → I turn it into `acceptance/` tests and measurement tables.
4. **Implementation**: you say "generate from the documents" → I **read only `requirements/` + `contracts/` + `acceptance/`** to generate `src/` and firmware.
5. **Verification**: software runs the tests, hardware records manual measurements, proving the restoration succeeded.

### Rebuild Instruction Example
> "Please read only `requirements/`, `contracts/`, `acceptance/`, regenerate `src/` and the firmware,
> and ensure all tests in `acceptance/` pass."

---

## Document Conventions

- **Leave version control to Git**: do not hand-write version numbers or dates in the documents. To know "what version this document is", just look at `git log`.
- **Frontmatter keeps only information Git cannot infer**: currently just `status: Draft | In Review | Final | Revising | N/A`.
- **The template covers both software and hardware**: for a software-only or hardware-only project, just mark the unused dimensions' document status as "N/A" (see the project type in `charter/scope.md`).
- **Modifying finalized documents goes through change management**: first enter "Revising" → discuss with the AI → after changes, sync-update PRD/ERD/contract, and leave an entry in `changes/change-log.md` (see CLAUDE.md §4).
- **Spec-first**: feature changes change the documents first, then generate the code; do not bypass the documents and hand-edit `src/` directly.
- **Sync protection**: the pre-commit hook (`.githooks/`) runs `acceptance/run-tests.sh` before a commit, blocking "the contract changed but the code did not keep up" (test commands are filled in after the tech stack is finalized, see CLAUDE.md §5).
  - ⚠️ If you later **clone the project elsewhere**, the hook setting does not follow along; you must re-run `git config core.hooksPath .githooks` once.
- **Secrets do not enter version control**: keys/passwords use environment variables; `.env`/`*.key` etc. are already ignored; for setup see `ops/environment.md`.
- **Reverse spec-ing**: if the specs are reverse-extracted from an existing project, the documents default to "In Review", must cite their source, build a coverage matrix, and be finalized by a person only after independent verification (see `CLAUDE.md §4.5`, `charter/reverse-spec-provenance.md`).
- Use **Mermaid** for diagrams (plain text, version-controllable).
- Use **industry-standard formats** for contracts (SQL / OpenAPI / CSV) to ensure they are unambiguous.

> Want to understand **why this template is designed the way it is, and what choices and constraints there are**? See `charter/design-decisions.md` (overview of decisions and constraints).
>
> To maintain/improve this template, and how existing projects absorb improvements: see `MAINTAINING.md`.
- Each "change a document → regenerate" is a commit, with a message explaining which document was changed.
