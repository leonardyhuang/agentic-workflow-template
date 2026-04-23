# [Project Name] — Claude Code Conventions

[One-line description of what this project does and its tech stack.]

---

## OMC Setup

Project uses [oh-my-claudecode (OMC)](https://github.com/ohmyclaudecode/ohmyclaudecode) for multi-agent orchestration.

Activate: open Claude Code, say **"setup omc"**, or run `/oh-my-claudecode:omc-setup`.

---

## Code Standards

### General

- SOLID, DRY. Single Source of Truth — centralised helpers over duplicate/inline logic.
- Intention-revealing names. Inline comments only for *why*, not *what*. JSDoc/docstrings for complex functions.
- Small, single-purpose functions. Composition over inheritance.
- Find root cause before proposing bug fixes.
- No error handling, fallbacks, or validation for impossible scenarios. Trust internal code and framework guarantees. Validate at system boundaries only (user input, external APIs).

### Internationalisation (i18n)

Every user-visible string must go through project's i18n system. No hardcoded text in templates or UI components.

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

## Model Routing

| Task complexity | Model | When to use |
|----------------|-------|-------------|
| Quick lookups, simple ops | `haiku` | File reads, status checks, simple searches |
| Standard work | `sonnet` | Most implementation, standard refactors |
| Architecture, deep analysis | `opus` | **Must use** for: complex debugging, security review, strategic decisions, architecture changes |

---

## Delegation Rules

Delegate to specialist agents for:
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
- 100% coverage for happy paths and critical edge cases (nulls, race conditions, network failures).
- Run all relevant tests before marking task complete or reporting success.
- Use `run_in_background: true` for long-running test suites.

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
> **Machine-enforced when populated**: `.husky/pre-commit` runs gates below automatically on every `git commit`. When adding gate here, add executable version to hook too — and vice versa. Empty gate table means no invariants currently enforced.

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

### Periodic Domain Sweeps (run proactively, not just on change)

Catch drift accumulating across many small changes — add project-specific sweeps here:

| Sweep | Command / Check |
|-------|----------------|
| [Add sweep name] | [Add command] |

---

## Git & Deployment

> **Hard stops — no exceptions, no implicit authorisation:**
> - Never commit or push without explicit instruction in current message.
> - Never `git push --force`, `reset --hard`, or `checkout .`.
> - Never skip hooks (`--no-verify`).
> - Never delete files, branches, or database tables without explicit confirmation.

- Prefer new commit over amending.

---

## Security

- After changes to authentication, payment flows, or external data ingestion, **MUST** run `/oh-my-claudecode:security-reviewer` before marking task complete — not optional.
- Watch: user input interpolated into queries/commands, `innerHTML` writes, new properties written from external data sources.
- Never commit secrets, tokens, or credentials. Use environment variables. Verify `.gitignore` excludes `.env` files.
- OWASP Top 10 applies: SQL injection, XSS, CSRF, insecure direct object references.

---

## Proactive Skill Suggestions

Suggest at natural moments without waiting to be asked:

| Moment | Skill |
|--------|-------|
| After large coding session, before merge | `/oh-my-claudecode:critic` — multi-perspective review |
| Before starting complex feature | `/oh-my-claudecode:planner` — deep requirements interview |
| Debugging race conditions / timing bugs | `/oh-my-claudecode:tracer` — evidence-driven causal tracing |
| Before structural decision | `/oh-my-claudecode:architect` — strategic advisory |
| After claiming feature complete | `/oh-my-claudecode:verifier` — evidence-based completion check |
| UI/UX work | `/frontend-design` — distinctive interface design |
| Ready to merge / clean up history | `/oh-my-claudecode:git-master` — atomic commits, rebase |

---

## Documentation Hygiene

Changes affecting architecture, conventions, or project structure → **update `CLAUDE.md` and `README.md`**.

---

## Project Structure

| Path | Purpose |
|------|---------|
| `src/` | [Main application source] |
| `tests/` | [Test suite] |
| `docs/` | [Documentation, TECHNICAL_DEBT.md] |
| `.omc/` | OMC state — do not commit state files |
| `.husky/` | Git hooks |
