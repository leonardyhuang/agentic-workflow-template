# [Project Name]

> [One-line description of what this project does.]

---

## Overview

[2–3 sentences describing the problem this project solves, who it's for, and the key architectural approach.]

---

## Template Structure

```
your-project/
├── CLAUDE.md          — OMC conventions + coding standards + review gates
├── README.md          — this file (replace with your project docs)
├── .gitignore         — universal (OS, editors, .env, deps, build outputs)
├── package.json       — minimal: husky devDep + prepare script only
├── .husky/
│   └── pre-commit     — doc hygiene gate + stubs for your stack's gates
└── .omc/
    └── .gitignore     — excludes OMC runtime state from git
```

---

## Setup

### Prerequisites

- [e.g., Node.js 20+, Rust 1.75+, Python 3.11+]
- [Claude Code CLI](https://claude.ai/code) (for AI-assisted development)
- [oh-my-claudecode](https://github.com/ohmyclaudecode/ohmyclaudecode) — say `"setup omc"` in Claude Code after cloning

### Install

**From GitHub template** (recommended):
1. Click **"Use this template"** on GitHub → create your repo
2. Clone your new repo locally

**Or manually:**
```bash
cp -r omc-project-template/ your-project-name/
cd your-project-name/
git init
```

**Then, in both cases:**
```bash
# Install hook runner (required for pre-commit gates)
npm install

# Activate OMC in Claude Code
# Open Claude Code and say: "setup omc"
```

Update `package.json` with your project name, then replace placeholder content in `CLAUDE.md` and this `README.md` with your project specifics.

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
2. Make changes — Claude Code with OMC is available for AI assistance
3. Ensure all pre-commit gates pass: `git commit` runs them automatically
4. Open a PR against `main`

### Standards

See [CLAUDE.md](./CLAUDE.md) for the full coding conventions, review gates, and AI workflow guidelines.

Any unfixed findings from code review go to [`docs/TECHNICAL_DEBT.md`](./docs/TECHNICAL_DEBT.md) before the session ends.

---

## License

[MIT / Apache-2.0 / Proprietary — choose one]
