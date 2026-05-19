# Agentic Workflow Template — Conventions & Deep Contract

[One-line description of what this project does and its tech stack.]

---

## Agent Setup

This project uses AI-assisted development. The primary agent instruction files are:

- [`AGENTS.md`](./AGENTS.md) — quick reference, invariants, bug-fix protocol, ambiguity guardrails
- [`CONVENTIONS.md`](./CONVENTIONS.md) — this file: deep contracts, architecture, standards

**To activate:** point your AI tool at this repository. It should read `AGENTS.md` first, then `CONVENTIONS.md` before any non-trivial work.

> If your team uses an orchestration framework (e.g., [OMC](https://github.com/ohmyclaudecode/ohmyclaudecode) for Claude Code, custom skill registries for Kimi, etc.), configure it to load `AGENTS.md` and `CONVENTIONS.md` as context.

---

## Code Standards

### General

- SOLID, DRY. Single Source of Truth — centralised helpers over duplicate/inline logic. Never inline what should call a shared helper.
- Intention-revealing names. No cryptic abbreviations — `priceElement` not `priceEl`, `formField` not `ff`. Single-letter vars only in one-liner predicates.
- Inline comments only for *why*, not *what*. JSDoc/docstrings for complex functions.
- Small, single-purpose functions. Composition over inheritance.
- Find root cause before proposing bug fixes.
- No error handling, fallbacks, or validation for impossible scenarios. Trust internal code and framework guarantees. Validate at system boundaries only (user input, external APIs).

### Internationalisation (i18n)

Every user-visible string must go through the project's i18n system. No hardcoded text in templates or UI components.

**Example pattern (adapt to your stack):**

```
// In templates: use translation helpers
{{ 'namespace.key' | t: default: 'Fallback text' }}

// In JS/TS: read from data attributes set by the template, never hardcode
element.textContent = element.dataset.textKey || 'Fallback';
```

Add every new key to locale file before merging. All translation calls must include fallback.

**Checklist before marking any UI task complete:**
- [ ] No bare string literals in template output
- [ ] No hardcoded strings in JS `textContent` / `innerHTML` / `aria-label` writes
- [ ] All new locale keys added to default locale file
- [ ] All translation calls include fallback value

### Money / Prices

- Prices are **integer cents/pence**. Never use floating point for money calculations.
- Parse external decimal strings to float only to multiply by 100 and round, then work in integers exclusively.

### Async

- `async/await` exclusively — no raw `.then()` chains.
- Explicitly handle race conditions in UI event listeners and cross-tab state sync.

### API / Network Calls

- Use existing queue/debounce patterns for API calls. Exponential backoff for 429s.
- Never surface raw error HTML — use safe JSON fallbacks.
- Deduplicate in-flight requests for same resource (cache in-flight promises).

---

## Model / Agent Routing

| Task complexity | Strategy | When to use |
|-----------------|----------|-------------|
| Quick lookups, simple ops | Lightweight model / direct execution | File reads, status checks, simple searches |
| Standard work | Capable model / standard agent | Most implementation, standard refactors |
| Architecture, deep analysis | Strongest model / specialist agent | **Must use** for: complex debugging, security review, strategic decisions, architecture changes |

---

## Delegation Rules

Delegate to specialist agents or tools for:
- Multi-file changes and refactors
- Complex debugging
- Code review and verification
- Planning before implementation

Work directly for:
- Trivial operations
- Small clarifications
- Single commands

---

## Testing Discipline

- **Regression first**: write failing test reproducing bug *before* touching implementation.
- **Extract-before-embed**: any logic needing unit tests must be extracted into an explicit-param pure function *before* being embedded inside an event listener / MutationObserver / async callback / framework hook. Tests import it directly; never copy inline logic into tests.
  > If a function can only exist as a closure, that is a signal to extract it.
- 100% coverage for happy paths and critical edge cases (nulls, race conditions, network failures).
- Run all relevant tests before marking task complete or reporting success.
- Use background execution for long-running test suites.

---

## Audit Findings Protocol

Any finding from code review, domain audit, or targeted sweep **not fixed in same session** must be written to `docs/TECHNICAL_DEBT.md` before session ends. Mandatory — verbal acknowledgement not sufficient.

**Backlog** (features, improvements) → project management tool (Linear, GitHub Issues, etc.)  
**Technical debt** (known code quality gaps, missing tests, process holes) → `docs/TECHNICAL_DEBT.md`

Format for each entry:

```
## [HIGH|MEDIUM|LOW] Short title
- **File**: path/to/file.js:line
- **Finding**: what's wrong
- **Fix**: what needs to be done
- **Found**: YYYY-MM-DD
```

Remove items when fixed.

---

## Review Gates

> **Why this exists**: diff-scoped code review catches what changed, not whether domain invariants still hold. These gates make invariants machine-checkable and domain-scoped.
>
> **Machine-enforced when populated**: `.husky/pre-commit` runs gates below automatically on every `git commit`. When adding a gate here, add executable version to hook too — and vice versa. Empty gate table means no invariants currently enforced.

### Template: Adding a New Gate

1. Document invariant here with bash command to check it.
2. Add executable check to `.husky/pre-commit`.
3. Both must stay in sync.

**Example gate pattern:**

```bash
# No hardcoded money values — all prices must come from the API response
HARDCODED_PRICES=$(grep -n "price: [0-9]" src/checkout.js || true)
if [ -n "$HARDCODED_PRICES" ]; then
    echo "❌ Hardcoded price literal found (use API response values):"
    echo "$HARDCODED_PRICES"
    exit 1
fi
```

### Current Gates

| Gate | Command / Check |
|------|-----------------|
| Documentation hygiene | Source changes → docs must also change (see `.husky/pre-commit`) |
| [Add gate] | [Add command] |

### Periodic Domain Sweeps (run proactively, not just on change)

Catch drift accumulating across many small changes — add project-specific sweeps here:

| Sweep | Command / Check |
|-------|-----------------|
| [Add sweep name] | [Add command] |

---

## Git & Deployment

> **Hard stops — no exceptions, no implicit authorisation:**
> - Never commit or push without explicit instruction in current message.
> - Never `git push --force`, `reset --hard`, or `checkout .`.
> - Never skip hooks (`--no-verify`).
> - Never delete files, branches, or database tables without explicit confirmation.

- Prefer new commit over amending.
- Write atomic commits with clear, descriptive messages.

---

## Security

- After changes to authentication, payment flows, or external data ingestion, **MUST** run a security review before marking task complete — not optional.
- Watch: user input interpolated into queries/commands, `innerHTML` writes, new properties written from external data sources.
- Never commit secrets, tokens, or credentials. Use environment variables. Verify `.gitignore` excludes `.env` files.
- OWASP Top 10 applies: SQL injection, XSS, CSRF, insecure direct object references.

---

## Documentation Standards

### Document by Contract, Not Implementation

Docs describe inputs, outputs, and invariants — never variable names, line numbers, or step-by-step algorithms. Implementation changes; contracts should be stable.

### Frontmatter for Runbooks and Guides

All operational docs and runbooks should include:

```yaml
---
title: ""
description: ""
lastReviewed: YYYY-MM-DD
---
```

Review `lastReviewed` dates during periodic sweeps. Stale docs are a liability.

### Glossary

Centralize domain terms in [`docs/GLOSSARY.md`](./docs/GLOSSARY.md). Never define the same term in multiple docs — link to the glossary instead.

---

## Documentation Hygiene

Changes affecting architecture, conventions, or project structure → **update `CONVENTIONS.md`, `AGENTS.md`, and `README.md`**.

Before ending any session with architectural or behavioural changes:
- [ ] Update `CONVENTIONS.md`
- [ ] Update `README.md`
- [ ] Update `AGENTS.md` if invariants or hot files changed
- [ ] Update `docs/runbooks/` if operational steps changed

---

## Project Structure

| Path | Purpose |
|------|---------|
| `src/` | [Main application source] |
| `tests/` | [Test suite] |
| `docs/` | [Documentation, GLOSSARY.md, TECHNICAL_DEBT.md, runbooks, specs] |
| `.husky/` | Git hooks |
| `.github/` | PR templates |
| `scripts/` | Automation and verification scripts |
| `.gitmessage` | Commit message template |
