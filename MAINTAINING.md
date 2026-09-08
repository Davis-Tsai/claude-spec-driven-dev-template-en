# Maintaining this Template

> For **template maintainers**: how to keep improving this template, and how existing projects absorb improvements.
> (This is of little use to "a new project created from the template", and can be deleted at will.)

## 1. The Flow for Improving the Template
1. Edit files in this repo (rules, document templates, hooks, …).
2. `git commit` (with a message explaining what changed and why).
3. `git push` to GitHub → the template is updated, and people who later click "Use this template" get the new version.
4. (Recommended) After a significant improvement, tag a version: `git tag v1.1 && git push --tags`, or use GitHub Releases, to make it easy to track "which improvement is in which version".

> For more rigor, use branches + PRs: change on a feature branch → open a PR → merge back into `main`.

## 2. Key Point: Existing Projects Do Not Update Automatically
"Use this template" is a **copy at a point in time**, not a live link. So after the template is improved:
- Projects created **afterward** → automatically get the new version.
- Projects created **beforehand** → do not change automatically, and need to be **synced manually** (see below).

## 3. How Existing Projects Absorb Template Improvements
Sync only the "framework files"; **do not overwrite the project content you have already filled in**.

- **Safe to overwrite (framework/generic)**: `CLAUDE.md`, `README.md`, `.githooks/`, `.gitignore`, `.gitattributes`,
  `charter/design-decisions.md`, `charter/reverse-spec-checklist.md`, `charter/definition-of-done.md`, `LICENSE`.
- **Do not overwrite (your project content)**: `charter/scope.md`, `requirements/` (PRD/ERD/ADR), `contracts/`,
  `acceptance/`, `charter/{glossary,open-questions,risk-register}.md`, `changes/change-log.md`, `src/`, `hardware_build/`.

Approach: copy the "framework files" above from the new template version to overwrite, then use `git diff` to confirm only the framework was touched, and commit.
(If a framework file has been customized by you, use `git diff` instead to pick out the changes you want item by item, rather than overwriting the whole file.)

## 4. Version Compatibility
- If an improvement affects the rules of a "finalized document", follow change management when syncing it into an existing project (see `CLAUDE.md §4`).
- For large changes, note "breaking change" in the commit/Release to remind downstream to be careful when syncing.
