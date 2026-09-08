---
title: Design Decisions & Constraints
status: Ongoing
---

# Design Decisions & Constraints

> This document lets you **understand in one read why this template is designed the way it is, and what constraints each decision brings**.
> When you want to know "why do it this way" or "what does this cost," look here.
> For the operational details of each rule, see `CLAUDE.md`; for this project's own open items, see `charter/open-questions.md`.
>
> Format: each item = **Decision** | **Why** | **Constraint / Cost** (the trade-off you must accept).

---

## A. Core Philosophy

### A1. Spec-driven: documents are the source, code is an artifact
- **Why**: makes "regenerating without relying on code, using only documents" possible.
- **Constraint**: every functional change must go through documents first, one extra step compared to "just writing code."

### A2. Only "functionally equivalent restoration," not bit-level copying
- **Why**: generating from the same document twice will produce different variable names / file splits, but consistent behavior.
- **Constraint**: don't expect regeneration to produce "identical" code; **what is guaranteed is passing the same set of acceptance tests**.

---

## B. Hardware/Software Strategy

### B1. Firmware + spec can be regenerated; PCB / schematic go into Git for preservation, not regenerated
- **Why**: routing, EMC, and analog circuits depend heavily on physical tuning and cannot be restored from pure text.
- **Constraint**: the hardware's "physical design files" must be preserved as assets in `hardware_build/`; you cannot delete them and expect regeneration.

### B2. Hardware acceptance uses manual measurement, not automated testing
- **Why**: hardware correctness must rely on actual measurement with oscilloscopes / ammeters, etc.
- **Constraint**: the hardware's "restoration success" cannot be proven automatically like software; manual recording of measured values is required.

### B3. One template covers software / hardware / integrated hardware+software
- **Why**: no need to maintain multiple templates.
- **Constraint**: software-only or hardware-only projects will have empty folders; you must declare the project type in `scope.md` and mark unused documents "N/A".

---

## C. Truth & Structure

### C1. `contracts/` is the single source of truth; code generation reads only requirements + contracts + acceptance
- **Why**: avoids inconsistency from defining the data model in multiple places; avoids the AI referencing old code and carrying forward its style, drifting from the documents.
- **Constraint**: the diagram in `ERD.md` is only a reading aid; in a conflict, `contracts/` always prevails; to change the data model, change `contracts/`.

### C2. Versioning is left to Git; frontmatter keeps only "status"
- **Why**: hand-written version numbers / dates are prone to inaccuracy, and Git is inherently the version history.
- **Constraint**: to see "this document's history," use `git log`; the document does not record versions internally.

### C3. Folders are classified by function (not by phase number)
- **Why**: documents are revised repeatedly over the lifecycle, and functional classification is more durable than "one-off phases."

---

## D. Template Portability & Initialization

### D1. Use `CLAUDE.md` as the "AI operations manual," so the template carries its own brain
- **Why**: Claude Code automatically loads `CLAUDE.md` when a new conversation opens; copy it to a new project and the rules come along.
- **Constraint**: **only effective for Claude Code**. Other AIs (ChatGPT/Gemini/Cursor) will not read it automatically.

### D2. Run a version-control self-check before starting development
- **Why**: ensures the new project starts under a clean local Git from the very beginning.
- **Content**: no repo → `git init`; inherited the template's `.git` → strongly recommend resetting; connecting to GitHub → **entirely left to the user**, the AI does not touch it.

### D3. Do not bring `.git` when copying; watch out for hidden files
- **Why**: bringing `.git` pollutes the template history and can push to the wrong repo.
- **Constraint**: `.githooks/` and `.gitignore` are hidden files easily missed when copying; if a hook is missed, the protection fails (the AI will remind you during initialization).

---

## E. Status Flow & Change Management

### E1. Status: Draft → In Review → Final (+ Revising / N/A)
- **Promotion authority**: `Draft→In Review` the AI may do; `In Review→Final` **only the user** can press.
- **Why**: finalization is a human-gated checkpoint that determines "when code generation can begin."

### E2. Before finalizing, the AI first runs the "pre-finalize check"
- **Why**: ensures traceability has no gaps, contract syntax is valid, and hardware specs do not conflict, so that "Final" is reliable.

### E3. Final documents cannot be edited directly; follow change management
- **Why**: lets the full modification process be visible in the future, and keeps the functional documents always up to date.
- **Process**: enter "Revising" → discuss with the AI → synchronously update PRD/ERD/contract/acceptance → record one entry in `changes/change-log.md` → return to "Final".
- **Constraint**: changing something already Final is "heavier"; it requires keeping records and synchronizing multiple documents.

---

## F. Document & Code Synchronization

### F1. Spec-first: bypassing documents to hand-edit `src/` directly is forbidden
- **Why**: once code is allowed to run ahead, "documents are the truth" breaks down.
- **Constraint**: if you hand-edit code temporarily, you **must immediately back-fill** the documents and change-log, otherwise it counts as drift.

### F2. Rely on acceptance tests to judge "whether code conforms to the contract"
- **Why**: passing tests is a harder guarantee than eyeball comparison.

### F3. The pre-commit hook automatically blocks desync
- **Why**: runs tests automatically before commit and blocks if they fail, preventing drift at the mechanism level.
- **Constraint**: the test commands are centralized in `acceptance/run-tests.sh`, and **must be filled in after the tech stack is finalized** to actually take effect; don't casually skip with `--no-verify`.

---

## G. Tech Stack

### G1. The template is technology-neutral; record one ADR per actual selection
- **Why**: not hard-coding technology keeps the template general; the ADR locks in "why this was chosen," so regeneration won't pick a different technology and become non-equivalent.
- **Constraint**: once selected, record an ADR and fill the test commands into `run-tests.sh`.

---

## H. Trust in Reverse Spec-ing

### H1. Reverse spec-ing: code is the truth, documents must be proven faithful to it
- **Why**: when filling in an existing implementation as the spec, the direction of trust is the reverse of forward development—forward relies on tests to prove "the code is right"; reverse must prove "the document is right."
- **Approach**: reverse documents default to `In Review`, must retain **provenance**, build a **coverage matrix**, and undergo **independent verification**, recorded in `charter/reverse-spec-provenance.md` (see `CLAUDE.md §4.5`).
- **Constraint / Cost**: one extra round of verification compared to "trusting the AI out of thin air"—but this is precisely the source of credibility; future people rely on these traces to judge how far it can be trusted.

---

## Further Reading
- This project's open questions: `charter/open-questions.md`
- Full operational rules: `CLAUDE.md`
- Decision details (architecture): `requirements/decisions/` (ADR)
- Change history: `changes/change-log.md`
- Glossary: `charter/glossary.md` | Definition of Done: `charter/definition-of-done.md`
- Risk register: `charter/risk-register.md` | Environment & secrets: `ops/environment.md`
