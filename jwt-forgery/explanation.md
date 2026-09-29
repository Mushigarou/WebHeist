# JWT Forgery (weak secret)

Session JWT (HS256) uses a weak secret `42network` (leaked in comments, never rotated) — any token is forgeable.

## How I found it (jwt.io, DevTools)
- [OSINT](../recon/osint.md): secret `42`→`42network`, only "moved" to `/internal/config`.
- jwt.io + `42network` → valid. `sub` = id from `/profile/<id>`; `role` = privilege.
- Forge token → set `session` cookie (DevTools) → become any user.

## Exploit
`echo '{"id":"..","username":"..","role":"god"}' | python3 exploit.py`

## Fix
Long random secret (≥256-bit, RFC 7518), rotated; verify `role` server-side.

## References
- OWASP: https://owasp.org/Top10/2025/A04_2025-Cryptographic_Failures/
- Related: [idor](../idor/explanation.md) (the id) · [privilege-escalation](../privilege-escalation/explanation.md) (the `role`) · [weak-password-hash](../weak-password-hash/explanation.md)
