---
title: Environments & Secrets
status: Draft
---

# Environments & Secrets

> Records the environment needed to **run / build / test / deploy**. **Domain-neutral** — assumes no architecture (web / embedded / desktop / data-processing all apply).
> Per project type (§0.7), **mark any inapplicable section `N/A` with a one-line note** — don't leave misleading examples.

## 1. Toolchain Readiness ★ required for all projects
> Derived from the **tech-stack ADRs**; a **prerequisite for §5 generating/building code** (see `CLAUDE.md §5`, Environment Readiness).
> Status: `Not installed` | `Installed` | `Verified`. **"Skipped (no toolchain)" ≠ "tests passed".**

> ⚠️ Example — delete when starting real content: the rows below are format demonstrations (seeded from ADRs: SDK / compiler / RTOS / runtime / DB / framework / flasher…).

| Tool | Version (decided) | Install method / official link | Installed by | Verify command | Status |
|------|-------------------|--------------------------------|--------------|----------------|--------|
| e.g. TI SimpleLink SDK | vX | ti.com/... (manual download, login required) | User | check install directory | Not installed |
| e.g. arm-none-eabi-gcc | vX | apt / brew / official | User or AI (with consent) | `arm-none-eabi-gcc --version` | Not installed |

### Install policy (what Claude can install for you, what needs you)
- **Claude can install (with your consent)**: anything installable via a **package manager / CLI** (pip / npm / winget / choco / scoop / brew / apt / cargo…) and project dependencies (requirements.txt / package.json…) — **just say "install it for me", and Claude proposes the command, you approve, Claude installs and runs the verify command**; no need to look up how to install.
- **Needs you (manual)**: vendor SDKs / IDEs (login / GUI / manual download required, e.g. TI SimpleLink, STM32CubeIDE…) and hardware drivers — Claude only provides the official link + steps + verify command.
- When unsure which category, Claude **judges first (checks whether the package manager has it, runs `--version`) and tells you** — no blind guessing.
- Every install command is **still approved per-command**; Claude **never installs silently**; a status becomes `Verified` only after running the verify command (version).
- **Never report "built/tests passed" when a tool is absent** — state clearly "skipped: toolchain not installed".

## 2. Environment Variables
> Manage program configuration via environment variables; **never hard-coded, never committed**; actual values go into each `.env` (not in Git).
> **Fill only if applicable** (e.g. web/service projects); for pure-firmware and other projects with no env vars, mark the whole section `N/A`.

> ⚠️ Example — delete when starting real content: the rows below are format demonstrations.

| Variable name | Purpose | Example/Default | Applicable environment |
|--------|------|-----------|----------|
| e.g. `DATABASE_URL` | Database connection string | `postgres://...` | All |
| e.g. `API_KEY` | External service key | (secret) | All |

> It is recommended to also provide a `.env.example` (variable names only, no real values) under version control, for reference.

## 3. Secrets Principles
- **Never commit keys/passwords/certificates into Git** (`.env`, `*.key`, `*.pem`, etc. are already listed in `.gitignore`).
- If a secret is accidentally committed → treat it as **already leaked**, and rotate the key immediately; deleting the commit is not enough.
- For production secrets, prefer a secret management service or CI encrypted variables, keeping them off disk.
- **Projects with no secrets**: state clearly "this project has no cloud secrets" (`N/A`).

## 4. Run / Deploy Targets
> Fill per project type (§0.7); mark inapplicable dimensions `N/A`:
> - **Software service** → dev / staging / prod, deployment platform.
> - **Firmware** → flash/debug environment (flasher, drivers, VCP), target board.
> - **Desktop / CLI** → target OS / runtime.

| Target | Description / configuration source |
|------|-----------------|
| e.g. prod (software service) | secret management service / deployment platform |
| e.g. target board (firmware) | flasher + drivers (e.g. XDS110 VCP) |
