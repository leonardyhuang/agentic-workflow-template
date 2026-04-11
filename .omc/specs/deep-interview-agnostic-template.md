# Deep Interview Spec: Agnostic OMC Project Template

## Metadata
- Interview ID: di-agnostic-template-001
- Rounds: 5
- Final Ambiguity Score: 14.5%
- Type: greenfield
- Generated: 2026-04-11
- Threshold: 20%
- Status: PASSED

## Clarity Breakdown
| Dimension | Score | Weight | Weighted |
|-----------|-------|--------|----------|
| Goal Clarity | 0.90 | 0.40 | 0.36 |
| Constraint Clarity | 0.85 | 0.30 | 0.255 |
| Success Criteria | 0.80 | 0.30 | 0.24 |
| **Total Clarity** | | | **0.855** |
| **Ambiguity** | | | **14.5%** |

---

## Goal

A **team-standard starting point** for any new project that pre-configures OMC workflows, a structured CLAUDE.md, generic pre-commit hooks, a README skeleton, and a universal .gitignore — so any team member can clone, open Claude Code, and have OMC activate immediately with no extra setup.

Primary audience: the team (multiple people, multiple future repos). Clean enough to also share publicly as a reference implementation of OMC best practices.

---

## Template Contents

| File/Dir | Purpose |
|----------|---------|
| `CLAUDE.md` | OMC conventions + full section structure + battle-tested guardrails (scrubbed of project-specific content) |
| `.omc/` | OMC state directory skeleton (`.gitignore` inside so state files are not committed) |
| `.husky/pre-commit` | Generic, stack-agnostic pre-commit gates |
| `README.md` | Skeleton with placeholder sections teams fill in |
| `.gitignore` | Universal coverage (OS, editors, .env, node_modules) |

---

## Constraints

- **No stack-specific files**: no `package.json`, `Cargo.toml`, `pyproject.toml`, or any language runtime files.
- **No CI/CD**: no GitHub Actions workflows or pipeline config.
- **No language-specific dependencies**: the template must work regardless of what language the project uses.
- **Pre-commit hooks must be stack-agnostic**: the generic gates apply (doc hygiene, audit protocol reminders) but no project-specific invariants (no Rust cargo test gate, no locale completeness check, no JS-specific rules).

---

## Non-Goals

- Language scaffolding or starter code
- GitHub Actions / CI pipeline stubs
- Shopify-specific or framework-specific configuration
- OMC installation itself (teams install OMC separately; the template assumes it)

---

## Acceptance Criteria

- [ ] A team member can clone the repo, open Claude Code, and OMC skill triggers activate without any additional installation steps
- [ ] CLAUDE.md covers all OMC workflow conventions (model routing, delegation rules, skill triggers, verification policy, execution protocols)
- [ ] CLAUDE.md includes full section structure with placeholder text that teams replace with project-specific content
- [ ] CLAUDE.md includes the battle-tested guardrails from our discussions, generalised (audit findings protocol, review gate pattern, translatability pattern as an example, pre-commit hook machine-enforcement note)
- [ ] `.husky/pre-commit` runs at least one meaningful generic gate (doc hygiene: warn when key source files change without a CLAUDE.md update)
- [ ] `.gitignore` covers OS files (macOS, Windows, Linux), common editors (VS Code, JetBrains, Vim), .env files, and common dependency directories
- [ ] `README.md` has a clear skeleton: project purpose, setup, key commands, architecture notes, contributing guide placeholders
- [ ] `.omc/` directory is present with its own `.gitignore` so state files are excluded from git

---

## Assumptions Exposed & Resolved

| Assumption | Challenge | Resolution |
|------------|-----------|------------|
| "Agnostic" means multiple language variants | What about Node vs Rust vs Python? | No stack files at all — only meta-files that work regardless of stack |
| Template is for personal use | Who besides you uses it? | Team standard — multiple people, multiple repos |
| CLAUDE.md should be minimal | Should it include detailed guardrails? | Rich template: OMC conventions + full section structure + battle-tested patterns, generalised |
| Pre-commit hooks are stack-specific | Husky requires Node; what about Rust projects? | Husky is the mechanism but the gates inside are stack-agnostic — teams can replace Husky with their language's equivalent |
| CI/CD stubs are useful | GitHub Actions are stack-specific config | Excluded — teams add their own; the template stays minimal |

---

## Technical Context

**Greenfield** — new directory, no existing code.

**OMC assumption**: OMC is installed per-machine by team members (`say "setup omc"`). The template wires up the config so OMC knows the project conventions, but does not install OMC itself.

**Husky note**: Husky requires Node.js for installation (`npm run prepare`). For non-Node projects using this template, the husky setup will need a `package.json` with just `"prepare": "husky"` or teams swap Husky for a language-native hook manager. The template should include a minimal `package.json` with only the husky devDependency + prepare script, or alternatively use a plain shell symlink approach that doesn't require Node.

**Recommended resolution**: include a minimal `package.json` with `devDependencies: { "husky": "^9" }` and `"prepare": "husky"` — this is the only stack-specific file, and its sole purpose is enabling the hooks. Document this clearly in README.md.

---

## Key CLAUDE.md Sections (with guidance on content)

Based on this project's battle-tested CLAUDE.md, generalised:

1. **OMC Setup** — link to `say "setup omc"` and the skill registry
2. **Operating Principles** — delegation rules, model routing table, evidence over assumptions
3. **Code Standards** — placeholder for project-specific standards + universal rules:
   - Intention-revealing names, small single-purpose functions
   - Translatability pattern (generalised: "all user-visible strings must go through the i18n system — example: Shopify `| t:`, React i18next, etc.")
   - No floating-point money arithmetic (integer cents/pence)
   - `async/await` over `.then()` chains (if JS)
4. **Testing Discipline** — regression-first, 100% happy path coverage, run tests before marking done
5. **Audit Findings Protocol** — unfixed findings go to `docs/TECHNICAL_DEBT.md` before session ends
6. **Review Gates** — machine-enforced pattern; when adding a gate to CLAUDE.md, add it to `.husky/pre-commit` too
7. **Git & Deployment** — never force-push, never skip hooks, never commit secrets
8. **Security** — run security review after touching auth/payments/external data
9. **Proactive Skill Suggestions** — table of moment → skill

---

## Generic Pre-commit Gates (`.husky/pre-commit`)

These apply to any project regardless of stack:

```bash
# Doc hygiene: warn when key source files change without docs update
KEY_CHANGED=$(echo "$CHANGED" | grep -E "src/|lib/|app/" || true)
DOC_CHANGED=$(echo "$CHANGED" | grep -E "CLAUDE\.md|README\.md|TECHNICAL_DEBT\.md" || true)
if [ -n "$KEY_CHANGED" ] && [ -z "$DOC_CHANGED" ]; then
    echo "⚠️  Source files changed without a CLAUDE.md/README.md update."
    echo "   Confirm documentation is still accurate before merging."
fi
```

Teams add stack-specific gates (lint, test, type-check) as comments with instructions.

---

## Interview Transcript

<details>
<summary>Full Q&A (5 rounds)</summary>

### Round 1
**Q:** When someone uses this template to start a new project, what's the first concrete thing they should be able to do that they couldn't do without it?
**A:** Team standard (me + others) — multiple people, multiple repos start from this to enforce consistent OMC workflows
**Ambiguity:** 82% (Goal: 0.30, Constraints: 0.10, Criteria: 0.10)

### Round 2
**Q:** When a Node.js project vs. Rust project vs. Python project clones this — what's IDENTICAL and what do they add themselves?
**A:** OMC config + CLAUDE.md only — no stack files; everything else is per-project
**Ambiguity:** 55% (Goal: 0.60, Constraints: 0.55, Criteria: 0.15)

### Round 3
**Q:** After a new team member clones this, what's the first thing they do to verify it's working?
**A:** Run a Claude Code session and OMC activates — no extra install steps
**Ambiguity:** 34% (Goal: 0.75, Constraints: 0.60, Criteria: 0.60)

### Round 4
**Q:** Should CLAUDE.md be generic OMC only, full structure with placeholders, minimal, or scrubbed copy of this project?
**A:** Combination of 1, 2, and 4 — generic OMC conventions + full section structure + battle-tested guardrails from this project, scrubbed of Shopify-specific content, informed by our discussions
**Ambiguity:** 25.5% (Goal: 0.85, Constraints: 0.70, Criteria: 0.65)

### Round 5
**Q:** Which files should the template include beyond CLAUDE.md and .omc/?
**A:** README.md template + .gitignore (universal) + .husky/pre-commit hooks (general and agnostic)
**Ambiguity:** 14.5% (Goal: 0.90, Constraints: 0.85, Criteria: 0.80)

</details>
