---
name: deep-interview
description: >
  Socratic requirements clarification before spec writing or implementation.
  Use when requirements are vague, underspecified, or the user says "build
  me a thing" without details. Also use before planning a complex feature
  to expose hidden assumptions.
---

# Deep Interview

Requirements are never as clear as they first appear. Expose hidden assumptions before writing code.

## When to Use

- User asks for a feature with < 3 concrete details
- Scope feels ambiguous or open-ended
- Multiple interpretations are possible
- Success criteria are unstated

## Workflow

1. **Read** `docs/specs/_template.md` to know what information is needed.
2. **Interview** the user to fill Goal, Constraints, Non-Goals, Success Criteria.
3. **Stop** when you can state the exact files, functions, and changes required.
4. **Write** the spec to `docs/specs/<kebab-case-title>.md`.

## Questions to Ask

- What problem are we solving? Who for?
- What does success look like? How do we verify it?
- What's explicitly out of scope?
- What constraints exist? (time, budget, compliance, tech)
- What assumptions are we making? What could invalidate them?
- What existing code is affected?
- What's the rollback plan if this goes wrong?

## Stop Signal

If you find yourself generating a numbered list of possible interpretations, you are guessing → delete the list and ask one question.

## Output

A completed spec file or a concise set of answered questions that unblock planning.
