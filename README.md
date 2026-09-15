# Spec-Driven Development Repo

> Core idea: **Documents are the "source code"; software and firmware are "compiled artifacts".**
> Keep `requirements/`, `contracts/`, and `acceptance/`, and even if you delete `src/`,
> you can regenerate a **functionally equivalent** piece of software/firmware that **passes all acceptance tests**.

---

## How to Start a New Project (Quick Start)

This is a **GitHub template repository**. The end goal of getting it from GitHub is usually **cloud backup + team collaboration**,
so below we spell out each way to obtain it, and how to actually connect it to the cloud.

### Step 1: Get the files onto your machine (pick one)

**A. Use this template (most recommended)**
1. On this repo's page, click **Use this template → Create a new repository** to create a new repo under your account.
2. Clone it locally:
   ```
   git clone https://github.com/<your-account>/<new-repo>.git
   cd <new-repo>
   ```
   - Traits: the new repo is already on your GitHub (**cloud backup/collaboration from the start**), clean history, no template build history.

**B. Download ZIP**
1. On this repo's page, click **Code → Download ZIP** and unzip it where you want.
   - Traits: a plain folder, no `.git`, not yet on the cloud (for backup/collaboration see Step 3).

**C. Clone then reset**
```
git clone https://github.com/Davis-Tsai/claude-spec-driven-dev-template-en.git <new-project>
cd <new-project>
rm -rf .git        # ⚠️ Must do this: clears the template's history and remote, otherwise commit/push will pollute the template
```
   - Traits: obtains files via git, but **must be reset** to be clean; after reset it's the same as B (local only, not yet on the cloud).

> **How to choose**: want cloud backup/collaboration from the start → **A**; just try locally/offline first → **B**; used to `git clone` → **C (remember to reset)**.

### Step 2: Initialize (open Claude Code)
Open Claude Code in your new project folder, and as your first message:

> Please initialize this project per CLAUDE.md

Claude Code will run the version-control self-check (if there is no Git, `git init` + first commit, install the pre-commit hook), remind you to set the references Base, then begin development.

### Step 3: Connect cloud backup / collaboration
- **A**: already done (the new repo is on your GitHub).
- **B / C**: once you have a local commit, create a GitHub repo yourself and push (after pushing it's identical to A):
  ```
  # First create an empty new repo on GitHub, then:
  git remote add origin https://github.com/<your-account>/<new-repo>.git
  git branch -M main
  git push -u origin main
  ```
  (With GitHub CLI, in one step: `gh repo create <new-repo> --private --source=. --remote=origin --push`)

> Note: connecting to GitHub is **done by you**; per `CLAUDE.md §0.5`, the AI will not create a remote or push on its own.

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
