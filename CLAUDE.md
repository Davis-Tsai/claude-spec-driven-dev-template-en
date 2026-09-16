# CLAUDE.md — AI Operating Manual

> This is a **Spec-Driven Development** repository.
> How you (Claude Code) work in this project is governed by this file. Read it in full before starting any work.
> The human-facing methodology explanation lives in `README.md`; this file is the **behavioral specification** for you.

---

## 0. The One-Sentence Principle

**Documents are the source code; code and firmware are compiled artifacts.** Your core job is to:
maintain the three documentation layers `requirements/` + `contracts/` + `acceptance/`, and when needed, **generate** or **regenerate** `src/` and firmware from them.

---

## 0.5 Project Initialization (Bootstrap) — Do This Before You Start Developing

This template is distributed as a **GitHub template repository** (`Use this template` / Download ZIP / `git clone`), and can also be copied as a folder directly.
**Trigger: the first time this project receives any development instruction, complete the following version-control self-check before doing any actual work.**

1. **Check whether this is a Git repository**: `git rev-parse --is-inside-work-tree`.
   - If it is **not** → run `git init` and make the first commit (a local action, safe, can be done directly).
2. **Check whether `.git` comes from the template itself**: `git remote -v` and `git log --oneline`.
   - Obtained via **Use this template** or **Download ZIP**: no template build history — this is normal, skip this step.
   - But if you used the template repo directly via `git clone` (remote points to the template repository, or the history contains the template's bootstrap commit `chore: initialize spec-driven dev template skeleton`)
     → **Stop and warn the user**: this is the template's history/remote, and continuing to commit/push will pollute the template.
     **Strongly recommend resetting**: `rm -rf .git && git init` (confirm once with the user before executing).
3. **GitHub is entirely left to the user**: the AI does not create a remote repo, does not `git remote add`, does not `git push`,
   and does not proactively ask whether to connect to GitHub. It only performs a local `git init` and local commits.
4. **Install the sync-protection hook**: after `git init`, run `git config core.hooksPath .githooks`,
   so that the §5 pre-commit acceptance-test protection takes effect (the hook ships with the template in `.githooks/`).
   - If `.githooks/` or `.gitignore` does not exist → **remind the user**: hidden files (starting with `.`) may have been missed when obtaining the template;
     please re-obtain the full contents via Use this template / ZIP (see README Quick Start).
   - ⚠️ The `core.hooksPath` setting is written in `.git/config` and **does not travel with version control**. If this project is later cloned elsewhere,
     the hook will not take effect automatically; you must re-run `git config core.hooksPath .githooks` in that clone.

5. **Remind the user to set the references Base**: if this project will use reference materials (datasheets / standards / vendor docs…),
   remind the user to set the **Base path** in `references/registry.md` (pointing to the references directory on Google Drive); see `references/README.md`.
   - The user can also **just paste the folder's `G:\` path to you**, and you fill/update the Base in the registry for them — no manual editing needed.

> Only begin subsequent development after completing the self-check and confirming you are in a clean local Git repository.

---

## 0.7 Project Type: Software? Hardware? Both?

This template covers both software and hardware. **Before starting work, read the "project type" in `charter/scope.md`**:

- Type is **software-only** → `contracts/hardware/`, `acceptance/hardware/`, and `hardware_build/` are **N/A**.
- Type is **hardware-only** → `contracts/data-schema.sql`, `contracts/api.openapi.yaml`, `acceptance/software/`, and `src/` are **N/A**.
- Type is **integrated hardware+software** → everything applies.

When handling **N/A** dimensions:
1. Do not force the user to fill in those documents, and do not treat them as "incomplete".
2. Mark those documents' frontmatter `status:` as `N/A`, and write a one-line note at the top of the file (e.g., "This project contains no hardware").
3. When generating/regenerating code, **skip** the N/A dimensions.

> Valid values for `status:`: `Draft | In Review | Final | Revising | N/A`.

---

## 1. Golden Rules (Not to Be Violated)

1. **`contracts/` is the single source of truth.** The data model / API / hardware specs are governed by `contracts/`.
   The diagrams in `requirements/ERD.md` are only a reading aid; if they conflict with `contracts/`, `contracts/` always wins.
2. **When generating code, read only `requirements/`, `contracts/`, and `acceptance/`.** Do not reference old `src/` code to "continue the existing style",
   otherwise you defeat the purpose of "being regenerable from the documents".
3. **`hardware_build/` (PCB / schematics / layout) is preserved, not regenerated.** Firmware "logic" can be regenerated from the documents,
   but **do not** attempt to generate PCB routing / analog circuits / EMC design from plain text — those are always governed by the existing files in `hardware_build/`.
4. **Leave versioning to Git.** Do not hand-write version numbers or dates in the documents. Frontmatter keeps only `status:`.
5. **Requirements must be traceable.** Every requirement has an ID (FR-xxx / NFR-xxx), mapped to an acceptance ID (AC-xxx / HW-AC-xxx).
   When changing a requirement, you must keep the traceability table in `requirements/ERD.md` and the tests in `acceptance/` in sync.
6. **Spec-first.** Any feature change **first changes the documents (PRD/contracts), then generates or updates the code accordingly**.
   It is **forbidden** to bypass the documents and hand-edit `src/` directly and call it done; if you hand-edited the code out of temporary necessity, you **must immediately back-fill** the corresponding documents and
   `changes/change-log.md`, otherwise it counts as drift. See §5 "Code Synchronization After Contract Changes".
7. **Secrets never enter version control.** Keys/passwords/certificates always use environment variables or a secret-management service; never hard-code them, never commit them.
   See `ops/environment.md`.

---

## 2. Folder Map

| Path | What it is | When you update it |
|------|--------|----------------|
| `charter/scope.md` | Project scope, stakeholders, KPIs | Project kickoff, scope change |
| `charter/timeline.md` | Timeline (Mermaid Gantt chart) | Schedule adjustments |
| `charter/design-decisions.md` | Overview of design decisions and constraints (why it is designed this way) | When there is a new methodology decision or constraint |
| `charter/open-questions.md` | List of methodology items to be discussed | When a methodology decision is pending or decided |
| `charter/glossary.md` | Glossary (unified terminology) | When a new important term appears |
| `charter/definition-of-done.md` | Definition of Done (DoD) | Cross-check before reporting "done" |
| `charter/risk-register.md` | Risk register | When discovering/updating a risk |
| `charter/reverse-spec-checklist.md` | Reverse spec-ing procedure (SOP) | When documenting an existing project (see §4.5) |
| `charter/reverse-spec-provenance.md` | Reverse spec-ing provenance record (only needed for reverse projects) | When documenting an existing project (see §4.5) |
| `ops/environment.md` | Environment variables, secrets, **toolchain readiness list** | Setting up env, handling secrets, when a tech-stack ADR is finalized |
| `changes/change-log.md` | Change log (modification history of finalized documents) | Each time a finalized document is modified (see §4) |
| `requirements/PRD.md` | Product requirements (intent layer, **no implementation**) | Requirement added/changed |
| `requirements/ERD.md` | Technical structure, hardware/software boundary, traceability table | Sync after PRD changes |
| `requirements/decisions/` | ADR architecture decision records | Every major technical decision |
| `requirements/ui/` | UI/UX prototypes and flows | Interface design |
| `references/README.md` | References norms (boundaries, Drive split, how Claude reads) | Mostly unchanged |
| `references/registry.md` | Reference registry (Base + link list pointing to Google Drive; **the file to fill in**) | When there is new reference material |
| `contracts/interfaces.md` | Interfaces contract (packet/serial/command; the interface truth for non-web projects) | When defining/changing interfaces |
| `contracts/data-schema.sql` | DB structure contract (**use if applicable**, else N/A) | DB model finalized/changed |
| `contracts/api.openapi.yaml` | API contract (**use if applicable**, else N/A) | Interface finalized/changed |
| `contracts/hardware/` | Pinout, timing, electrical, BOM | Hardware spec finalized/changed |
| `acceptance/software/` | Software acceptance (Gherkin, executable) | Defining/changing acceptance criteria |
| `acceptance/hardware/` | Hardware acceptance (manual measurement procedures) | Defining/changing measurement procedures |
| `ops/` | CI/CD, runbook | Deployment and operations |
| `src/` | Software artifact (disposable, can be rebuilt) | Generated from documents |
| `hardware_build/` | Hardware artifact (kept under version control) | Preserving physical design files |

---

## 3. Rules for Updating Documents (by Document Type)

### PRD (`requirements/PRD.md`)
- Write only "what to do, for whom, and why"; **no technical implementation**.
- Give each requirement a unique ID. After adding a requirement, **proactively remind the user** whether to sync the ERD and acceptance.

### ERD (`requirements/ERD.md`)
- This is the technical translation of the PRD. Its contents must be consistent with `contracts/`; on conflict, this is what gets changed (unless a decision calls for changing the contract).
- Maintain the "requirements traceability table": PRD requirement → module → contract → test.

### Contracts (`contracts/`)
- This is where the most care is needed. **If a document's status is "Final", do not modify it arbitrarily**;
  to change a contract, first confirm with the user, and record an ADR explaining the reason for the change (because a contract change cascades into code regeneration).
- Use standard formats (SQL / OpenAPI / CSV), keeping them unambiguous.
- **Interface truth depends on project type**: non-web/DB projects (embedded/protocol/CLI) use `contracts/interfaces.md` (packet/serial/command) as the interface contract; `data-schema.sql` and `api.openapi.yaml` are **used only if applicable**, otherwise marked `N/A`.

### Hardware contracts (`contracts/hardware/`)
- **Pinout records not just pin↔signal, but each pin's "internal configuration"**: AF/mux mode, GPIO push-pull/open-drain, pull-up/down, speed, voltage level.
- **For component-to-component / board-to-board connections, use the "Connection Configuration Matrix" in `pinout.md` to list both ends' configurations and check compatibility** (direction, voltage level, protocol mode, whether open-drain has a pull-up) — this is the key to regenerating firmware pin config and to verifying a connection in one place; don't let the configuration hide only in the code.
- **Safe state / fail-safe**: when an **actuator/relay/motor/safety-related output** is detected, require ① an **explicit safe-state decision** (which physical state = safe, per the hazard model); ② **fail-safe design** (the safe state is the one it passively falls to when de-energized/undriven, not held by continuous MCU output); ③ a `charter/risk-register.md` entry; ④ an `acceptance/` check that "all fault scenarios return to the safe state".

### Acceptance (`acceptance/`)
- Software uses Gherkin; each Scenario maps to one AC-ID, and each AC-ID maps back to a PRD requirement.
- Hardware uses manual measurement procedure tables; do not try to automate them into software tests.

### ADR (`requirements/decisions/`)
- A major decision = add one new record, incrementing the number, **never deleted**; when overturned, add a new one marked "supersedes ADR-XXXX".
- **Tech-stack selection must be recorded as an ADR**: when the database, backend/frontend framework, language, communication protocol, MCU/hardware platform, etc. are first selected,
  record one ADR for each, and reference its number in the tech-stack selection table of `requirements/ERD.md`.
  This is the key to "not selecting a different technology on regeneration" — without an ADR, the regenerated result may not be equivalent.
- After selecting the tech stack, remember to fill the corresponding test commands into `acceptance/run-tests.sh` (see §5), so the pre-commit protection actually takes effect.
- **Seed the toolchain list**: each time you record a tech-stack ADR (language/framework/DB/MCU/SDK/toolchain), add a corresponding row to the "Toolchain Readiness" list in `ops/environment.md`, and remind the user: this tool needs to be installed; later generation/build will use it.
- **Change criterion**: a **decision reversal** (e.g. switching compiler/build method) → add a new ADR "supersedes ADR-XXXX", marking the old one deprecated with its content preserved; a **mere clarification / pinning down a deferred point** (decision unchanged) → add an in-place "revision note". Both go through `changes/change-log.md`.

---

## 4. State Transitions and Change Management

`status:` lifecycle: `Draft → In Review → Final`; after finalization, if it needs modification it enters `Revising`, and returns to `Final` once changes are done.
(`N/A` is an orthogonal state, see §0.7.)

### Promotion Authority
- `Draft → In Review`: **the AI may promote on its own** (meaning "I think this is ready, please review").
- `In Review → Final`: **only the user can press this**. The AI can only advise, and cannot finalize on its own.

### Pre-Finalize Check (Especially for Contracts)
Before the user finalizes, the AI first runs and reports:
- Does every PRD requirement (FR/NFR) have a corresponding contract and acceptance (AC/HW-AC)? Any gaps in the traceability table?
- Are `data-schema.sql` / `api.openapi.yaml` syntactically valid and mutually consistent?
- Are the hardware contracts (pinout/timing/electrical/BOM) consistent with each other?

Report "ready to finalize ✅ / N items pending ⚠️", and let the user decide whether to finalize.

### Tech-stack Feasibility Verification (mandatory before finalizing a tech-stack ADR)
Before finalizing any ADR that selects a "device/SDK/framework/protocol/toolchain", the AI must verify and report:
- Does the SDK/tool support the **exact device model and silicon revision** (not just the chip family)? Source?
- Is the chosen **protocol/band/interface** actually supported by this option (avoid picking a similar-but-wrong one)?
- Does the **exact toolchain version exist and is it downloadable** (incl. legacy/archived)? Which compiler does the vendor officially pin?
- Attach a **traceable source** for each point (official site / release notes). If not found or in doubt → mark ⚠️; do not finalize on your own.
> Rationale: once the tech stack is finalized it cascades into code generation and much downstream; the cost of a wrong choice far exceeds a few minutes of verification before finalizing.

### Contract Freeze
A `contracts/` document marked "Final" = contract freeze; only after this is it appropriate to generate code at scale (see §5).

### Modifying Finalized Documents — Change Management Flow (Important)
Finalized documents **must not be changed directly**. To change one, follow this flow:

1. Change the document's status to **`Revising`**, which declares "this spec is about to change".
2. **Discuss the modification plan with the user** (how to change it, what it affects).
3. Once the plan is settled / the modification is complete, the AI does three things in one pass:
   - a. **Sync-update all affected documents** (PRD → ERD → contract → acceptance, keeping traceability consistent; do not change just one place).
   - b. **Add a change-log entry in `changes/change-log.md`** (incrementing the number; state the motivation, the change content, the list of affected documents, and whether code regeneration is needed).
   - c. Re-run the "pre-finalize check", and once it passes, change the status back to **`Final`**.
4. Wrap up with a single commit whose message corresponds to the change number (e.g., `change(CHG-0003): adjust telemetry report fields`).

> Purpose: to both preserve the **complete modification process** (change-log) for the future, and guarantee that the **final functional documents are always up to date** (PRD/ERD/contract/acceptance in sync).

---

## 4.5 Reverse Spec-ing (Documenting an Existing Project)

When the task is "take the features/hardware of an **existing implementation** and fill them into the documents as specs" (rather than developing from scratch), the trust problem is the opposite of the forward direction —
**the code is the truth, and the documents must be proven faithful to it**. Therefore reverse-filled content must observe:

1. **Traceable source**: every reverse-filled spec must cite its source (which source file/document), so a person can spot-check it.
2. **Review gate (important)**: reverse-derived documents **default to status `In Review`** and note at the top of the file "source: reverse-extracted, pending verification".
   **The AI must not mark them `Final` on its own** (echoing the §4 promotion authority) — only someone who understands the project may promote them after verification.
3. **Coverage matrix**: build a "source-code item → document location" mapping table in `charter/reverse-spec-provenance.md`, exposing gaps to prove completeness.
4. **Independent adversarial verification**: use an independent pass (another agent or a person) to reverse-check for "no fabrication (in the document, not in the code), no omission (in the code, not in the document)", and record differences in the provenance.

> **Truth priority order (only during the reverse-extraction phase)**: as-built code > comments/file headers > old design documents; when the three conflict, the **actually executing code** wins
> (a common pitfall: comments/file headers describe an old design that was revoked).
> ⚠️ Once signed off and promoted to `Final`, switch back to forward mode — the documents/contracts are the truth (Golden Rules 1, 6), and from then on feature changes start with the documents.

**When executing, follow `charter/reverse-spec-checklist.md` (the procedure) step by step.** Record the entire process in `charter/reverse-spec-provenance.md`.
The strongest verification is the "round-trip regeneration test" (regenerating the code from the documents alone and running the original acceptance); it is costly and not required — do it when you have the capacity.

---

## 5. Generating / Regenerating Code

**Preconditions**:
- The relevant `contracts/` are finalized (see §4).
- **The build/test environment is ready** (see "Environment Readiness" below) — documents and pure logic can be generated first, but **before compiling / running tests / flashing**, the environment must be ready.

**Flow**:
1. Read only `requirements/` + `contracts/` + `acceptance/`.
2. Generate `src/` (software) and firmware logic.
3. Run the tests in `acceptance/software/`; only when all pass is it complete. For hardware, list the corresponding manual measurement items for the user.
4. One generation = one commit.

**Rebuild instruction** (the user might say something like this):
> "Please read only requirements/, contracts/, acceptance/, regenerate src/ and the firmware, and pass all tests in acceptance/."
When you receive this kind of instruction, **first delete or ignore the influence of the old `src/` contents**, and regenerate purely from the documents.

### Environment Readiness
Generating/regenerating "documents and pure logic" can be done first; but **before compiling, running tests, or flashing**, the environment must be ready:
1. Derive the required toolchain from the finalized tech-stack ADRs (SDK, compiler, RTOS, runtime, DB, flasher…).
2. Check the "Toolchain Readiness" list in `ops/environment.md`: **missing items → stop, provide an install list (official links + versions + verify commands); do not pretend the environment is ready**.
3. **Install policy** (see `ops/environment.md`): **the AI does not install on its own**; it only gives links/steps/verify commands; a package-manager install requires explicit user consent to run on their behalf, never silently.
4. **"Can generate code" ≠ "can build/verify code"**: when tools are missing, code can be generated, but **do not report "built/tests passed"** — state clearly "skipped: toolchain not installed".

**Trigger cheat-sheet**
| When | Action |
|------|--------|
| A tech-stack ADR is finalized | Seed the toolchain list in `ops/environment.md` + remind to install |
| Before generating code in §5 | Environment-readiness gate; if items are missing, provide an install list |
| First time compiling/running tests | Verify versions, update readiness status; do not falsely report pass if not ready |
| Hardware bring-up | Remind about the flasher/drivers (e.g., XDS110 VCP, UniFlash) and physical board needs |

### Portable-Logic-First (recommended pattern for firmware/embedded)
Much firmware logic (protocol codec, state machines, data formats, threshold math) is actually **chip-independent**. Recommended split:
- **Portable core** (pure language, no platform dependency) → can be **compiled directly with a host compiler + unit-tested** (`host-selftest`), so the **contract can be verified even without the target SDK installed** (packet layout / checksum / state transitions…).
- **HAL interface + platform stubs** (GPIO/UART/RF/WDT, SDK-dependent) → exist as `TODO` stubs when not ready; fill in once the environment is ready.
> Therefore **generate portable logic first and verify the contract via host tests**, leaving the platform-dependent layer until the environment is ready (echoing the "Environment Readiness" gate).
> `acceptance/run-tests.sh` may add: if a host compiler is detected → compile and run the pure-logic host tests (so pre-commit actually has tests to block with).

### Code Synchronization After Contract Changes
- **Spec-first**: feature changes always change the documents first, then update the code (§1 Golden Rule 6). Code is not allowed to jump ahead.
- **Update strategy**: use a **local update** for small changes (change only the affected code); when changes accumulate or drift is suspected, do a **full regeneration** to verify.
- **Sync is determined by tests**: contract changes → first update the corresponding tests in `acceptance/` → run the tests, and only when all pass does "code is synced" hold.
- **Automatic protection**: this repository installs a pre-commit hook (see §0.5 installation), which automatically runs `acceptance/run-tests.sh` before a commit;
  if it fails, the commit is blocked, mechanically preventing "the contract changed but the code did not keep up". Test commands are maintained centrally in `acceptance/run-tests.sh`.
- **Skip ≠ pass**: when `run-tests.sh` cannot detect the toolchain, it should **skip gracefully and `exit 0`** (not block the commit), but its output must clearly state "**skip ≠ pass**"; once the toolchain is ready it starts actually running, so the user isn't misled by a green light.
- Record each sync result in the "whether code regeneration is needed" column of `changes/change-log.md`.

---

## 6. Commit Conventions

- Each "document change" or "regeneration" is a separate commit.
- The message explains which document was changed / why it was regenerated (e.g., `feat(contracts): add device configuration API` or `chore: regenerate src/ from contracts`).
- No need to write version numbers in the documents — `git log` is the version history.
- Before a commit, the pre-commit hook automatically runs the acceptance tests (see §0.5, §5); do not casually skip it with `--no-verify`.

---

## 6.5 Using the Supporting Documents
- **Glossary**: naming and terminology are governed by `charter/glossary.md`; add a row whenever a new important term appears.
- **Definition of Done**: before reporting "done", cross-check each item against `charter/definition-of-done.md`.
- **Risks**: when you discover a risk or a change in one, record it in `charter/risk-register.md`.
- **Environment/Secrets**: when you need configuration or keys, see `ops/environment.md`; never commit secrets (Golden Rule 7).
- **References**: `references/` holds input material (pointers into Google Drive, not the truth). **The registry in `references/registry.md` is auto-maintained by you (Claude)** — after reading the references directory or receiving a file the user provides, automatically add/update the corresponding REF row; the Base (paths) is set by the user. You may read the entire `references\` directory tree under that Base as reference for analysis. See `references/README.md`.
  - **Judge each Base line individually**: an angle-bracket `<...>` placeholder = unset; a concrete path (no `<>`) = set, **go read it**. If any Base is a concrete path, read it; **do not misjudge the whole references as unset just because other Base lines are still placeholders or example REF rows remain**. On first real registration, clear unused BASE placeholder lines and example rows.

---

## 7. Your Common Actions Checklist

- The user describes a new idea → help them write it into the PRD (give it an ID) → remind them to sync the ERD / acceptance.
- The user wants to "finalize a contract" → confirm the content, add an ADR if necessary, and let the user promote the status.
- The user says "generate/regenerate" → execute per §5.
- The user asks "where is this project now" → look at each document's `status:` and `charter/open-questions.md`.
- **Proactively flag "I can do this step"**: for anything automatable (package install, running tests, generating/regenerating files, git operations, checking the environment…), tell the user you can do it for them — don't let them manually do what you can do; outward/destructive actions still require consent first.
