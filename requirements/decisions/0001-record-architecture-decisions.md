---
title: ADR-0001 Adopt Architecture Decision Records
status: Final
---

# ADR-0001: Adopt Architecture Decision Records (ADR)

## Status
Accepted

## Context
This project uses spec-driven development, and code and hardware design will need to be regenerated from the documents in the future.
If we do not record "why we originally chose it this way," an AI or engineer will make different choices when rebuilding, leading to non-equivalent results.

## Decision
All technical/architectural choices with long-term impact are recorded as an ADR in `requirements/decisions/`.
Numbers increment (0001, 0002...); once finalized, they are never deleted. If overturned, add a new one marked "supersedes ADR-XXXX".

## Consequences
- Benefits: rebuilds have a basis, decisions are traceable, and new members can quickly understand the "why."
- Cost: each major decision takes a few minutes to write up.

---

## ADR Template (copy this section to add a new decision)
```
# ADR-NNNN: <Title>
## Status
Proposed | Accepted | Deprecated | Superseded by ADR-XXXX
## Context
<What problem are we facing, and what constraints exist>
## Decision
<What we decided to do>
## Alternatives Considered
- Option A: pros/cons
- Option B: pros/cons
## Consequences
<Positive and negative impacts, and things to watch out for going forward>
```
