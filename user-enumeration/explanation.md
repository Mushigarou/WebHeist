# User Enumeration

`GET /api/users` returns every user (id, email, role, level, campus) to any logged-in account — no staff check.

## How I found it (browser, as sophie)
- Logged in as sophie (god) and explored the site.
- Opened `/api/users` in the browser → the full list of users.

## Exploit
`python3 exploit.py --all` (or `--list username role`, `--name wil`).

## Fix
Restrict `/api/users` to staff; return only fields the caller is allowed to see.

## References
- OWASP: https://owasp.org/Top10/2025/A01_2025-Broken_Access_Control/
- Related: [idor](../idor/explanation.md) (the ids) · [jwt-forgery](../jwt-forgery/explanation.md) (id + role)
