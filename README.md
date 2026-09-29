# Darkly — 42 Web Security Audit

Security audit of the **Darkly** platform served at `http://localhost:4942`
(VirtualBox appliance). Each breach lives in its own folder and follows the
subject layout: an exploit script, an `explanation.md`, a `flag` file when the
breach yields one, and a `Resources/` folder for supporting material. A combined
[`walkthrough.md`](walkthrough.md) ties everything together.

## Breaches

| # | Folder | Vulnerability | OWASP 2025 | Flag |
|---|--------|---------------|-----------|:----:|
| 1 | [`path-traversal/`](path-traversal/) | Path traversal / arbitrary file read | A01 | ✅ |
| 2 | [`password-reset/`](password-reset/) | Broken authentication (instant reset) | A07 | — |
| 3 | [`jwt-forgery/`](jwt-forgery/) | JWT forgery, weak secret `42network` | A04 | — |
| 4 | [`weak-password-hash/`](weak-password-hash/) | Unsalted MD5 password hashing | A04 | ✅ |
| 5 | [`idor/`](idor/) | IDOR on `/profile/<id>` | A01 | ✅ |
| 6 | [`user-enumeration/`](user-enumeration/) | User enumeration via `/api/users` | A01 | — |
| 7 | [`privilege-escalation/`](privilege-escalation/) | Broken access control (role field) | A01 | ✅ |
| 8 | [`xxe/`](xxe/) | XML External Entity injection | A02 | ✅ |
| 9 | [`stored-xss/`](stored-xss/) | Stored XSS + session hijacking | A05 | ✅ |
| 10 | [`file-upload/`](file-upload/) | Unrestricted file upload | A06 | ✅ |
| 11 | [`pocketbase-admin/`](pocketbase-admin/) | Exposed PocketBase admin (god export) | A02 | ✅ |

### OWASP 2025 codes used

| Code | Category | Meaning (plain) |
|------|----------|-----------------|
| A01 | Broken Access Control | Users reach data/actions that aren't theirs |
| A02 | Security Misconfiguration | Unsafe settings, exposed panels/config, XXE |
| A04 | Cryptographic Failures | Weak or misused crypto (weak secret, MD5) |
| A05 | Injection | Untrusted input runs as code/markup (XSS, SQLi) |
| A06 | Insecure Design | The feature is unsafe by design |
| A07 | Authentication Failures | Login/identity checks are broken |

> Reference: [OWASP Top 10:2025](https://owasp.org/Top10/2025/).

**8 flags recovered** (mandatory needs 6). **11 vulnerabilities** documented
(mandatory needs 10).

## Reconnaissance
See [`recon/`](recon/) — HTTP/source recon (`osint.md`), scripted comment
harvesting (`fetch.sh`), port scan (`scan.nmap`) and working notes.

## Running the Python exploits
```sh
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```
> `.venv/` and `rockyou.txt` are **git-ignored** on purpose: the subject forbids
> committing binaries, and downloaded files (the wordlist) must be fetched at
> evaluation time, not stored in the repo.
