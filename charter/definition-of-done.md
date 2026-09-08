---
title: Definition of Done (DoD)
status: Ongoing
---

# Definition of Done

> "Done" means more than just the code running. A requirement/task is complete only when it **simultaneously satisfies** all of the following conditions.
> Before reporting "done," the AI should verify against this checklist item by item. Adjust per project.

## Software Features
- [ ] The corresponding PRD requirement has a unique ID, and the `ERD.md` traceability table is updated
- [ ] Related contracts (schema / API) are finalized and mutually consistent
- [ ] `acceptance/software/` tests are written and all pass
- [ ] Code is generated from documents, not hand-modified bypassing documents (or hand-modifications have been back-filled into documents, see golden rule 6)
- [ ] Committed, and pre-commit tests pass
- [ ] If a "Final" document was changed, `changes/change-log.md` has one entry recorded

## Hardware Features
- [ ] Hardware contracts (pinout / timing / electrical / BOM) are finalized and consistent
- [ ] The corresponding manual measurement procedure (`acceptance/hardware/`) is defined
- [ ] Measured values are recorded and meet the pass criteria
- [ ] Physical design files (schematic / PCB) are stored in `hardware_build/`

## General
- [ ] Wording conforms to `charter/glossary.md`
- [ ] Related risks have been reviewed (`charter/risk-register.md`)
