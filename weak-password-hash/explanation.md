# Weak Password Hashing (MD5)

Passwords use unsalted MD5 and the app exposes the hash (`pw_hint`), so weak ones crack offline in seconds.

## How I found it (staff dashboard, forum)
- A forum/source comment said the hint is just md5.
- As staff (cadet+), `/staff/dashboard` lists users' `pw_hint` (16-char md5 prefix) → `target.txt`.
- Cracked with rockyou → jdoe `123456`, benjamin `b3njamin!`.
- The `flag` shows in the `/staff/dashboard` users table **and** is served directly by `GET /api/grades` to any logged-in session (no cracking required) — `exploit.py` only demonstrates the weak hashing.

## Exploit
`python3 exploit.py` (reads `Resources/rockyou.txt`).

## Fix
Hash with a slow salted algorithm (bcrypt/argon2); never expose password hashes.

## References
- OWASP: https://owasp.org/Top10/2025/A04_2025-Cryptographic_Failures/
- Related: [password-reset](../password-reset/explanation.md) (md5 again) · [jwt-forgery](../jwt-forgery/explanation.md)
