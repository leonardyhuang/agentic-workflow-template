# Agentic Workflow Template — Agent Quick Reference

> Scannable orientation for AI agents. Deep contracts live in [`CONVENTIONS.md`](./CONVENTIONS.md). Read that before making non-trivial changes.

---

## 🚨 Bug Fix Protocol (non-negotiable)

Guardrails are hard constraints, not suggestions. Violating this protocol is a session failure.

1. **Stop.** Do not touch production code.
2. **Read** [`CONVENTIONS.md`](./CONVENTIONS.md) §Testing Discipline out loud.
3. **Write** a failing test that reproduces the bug.
4. **Verify** the test fails against the buggy code.
5. **Fix** the production code.
6. **Verify** the test passes.
7. **Run** review gates.

If you discover you have already edited production code before writing the test: **revert the edit** and start from step 1. "I already know the fix" is never a valid excuse to skip the regression test.

## 🚨 Git Mutation Protocol (non-negotiable)

No git mutation happens without explicit user instruction in the **current message**.

**These do NOT authorize git mutations:**
- "resume", "continue", "go ahead", "fix it"
- "yes" (unless answering a specific "shall I commit?" question)
- Silence or implied consent

**Authorized phrases:**
| Action | Valid trigger |
|--------|---------------|
| `git add` / stage | "stage this", "add these files" |
| `git commit` | "commit this", "commit with message X" |
| `git push` | "push this", "push to [branch]", "commit and push" |

**"Commit" alone does NOT authorize push.** They are separate mutations requiring separate confirmation.

**Before any `git add`, `git commit`, `git push`, branch, merge, rebase, reset, checkout:**
1. State exactly what you intend to do and what files are affected.
2. Wait for explicit confirmation.
3. Only then execute.

**Self-check:** If you are about to run a git command and the user did not explicitly ask for it in their last message → **halt**. Show the diff. Ask for permission.

---

## ⚠️ Simplicity & Surgical Guardrail

No speculative abstractions. No "improving" adjacent code. Clean up only your own mess.

- Solve the problem at hand. Do not build for future hypotheticals.
- If a refactor is not required for the current change, do not do it.
- If you touch a file, leave it no worse than you found it — but do not expand scope to "fix" unrelated issues.

## 🚨 Ambiguity Guardrail (tiered)

Guardrails are hard constraints, not suggestions. Violating this protocol is a session failure.

**Tier 1 — Syntactic (before every response):**
If the prompt contains `this`/`that`/`it`/`these`/`those` without a resolvable antecedent in the last 3 turns, or is < 5 words with no clear verb-object → halt and ask.

**Tier 2 — Semantic (before production code edits only):**
Self-check: "Can I state the exact file, function, and change the user wants?"
If no → halt and ask.

**Tier 3 — Default escape:**
If there is a single most-reasonable interpretation, proceed with it and explicitly state the assumption, rather than blocking.

**Meta-signal:** If you find yourself generating a numbered list of possible interpretations, you are guessing → delete the list and ask one question.

**For complex ambiguity:** Run a Socratic clarification loop (e.g., via a deep-interview skill or planner mode) before writing any plan or code.

---

## Hot Files

| File | Why |
|------|-----|
| [`CONVENTIONS.md`](./CONVENTIONS.md) | Coding standards, architecture, review gates |
| [`AGENTS.md`](./AGENTS.md) | This file — quick reference, invariants, skill map |
| [`docs/TECHNICAL_DEBT.md`](./docs/TECHNICAL_DEBT.md) | Unfixed findings from reviews |
| [`docs/runbooks/`](./docs/runbooks/) | Operational step-by-step guides |
| [`.agents/skills/`](./.agents/skills/) | Project-specific agent skills (model-agnostic) |
| [`README.md`](./README.md) | Project overview, setup, architecture |

---

## Key Commands

```bash
# [Primary dev command — e.g., npm run dev, cargo run, etc.]

# [Run tests]

# [Run linter / type-checker]

# [Build for production]
```

---

## ⚠️ Review Gates

Machine-enforced in [`.husky/pre-commit`](./.husky/pre-commit). When adding a gate here, add the executable check to the hook too — and vice versa.

Add "Run review gates" as the final todo item before starting any task. Do not mark done until all applicable gates pass. State which gates ran and their results in your completion summary.

| Gate | Command / Check |
|------|-----------------|
| Documentation hygiene | Source changes → `CONVENTIONS.md` or `README.md` or `AGENTS.md` must also change |
| Invariant checks | `scripts/check-invariants.sh` |
| [Add your stack's gates] | [Add command] |

---

## ⚠️ Key Invariants

Violations of these rules break production silently. Treat them as hard stops.

- **[Add project-specific invariant]**
- **[Add project-specific invariant]**
- Prices are **integer cents** everywhere. Never floating point.
- Never hardcode user-visible strings — all text must go through the i18n system.
- Never commit secrets, tokens, or credentials.

---

## ⚠️ Testing Discipline

- **Regression first**: write the failing test *before* touching implementation.
- **Extract-before-embed**: any logic needing unit tests must be extracted into an explicit-param pure function *before* being embedded inside an event listener / async callback / framework hook. Tests import it directly; never copy inline logic into tests.
- Run all relevant tests before marking any task complete.

---

## ⚠️ Git Discipline

> **Hard stops — no exceptions, no implicit authorisation:**
> - Never commit or push without explicit instruction in the current message.
> - Never `git push --force`, `reset --hard`, or `checkout .`.
> - Never skip hooks (`--no-verify`).
> - Never delete files, branches, or database tables without explicit confirmation.

- Prefer new commit over amending.
- Write atomic commits with clear messages.

---

## ⚠️ Documentation Hygiene

Before ending any session where architecture, contracts, key behaviours, or file responsibilities changed:

- [ ] Update [`CONVENTIONS.md`](./CONVENTIONS.md)
- [ ] Update [`README.md`](./README.md)
- [ ] Update [`AGENTS.md`](./AGENTS.md) if invariants or hot files changed
- [ ] Update [`docs/runbooks/`](./docs/runbooks/) if operational steps changed

---

## 💡 Proactive Skill Suggestions

Suggest these at natural moments without waiting to be asked:

| Moment | Action |
|--------|--------|
| After a large coding session, before merge | Run a multi-perspective review (critic, self-review, or equivalent) |
| Before starting a complex feature | Deep requirements interview — expose hidden assumptions |
| Debugging race conditions / timing bugs | Evidence-driven causal tracing — trace execution order and state mutations |
| Before a structural decision | Strategic advisory — analyze trade-offs, recommend simplest viable design |
| After claiming feature complete | Evidence-based completion check — run tests, verify invariants |
| UI/UX work | Accessibility and visual hierarchy review |
| Ready to merge / clean up history | Atomic commits, rebase if appropriate, clear history |

---

## 💡 Section Markers

Major source files use `// #region <name>` / `// #endregion` (or language-appropriate equivalents) so agents navigate by region name, not line number.

**[List major files and their regions here]**

- `src/[main-file].[ext]` — regions: `[region1]` `[region2]` `[region3]`

The pre-commit hook verifies that every region listed here exists as a `// #region` marker in source files.
