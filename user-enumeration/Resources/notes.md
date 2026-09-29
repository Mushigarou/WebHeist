# Evidence — User Enumeration

- `GET /api/users` returns all users to any logged-in session (a student is enough); no token → 302.
- Fields exposed: id, username, email, role, level, campus (9 users).
- Feeds [IDOR](../../idor/explanation.md) (ids) and [JWT forgery](../../jwt-forgery/explanation.md) (id + role).
