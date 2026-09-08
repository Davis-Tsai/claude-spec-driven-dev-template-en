---
title: Reverse-Spec Checklist
status: Ongoing
---

# Reverse-Spec Checklist

> When you need to document an "existing implementation" into a spec, follow these steps.
> Use alongside `CLAUDE.md §4.5` (rules) and `charter/reverse-spec-provenance.md` (record).

## Prerequisite Principles (most important)
- **as-built code = highest truth (only during the reverse-extraction phase)**: code > comments/headers > old design documents/PDFs. When the three conflict, the **code that will actually execute** prevails.
  (Common pitfall: what a header/comment describes is the **revoked old design**, e.g., "send N packets in a burst" has actually been changed to single-shot.)
  - ⚠️ Scope boundary: this "code-first" **holds only during reverse extraction**. Once a document is signed off and promoted to `Final`, the project switches back to **forward mode**—
    documents/contracts are then the truth (golden rules 1, 6), and from then on any functional change goes through documents first, following change management.
- Reverse documents are always marked `In Review` first; **marking them `Final` on your own is forbidden**.
- Clearly distinguish "**target value vs guaranteed value**" and "**implemented vs work-in-progress (WIP)**".

## Steps

### A. Preparation
- [ ] Confirm the location and scope of the existing project (software / hardware / integrated).
- [ ] Create `reverse-spec-provenance.md`, fill in "0 Applicability declaration," "1 Sources list," "2 Method".

### B. Extraction
- [ ] Read the main documents + source code + acceptance/reports; **correct the documents' claims against the code**.
- [ ] Parallelize the work (product/requirements, hardware, software interfaces/acceptance) to speed things up.

### C. Fill in the Spec (status = In Review)
- [ ] Mark each spec item with its **provenance** (which file/document).
- [ ] Cross-check concrete values (pinout, frequency, packet fields, thresholds, tolerances) against the source code one by one.
- [ ] Clearly annotate WIP/untested items; do not treat them as finalized.
- [ ] For unused dimensions (e.g., no DB/REST), mark "N/A" and use a suitable contract instead (e.g., packet/serial protocol).

### D. Coverage Matrix
- [ ] In provenance §3, list "source code item → document location," exposing gaps.
- [ ] Estimate coverage.

### E. Independent Adversarial Verification (must not be skipped)
- [ ] Have an **independent** round (another agent / person) cross-check: **no fabrication** (in document, not in code), **no omission** (in code, missing from document).
- [ ] Record differences in provenance §4; **fix the corresponding documents** then back-fill the disposition.

### F. Sign-off
- [ ] Someone who knows the project verifies → signs off in provenance §6 → only then promote the related documents from `In Review` to `Final`.

> (Optional · strongest) **Round-trip regeneration test**: regenerate code using only the documents and pass the original acceptance, proving the spec suffices to rebuild. High cost; do it when you have the capacity.
