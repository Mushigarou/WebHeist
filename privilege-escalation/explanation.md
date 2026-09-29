# Broken Access Control — Privilege Escalation

`PATCH /api/profile` trusts a client-sent `role` field, so a student can promote their own account.

## How I found it (browser)
- [OSINT](../recon/osint.md): schema says `PATCH /api/profile` accepts a `role` field.
- Sent `{"role":"cadet"}` with my student session → role updated (200).
- Opened `/staff/dashboard` with the same session → flag.

## Exploit
`python3 exploit.py` → PATCH `{"role":"cadet"}`, then open `/staff/dashboard`.

## Fix
Never accept `role` from the client; set it server-side and check it per endpoint.

## References
- OWASP: https://owasp.org/Top10/2025/A01_2025-Broken_Access_Control/
- Related: [jwt-forgery](../jwt-forgery/explanation.md) · [user-enumeration](../user-enumeration/explanation.md)
