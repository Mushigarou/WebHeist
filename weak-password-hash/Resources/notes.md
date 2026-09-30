# Evidence — Weak Password Hashing

- Source of `target.txt`: the god/staff dashboard (`/staff/dashboard`) lists every user with their `pw_hint` — a 16-char md5 prefix of the password (9 users).
- Unsalted md5, e.g. jdoe `e10adc3949ba59ab` = md5("123456").
- The breach `flag` sits in the `/staff/dashboard` users table, and is returned directly by `GET /api/grades?student={id}` (schema-documented; readable by any logged-in user) — the script only recovers passwords.
- Cracked with plain rockyou: `123456` (jdoe), `b3njamin!` (benjamin). The other 7 hints resist rockyou (need rules / stronger lists).
- Run: `python3 exploit.py` (reads `Resources/rockyou.txt`). `rockyou.txt` is git-ignored — download it at eval time.
