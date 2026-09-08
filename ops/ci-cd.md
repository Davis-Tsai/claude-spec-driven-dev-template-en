---
title: CI/CD and Automated Deployment
status: Draft
---

# CI/CD Pipeline

## Software Pipeline
```mermaid
flowchart LR
    Commit[Git commit] --> Lint[Static checks]
    Lint --> Test[Run acceptance tests]
    Test --> Build[Build]
    Build --> Deploy[Deploy to environment]
```

| Stage | Tool | Pass condition |
|------|------|----------|
| Checks |  |  |
| Tests |  | all acceptance tests pass |
| Deploy |  |  |

## Firmware/Hardware Pipeline
- Firmware build: ___ (compile, produce .hex/.bin)
- Flashing and smoke test: ___
- Hardware acceptance: follow the `acceptance/hardware/` procedures

## Environments
| Environment | Purpose | URL/Location |
|------|------|-----------|
| dev |  |  |
| staging |  |  |
| prod |  |  |
