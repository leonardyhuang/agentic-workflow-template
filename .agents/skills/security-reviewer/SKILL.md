---
name: security-reviewer
description: >
  Security-focused review for this project. Use after changes to authentication,
  payment flows, external data ingestion, user input handling, or when the user
  asks for a security check. Also use before marking any security-sensitive
  task as complete.
---

# Security Reviewer

Security is not optional. Review changes against `CONVENTIONS.md` §Security.

## Mandatory Trigger

After changes to auth, payment flows, or external data ingestion → **must** run this review before marking task complete.

## Checklist

- [ ] No user input interpolated into queries / commands (SQL injection, command injection)
- [ ] No `innerHTML` writes from external or user-controlled data (XSS)
- [ ] No new properties written directly from external data sources without validation
- [ ] Secrets, tokens, credentials only in environment variables — never in source
- [ ] `.gitignore` excludes `.env` files and local secrets
- [ ] CSRF protection considered for state-changing operations
- [ ] Insecure direct object references checked (can User A access User B's data?)
- [ ] Money calculations use integer cents — no floating point

## Output

```
## 🔒 Security Review

### Passed
- [check]

### Flagged
- [file:line] — [risk] — [mitigation]

### Blockers
- [file:line] — [risk] — [mitigation]
```

Blockers must be resolved before merge. Flagged items go to `docs/TECHNICAL_DEBT.md` if not fixed immediately.
