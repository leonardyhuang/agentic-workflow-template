---
name: planner
description: >
  Create implementation plans before coding. Use before starting a complex
  feature, refactor, or architectural change. Also use when the user asks
  to plan, break down, or estimate work.
---

# Planner

Plan before implementing. Complex work requires structured thinking.

## Workflow

1. Read `CONVENTIONS.md` §Architecture and §Review Gates.
2. Read `docs/specs/_template.md` if a spec doesn't exist yet — write one first.
3. Identify affected files and invariants.
4. Break into atomic commits (one logical change each).
5. Flag risks and rollback strategy.

## Delegation Rules (from CONVENTIONS.md)

| Task | Approach |
|------|----------|
| Multi-file changes / refactors | Delegate to specialist agents |
| Complex debugging | Delegate to specialist agents |
| Code review | Delegate to specialist agents |
| Planning | Delegate to specialist agents |
| Trivial operations / single commands | Work directly |

## Model Routing (from CONVENTIONS.md)

| Complexity | Strategy |
|------------|----------|
| Quick lookups | Lightweight model |
| Standard work | Capable model |
| Architecture / deep analysis | Strongest model / specialist agent |

## Plan Format

```
## Goal
[One sentence]

## Approach
[High-level strategy]

## Files Changed
- [path] — [reason]

## Commits
1. [type](scope): [subject]
2. [type](scope): [subject]

## Risks & Mitigation
- [risk] → [mitigation]

## Rollback
[How to undo if it goes wrong]
```

## Rules

- Never start implementation without a plan for complex changes.
- The plan must include test strategy (regression first, extract-before-embed).
- Reference `docs/specs/<feature>.md` if it exists.
