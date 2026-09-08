---
title: Environments & Secrets
status: Draft
---

# Environments & Secrets

## Environment Variables
> Configuration required by the program is managed via environment variables; **never hard-coded and never committed to version control**.
> List "which variables are needed and their purpose" here; the actual values go into each `.env` (not committed to Git).

| Variable name | Purpose | Example/Default | Applicable environment |
|--------|------|-----------|----------|
| `DATABASE_URL` | Database connection string | `postgres://...` | All |
| `API_KEY` | External service key | (secret) | All |

> It is recommended to also provide a `.env.example` (variable names only, no real values) under version control, for others to reference when configuring.

## Secrets Principles
- **Never commit keys/passwords/certificates into Git** (`.env`, `*.key`, `*.pem`, etc. are already listed in `.gitignore`).
- If a secret is accidentally committed → treat it as **already leaked**, and rotate the key immediately; deleting the commit is not enough.
- For production secrets, prefer a secret management service (a cloud Secret Manager) or CI encrypted variables, keeping them off disk.

## Per-Environment Mapping
| Environment | Purpose | Configuration source |
|------|------|----------|
| dev | Local development | Local `.env` |
| staging | Testing | Variables from CI / deployment platform |
| prod | Production | Secret management service |
