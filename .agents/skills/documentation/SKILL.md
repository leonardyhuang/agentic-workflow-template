---
name: documentation
description: >
  Write and maintain project documentation. Use when creating or updating
  READMEs, runbooks, ADRs, API docs, or specs. Also use when the user asks
  to document a feature, process, or architectural decision.
---

# Documentation

Documentation hygiene is mandatory in this project.

## Structure

| Path | Purpose |
|------|---------|
| `README.md` | Project overview, setup, architecture |
| `AGENTS.md` | Quick-reference for AI agents |
| `CONVENTIONS.md` | Deep contract: coding standards, review gates |
| `docs/TECHNICAL_DEBT.md` | Unfixed findings from reviews |
| `docs/runbooks/` | Operational step-by-step guides |
| `docs/specs/` | Feature specs using `_template.md` |

## Rules

- Source changes → docs must also change (`CONVENTIONS.md` or `README.md` or `AGENTS.md` or `docs/`)
- Never leave placeholder text in final docs. Fill or delete.
- Use the spec template at `docs/specs/_template.md` for new features.
- Runbooks: numbered steps, include rollback/cleanup, assume reader is on-call and stressed.
- ADRs: context → decision → consequences. Link from `README.md` or `CONVENTIONS.md`.

## Checklist Before Marking Done

- [ ] New docs linked from relevant index (README, CONVENTIONS, or AGENTS)
- [ ] No stale references to deleted files or renamed modules
- [ ] Code examples in docs compile / run
- [ ] Pre-commit documentation hygiene gate will pass
