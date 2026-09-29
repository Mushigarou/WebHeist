# Broken Authentication — Password Reset

The reset token is just `md5(email)` and applies instantly (no email), so anyone can reset anyone's password → takeover.

## How I found it (forum comment)
- Forum (jdoe): reset works instantly, token in the URL, and it's `md5(email)`.
- Confirmed the captured token = `md5("jdoe@student.42.tech")`.

## Exploit
`python3 exploit.py` → token = `md5(email)` → POST `/reset-password/confirm`.

## Fix
Use a random, single-use, expiring token stored server-side; never derive it from the email.

## References
- OWASP: https://owasp.org/Top10/2025/A07_2025-Authentication_Failures/
- Related: [weak-password-hash](../weak-password-hash/explanation.md) (md5 again) · [idor](../idor/explanation.md) (recovery code on profile)
