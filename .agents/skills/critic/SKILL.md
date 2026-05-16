---
name: critic
description: >
  Post-coding review for this project. Use after a large coding session,
  before merging, or when the user asks for a code review, self-review,
  or sanity check. Also use when the user says "review this" or asks
  if the changes look good.
---

# Critic

Review changes against the project's deep contracts before merging.

## Workflow

1. Read the diff (`git diff` or PR diff).
2. Check against `AGENTS.md` invariants and `CONVENTIONS.md` standards.
3. Flag violations, not style nits.
4. Unfixed findings → `docs/TECHNICAL_DEBT.md` before session ends.

## Checklist

- **Invariants**: Any new integer-cents money handling? Any hardcoded user-visible strings?
- **Testing**: Regression test written *before* fix? Pure functions extracted for testability?
- **Architecture**: Single Source of Truth respected? Small, single-purpose functions?
- **Security**: New user input paths? `innerHTML` writes? External data written to objects?
- **i18n**: All new user-visible strings go through the translation system with fallbacks?
- **Documentation**: Architecture or convention changes reflected in `AGENTS.md`, `CONVENTIONS.md`, or `README.md`?
- **Async**: Raw `.then()` chains introduced? Race conditions handled?

## Output Format

```
## ✅ Passed
- [item]

## ⚠️ Flagged
- [file:line] — [issue] — [suggested fix]

## ❌ Blockers
- [file:line] — [issue] — [suggested fix]
```

Blockers must be fixed before merge. Flagged items can go to `docs/TECHNICAL_DEBT.md` if not fixed immediately.
