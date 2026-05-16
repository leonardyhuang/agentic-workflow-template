---
name: git-master
description: >
  Git hygiene for this project. Use when preparing commits, rewriting history,
  opening PRs, or resolving merge conflicts. Also use when the user asks about
  commit messages, branching strategy, rebasing, squashing, or rollback
  procedures for this repository.
---

# Git Master

Git history is communication. Future readers (including agents) depend on it.

## Hard Stops (from AGENTS.md)

- Never commit or push without explicit user instruction in the current message.
- Never `git push --force`, `reset --hard`, or `checkout .`.
- Never skip hooks (`--no-verify`).
- Never delete files, branches, or database tables without explicit confirmation.

## Commit Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

**Rules:**
- Subject: imperative mood, ≤ 50 chars. `Add user auth`, not `Added user auth`.
- Body: explain *why*, not *what*. The diff shows what.
- Reference issues: `Fixes #123` or `Relates to #456`.
- One logical change per commit.

## Pre-Commit Awareness

This project runs `.husky/pre-commit` automatically. It checks:
- Documentation hygiene (source changes → docs must also change)
- Project-specific gates defined in `CONVENTIONS.md` §Review Gates

Review `git diff --cached` before every commit.

## PR Hygiene

- Title: what and why in one sentence
- Description: problem → solution → how to verify
- Keep PRs small (< 400 lines)
- Rebase onto `main` before requesting review
- No merge commits in feature branches

## History Rewriting Rules

- **Before pushing:** freely rebase, squash, amend
- **After pushing to shared branch:** never force push unless team agrees
- **Before merge:** squash fixups, reword WIP commits

## Documentation Hygiene on Commit

If the commit touches architecture, conventions, or project structure, update
`CONVENTIONS.md`, `AGENTS.md`, or `README.md` in the same commit or immediately
after.
