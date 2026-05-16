# [Project Name]

> [One-line description of what this project does.]

---

## Overview

[2–3 sentences describing the problem this project solves, who it's for, and the key architectural approach.]

---

## Template Structure

```
your-project/
├── AGENTS.md          — Quick-reference for AI agents (bug-fix protocol, invariants, skill map)
├── CONVENTIONS.md     — Deep contract: coding standards, architecture, review gates
├── README.md          — This file (replace with your project docs)
├── .gitignore         — Universal (OS, editors, .env, deps, build outputs)
├── package.json       — Minimal: husky devDep + prepare script only
├── .husky/
│   └── pre-commit     — Generic pre-commit gates + stubs for your stack's gates
├── .agents/
│   └── skills/        — Project-specific agent skills (model-agnostic)
├── docs/
│   ├── TECHNICAL_DEBT.md  — Unfixed findings from reviews
│   ├── runbooks/          — Operational step-by-step guides
│   └── specs/
│       └── _template.md   — Spec template for new features
```

---

## Setup

### Prerequisites

- [e.g., Node.js 20+, Rust 1.75+, Python 3.11+]
- An AI-assisted development tool (Claude Code, Kimi Code CLI, Cursor, etc.)

### Install

**From GitHub template** (recommended):
1. Click **"Use this template"** on GitHub → create your repo
2. Clone your new repo locally

**Or manually:**
```bash
cp -r agentic-workflow-template/ your-project-name/
cd your-project-name/
git init
```

**Then, in both cases:**
```bash
# Install hook runner (required for pre-commit gates)
npm install

# Optional: wire up the commit message template
git config commit.template .gitmessage

# Your AI tool should auto-detect AGENTS.md and CONVENTIONS.md.
# If using an orchestration framework, activate it now.
```

> **Non-Node projects:** even if your stack isn't Node.js, run `npm install` once after cloning — it only installs husky to wire up the pre-commit gates. You can swap husky for your language's native hook manager later.

Update `package.json` with your project name, then replace placeholder content in `AGENTS.md`, `CONVENTIONS.md`, and this `README.md` with your project specifics.

> **Template maintainer:** to enable the **"Use this template"** button on GitHub, go to your repo **Settings → General → Template repository** and check the box.

---

## Agent Workflow

This repository is designed for AI-assisted development:

1. **AGENTS.md** is the first file any agent should read — it contains the bug-fix protocol, ambiguity guardrails, key invariants, and a skill suggestion map.
2. **CONVENTIONS.md** contains the deep contract — architecture, coding standards, testing discipline, review gates.
3. **docs/TECHNICAL_DEBT.md** accumulates unfixed findings from reviews.
4. **docs/runbooks/** holds operational knowledge (debugging, deployment, common procedures).
5. **.agents/skills/** stores project-specific skills that travel with the repo and work across AI tools (Kimi CLI, Claude Code, etc.).

The pre-commit hook enforces documentation hygiene: if you change key source files, you must also update docs.

---

## Key Commands

```bash
# [Primary dev command — e.g., start dev server]
npm run dev

# [Run tests]
npm test

# [Run linter]
npm run lint

# [Build for production]
npm run build
```

---

## Architecture

[Brief description of the system's major components and how they interact. Update this as the architecture evolves.]

| Component | Path | Purpose |
|-----------|------|---------|
| [e.g., API] | `src/api/` | [Purpose] |
| [e.g., UI] | `src/ui/` | [Purpose] |
| [e.g., DB] | `src/db/` | [Purpose] |

---

## Contributing

### Workflow

1. Branch from `main`: `git checkout -b feat/your-feature`
2. Make changes — AI assistance available via `AGENTS.md` + `CONVENTIONS.md`
3. Ensure all pre-commit gates pass: `git commit` runs them automatically
4. Open a PR against `main`

### Standards

See [`AGENTS.md`](./AGENTS.md) for the quick-reference (bug-fix protocol, invariants, skill map).  
See [`CONVENTIONS.md`](./CONVENTIONS.md) for the full coding conventions, review gates, and architecture contracts.

Any unfixed findings from code review go to [`docs/TECHNICAL_DEBT.md`](./docs/TECHNICAL_DEBT.md) before the session ends.

---

## License

[MIT / Apache-2.0 / Proprietary — choose one]
