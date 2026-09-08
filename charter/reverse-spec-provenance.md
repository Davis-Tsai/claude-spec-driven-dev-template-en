---
title: Reverse-Spec Provenance
status: Ongoing
---

# Reverse-Spec Provenance

> **Purpose**: when this project's spec is reverse-extracted from an "existing implementation," use this record to **prove the documents are faithful to the source code**,
> and let future people judge credibility for themselves (rather than just trusting the AI).
> **Applicability**: if this project is brand-new forward development (spec precedes code), simply mark this file `N/A`.
>
> The trust problem in reverse is the opposite of forward: **code is the truth, and the documents must be proven faithful to it** (see `CLAUDE.md §4.5`, `design-decisions.md H`).

## 0. Applicability Declaration
- Spec source: ☐ brand-new forward development (this file N/A)　☐ reverse-extracted from an existing implementation (fill in below)
- Existing project location: __________

## 1. Sources
> The existing files/documents the reverse work is based on, with versions and dates.
| Source | Version / Date | Coverage |
|------|-------------|----------|
| e.g.: Firmware/.../imu_if.c | git \<hash\> / YYYY-MM-DD | IMU configuration, integration |

## 2. Method
- By whom / what (manual / AI agent), when, and how cross-checked: __________

## 3. Coverage Matrix
> Each important item in the source code → document location. A value in the "Gap" column = not yet covered.
| Source code item (module / pin / command / data field…) | Document location | Gap / Note |
|------|----------|-------------|
| e.g.: 0x02 result packet | contracts/interfaces.md §1 | — |

- Coverage estimate: ____% (covered items ÷ items that should be covered)

## 4. Independent Adversarial Verification
> An **independent** round (another agent or person) cross-checks in reverse and records differences.
- Verifier / Date: __________
- **Fabrication items** (in document, not found in source code): (none / list)
- **Omission items** (in source code, not captured in document): (none / list)
- Disposition: (fixed / pending)

## 5. Verified vs Uncertain
- ✅ Verified (has provenance and was cross-checked):
- ⚠️ Uncertain / pending measurement (insufficient source or values await measurement):

## 6. Sign-off
> Reverse documents default to `In Review`; only after someone who knows the project verifies them may the related documents be promoted to `Final`.
| Document | Approver | Date | Promote to Final? |
|------|--------|------|--------------|
|  |  |  |  |

> The strongest validation is the "round-trip regeneration test"—regenerate code using only the documents and pass the original acceptance; high cost, not required, do it when you have the capacity.
