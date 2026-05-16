---
name: test-writer
description: >
  Write tests following this project's testing discipline. Use when the user
  asks to write, add, or fix tests, or when implementing a feature that
  requires test coverage. Also use for bug fixes to ensure regression tests
  are written first.
---

# Test Writer

Testing discipline for this repository.

## Hard Rules (from AGENTS.md / CONVENTIONS.md)

- **Regression first**: write the failing test *before* touching implementation.
- **Extract-before-embed**: any logic needing unit tests must be extracted into an explicit-param pure function *before* being embedded inside an event listener / MutationObserver / async callback / framework hook. Tests import it directly.
- 100% coverage for happy paths and critical edge cases (nulls, race conditions, network failures).
- Run all relevant tests before marking task complete.

## Workflow

1. **Bug fix**: write failing test reproducing the bug → verify it fails → fix code → verify it passes.
2. **New feature**: write tests defining expected behavior → implement → verify.
3. **Refactor**: ensure existing tests pass first → refactor → verify.

## Edge Case Checklist

- [ ] Null / undefined inputs
- [ ] Empty collections
- [ ] Race conditions (async operations, UI events, cross-tab state)
- [ ] Network failures (timeouts, 4xx, 5xx)
- [ ] Boundary values (min, max, overflow)
- [ ] Invalid / malformed data

## Anti-Patterns to Avoid

- Copying inline logic into tests (test the extracted pure function instead)
- Testing implementation details instead of behavior
- Missing fallback assertions in async tests
- No cleanup between tests (state leakage)
