# IDOR — Insecure Direct Object Reference

`/profile/<id>` lets any logged-in user open anyone's profile (ids are in every link), exposing private notes.

## How I found it (browser)
- [OSINT](../recon/osint.md): "open anyone's `/profile/<id>` — ids are in every link."
- Took wil's id from his forum post → profile URL.
- Opened wil's `/profile/<id>` as a student → **Private note** = flag.

## Exploit
`python3 exploit.py` → GET `/profile/k1asdfeditojrb4` (wil) → flag.

## Fix
Authorize by owner server-side; never expose other users' private fields.

## References
- OWASP: https://owasp.org/Top10/2025/A01_2025-Broken_Access_Control/
- Related: [jwt-forgery](../jwt-forgery/explanation.md) (ids feed the `sub`) · [user-enumeration](../user-enumeration/explanation.md)
