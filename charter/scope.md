---
title: Project Scope Statement
status: Draft   # Draft | In Review | Final
---

# Project Scope Statement

## 0. Project Type
> Declares which dimensions this project covers. This is the single source of truth for
> "does this project have software/hardware," and the AI uses it to decide which folders
> need to be filled in and which are marked "N/A".

- **Type**: integrated hardware+software   <!-- pick one: integrated hardware+software | software-only | hardware-only -->
- N/A dimensions: for their related documents, set the frontmatter `status:` to `N/A`, and add a one-line note at the top of the file (e.g., "This project contains no hardware").

| Dimension | Applicable | Corresponding folders |
|------|----------|------------|
| Software | Yes | `contracts/data-schema.sql`, `contracts/api.openapi.yaml`, `acceptance/software/`, `src/` |
| Hardware | Yes | `contracts/hardware/`, `acceptance/hardware/`, `hardware_build/` |

## 1. Project Goal
<!-- State in one sentence what this project aims to achieve. -->

## 2. Stakeholders
| Role | Name/Unit | Key concerns |
|------|-----------|----------|
| Sponsor |  |  |
| Product owner |  |  |
| End user |  |  |

## 3. In Scope
- Software:
- Hardware:

## 4. Out of Scope
- <!-- Explicitly state "what will not be done" to avoid scope creep -->

## 5. Deliverables
| Deliverable | Software/Hardware | Acceptance basis |
|--------|-----------|----------|
|  |  |  |

## 6. Key Constraints & Assumptions
- Budget / schedule / regulations / supply chain:
- Assumptions:

## 7. Success Metrics (KPI)
- <!-- Measurable, e.g.: firmware boot time < 500ms, API P95 < 200ms -->
