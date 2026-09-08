---
title: Change Log — modification history of finalized documents
status: Ongoing
---

# Change Log

> **Purpose**: to centrally manage every modification to "finalized documents", so that in the future one can trace "what was changed, and why",
> while ensuring that related documents such as PRD / ERD / contract / acceptance are all kept in sync and up to date.
>
> **When to add an entry**: whenever a "finalized" document is to be modified — first change that document's status to "Revising",
> discuss the modification plan with the user, and once the plan is confirmed / the modification is complete, the AI adds an entry here,
> syncs all affected documents, and finally changes the status back to "Final".
>
> Numbering increments (CHG-0001, CHG-0002, ...) and entries are **never deleted**. The newest is added at the top.
>
> **Status linkage**: while a change is "Proposed", the corresponding document is in "Revising"; once the change is "Applied", the document is back to "Final".
> **Relationship to commits**: just include the CHG number in the commit message (e.g. `change(CHG-0003): ...`);
> the commit hash is only generated after committing, so it is optional — don't hold up the workflow just to fill in the hash.

---

## Entry Template (copy this block to add a change)

```
### CHG-NNNN: <one-line title>
- Date: <YYYY-MM-DD, or based on the git commit>
- Status: Proposed (document is "Revising") | Applied (document is back to "Final")
- Motivation / why the change:
- Summary of changes:
- Affected documents (all must be synced to the latest):
  - [ ] requirements/PRD.md (FR-___ / NFR-___)
  - [ ] requirements/ERD.md (traceability table, software/hardware boundary)
  - [ ] contracts/________ (schema / API / hardware spec)
  - [ ] acceptance/________ (AC-___ / HW-AC-___)
- Does code need regeneration: Yes / No (if yes, run the acceptance tests after regeneration)
- Related: ADR-____ (if it involves an architectural decision); associate the commit via this CHG number (hash optional)
```

---

## Change List

<!-- Add new changes above this line; the newest at the top. -->

(No changes yet. On the first modification of a finalized document, add CHG-0001 here.)
