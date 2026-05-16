---
name: spec-author
description: >
  Write feature specs following the project's spec template. Use when the user
  asks to create, draft, or write a spec, feature spec, technical spec, or
  design doc for this project. Also use when refining an existing spec or
  converting an informal idea into a structured spec.
---

# Spec Author

Create feature specs using the project's template at `docs/specs/_template.md`.

## Workflow

1. Read `docs/specs/_template.md` to get the exact structure and frontmatter format.
2. Interview the user to fill required sections (Goal, Constraints, Success Criteria).
3. Write the spec file to `docs/specs/<kebab-case-title>.md`.
4. Ensure frontmatter is valid YAML with status set to `draft` unless user says otherwise.

## Section Guidance

- **Goal**: One sentence. What + why. No implementation details.
- **Constraints**: Hard limits (time, budget, compliance, tech). Be specific.
- **Non-Goals**: Explicitly out of scope. Prevents scope creep.
- **Success Criteria**: Checklist. Each item must be verifiable.
- **Open Questions**: Table with status. Flag unresolved items before coding starts.
- **Assumptions**: Table with challenge and resolution. Validate risky assumptions early.
- **Technical Context**: Greenfield vs brownfield. List files touched and dependencies.
- **Risks**: Table with likelihood, impact, mitigation. Include rollback risks.
- **Rollback Plan**: Concrete steps to revert. Prefer feature flags or database migrations over "revert commit" alone.

## Naming

Use kebab-case filenames: `docs/specs/user-authentication.md`, not `docs/specs/User Auth.md`.

## Rules

- Never omit the frontmatter.
- Never leave placeholder text in the final spec. Either fill it or delete the section.
- If a section doesn't apply, remove it rather than leaving it empty.
- Link related specs in `linked-tasks` when known.
