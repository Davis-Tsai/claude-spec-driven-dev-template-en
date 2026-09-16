---
title: Environments & Secrets
status: Draft
---

# Environments & Secrets

## Toolchain Readiness
> Derived from the **tech-stack ADRs**; a **prerequisite for generating/building code** (see `CLAUDE.md §5`, Environment Readiness).
> Status: `Not installed` | `Installed` | `Verified`.

> ⚠️ Example — delete when starting real content: the rows below are format demonstrations.

| Tool | Version (decided) | Install method / official link | Installed by | Verify command | Status |
|------|-------------------|--------------------------------|--------------|----------------|--------|
| e.g. TI SimpleLink SDK | vX | ti.com/... (manual download, login required) | User | check install directory | Not installed |
| e.g. arm-none-eabi-gcc | vX | apt / brew / official | User or AI (with consent) | `arm-none-eabi-gcc --version` | Not installed |

### Install policy (the AI does not install software on its own)
- By default the AI **only provides**: official download links, install steps, verify commands, for the user to run (large-vendor SDKs often require login/authorization; the AI cannot download them).
- When it can be installed via a package manager (apt/brew/pip/choco…) **and the user explicitly consents**, the AI may run the install command on their behalf; still subject to per-command permission, **never a silent install**.
- The AI changes a status to `Verified` only after running the verify command (version) to confirm.
- **Never report "built/tests passed" when a tool is absent** — state clearly "skipped: toolchain not installed".

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
