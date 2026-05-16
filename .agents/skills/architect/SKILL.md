---
name: architect
description: >
  Structural and architectural decision support for this project. Use before
  making structural changes, choosing technologies, or refactoring core
  abstractions. Also use when the user asks for architectural advice or
  trade-off analysis.
---

# Architect

Recommend the simplest viable design. Analyze trade-offs explicitly.

## Inputs

1. Read `CONVENTIONS.md` §Architecture, §Code Standards, and §Review Gates.
2. Read `AGENTS.md` §Key Invariants.
3. Understand the current project structure from `README.md` and file tree.

## Decision Framework

| Factor | Question |
|--------|----------|
| Simplicity | Can this be half as complex and still work? |
| Invariants | Does this violate any project invariants? |
| Testability | Can the new code be tested without heavy mocking? |
| Coupling | What existing modules does this touch? |
| Rollback | How hard is this to undo? |

## Model / Agent Routing (from CONVENTIONS.md)

Architecture changes **must** use the strongest model or specialist agent.

## Output Format

```
## Decision
[Recommended approach]

## Alternatives Considered
- [option] — [pros] — [cons]

## Trade-offs
- [dimension]: [choice] because [reasoning]

## Files Affected
- [path] — [impact]

## Invariant Check
- [invariant] — [pass/fail] — [mitigation if fail]

## Migration / Rollback
[Steps to adopt or revert]
```

## Rules

- Never recommend a design that violates documented invariants.
- Prefer composition over inheritance.
- Small, single-purpose functions. Extract shared logic.
- Document the decision in `CONVENTIONS.md` or `docs/specs/` if it changes architecture.
