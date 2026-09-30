# Recon / OSINT — Darkly

Target: `http://localhost:4942` · Stack: **Python 3.11 / FastAPI 0.104 / Uvicorn** · PocketBase backend on `:8090`.

- Port scan: [scan.nmap](scan.nmap) — only `4942/tcp` open.
- Comment harvester: [fetch.sh](fetch.sh) — dumps HTML comments per endpoint (raw output in [trash.txt](trash.txt)).
- Shared auth notes: [auth-notes.md](auth-notes.md).

## robots.txt
```
User-agent: *
Disallow: /admin
Disallow: /staff
Disallow: /internal
Disallow: /backup
Disallow: /api/grades
Disallow: /_/
Disallow: /static/uploads/
```
> 404 page hint: *"some interesting paths are listed in → /robots.txt. Also try: /staff · /backup · /internal/config · /_/"*

## Endpoints
| Endpoint | Result |
|---|---|
| `/staff` | works |
| `/admin` | redirect to /login |
| `/internal` | 404 |
| `/backup` | 403 (headers still leak, see below) |
| `/api/grades` | redirect to /login |
| `/api/users` | user list (JWT session) |
| `/api/docs-internal` | reachable without staff check |
| `/api/collect?c=` | DEBUG exfil log, echoes input back on GET |
| `/projects/download?file=` | serves any file → path traversal |
| `/_/` , `:8090/_/` | PocketBase admin |
| `/static/uploads/`, `/static/img` | mounted static dirs |

## Response headers (debug leaks)
Seen on `/backup` and elsewhere:
```
x-powered-by     Python/3.11 FastAPI/0.104
x-42-internal    campus=paris
x-pocketbase     http://localhost:8090
x-backup-agent   rsync/3.2.7
x-backup-dest    localhost:/opt/pocketbase/pb_data
x-backup-exclude data/private_notes.txt
x-backup-schedule daily@03:00
x-last-backup    2024-12-01T03:00:00Z
x-content-type-options nosniff | x-frame-options SAMEORIGIN | x-xss-protection 1; mode=block
```
> `x-backup-exclude: data/private_notes.txt` is the exact file used for the [path-traversal](../path-traversal/explanation.md) flag.

## Console eggs (`/static/js/console_eggs.js`, reached from `/projects`)
```
darkly42.version() → {app:1.3.7, pb:0.22.4, campus:'wilcity', motto:'move fast and forget to fix things'}
darkly42.ls()      → fake filesystem (/app: static/ templates/ resources/ data/) — "wrong door though"
darkly42.sophie()  → {level:42, role:'god', advice:'earn it'}
darkly42.wil()     → "I'll fix it next sprint. Next sprint has been Q1 2042."
```

## Users found
`benjamin` · `dorian` · `ol` · `emilie` · `wil` · `jdoe` · `asmith` · `bmartin` · `sophie`

## In-app hints
- "The rabbit hole starts where the robots tell you not to go."
- "Base64 is not encryption. It's a costume."
- "Read the HTML source. wil and emilie argue in the comments."
- "Every maintenance page has a note. wil never reads his own notes."
- "wil left something in the forum. He swears it's fine."
- "You found the console."
- "sophie is level 42. coincidence? (yes. but also no.)"
- "Keep poking. Worst case, you learn something."

## Possible inputs to attack
forum search · login · forgot password · newsletter (→ XSS) · path in URL · XML agenda import.

---

# Findings by vulnerability

## Path Traversal ✅ → [path-traversal](../path-traversal/explanation.md)
- `dorian: /projects/download serves any file you ask for. wil: it's a feature, not a directory listing.`
- `faq_darkly.pdf` has a note at the bottom (not a bug — dorian).

## Broken Authentication ✅ → [password-reset](../password-reset/explanation.md), [jwt-forgery](../jwt-forgery/explanation.md), [weak-password-hash](../weak-password-hash/explanation.md), [idor](../idor/explanation.md)
- `v1.2.0 sophie` — jwt secret was `42`, wil "improved" it to `42network`.
- Passwords crackable offline (**md5**); form claims it's "just email hashed".
- `dorian: you can open anyone's /profile/<id> — the ids are in every link.` → IDOR.
- Reset password works instantly with just the target email.
- "Curious" achievement for reading the source — not just decorative.

## Broken Access Control ✅ → [privilege-escalation](../privilege-escalation/explanation.md), [user-enumeration](../user-enumeration/explanation.md)
- `sophie: /api/docs-internal still accessible without staff check` (TODO v1.4).
- `PATCH /api/profile` accepts a `role` field (schema lists valid values).
- JWT config endpoint moved to `/internal/config` (localhost only, "do NOT expose").
- Session cookie still not `httponly` — ticket #4201.

## XXE / XEE ✅ → [xxe](../xxe/explanation.md)
- `v1.3.4 wil` — "disabled defusedxml temporarily" (6 months ago).
- `emilie: the importer parses any XML you upload, entities and all.`
- XML agenda import endpoint not validated server-side.

## Stored XSS ✅ → [stored-xss](../stored-xss/explanation.md)
- "subscribed with: ___" banner echoes the email back, unescaped.
- Someone subscribed with a `<script>` tag last week — "it worked".
- Forum comments: "HTML supported" → content goes straight into the DB.
- `/api/collect?c=` logs whatever you send and hands it back (open exfil).
- Moderation bot opens every thread with a live session + a `flag` cookie that isn't httpOnly.

## File Upload ✅ → [file-upload](../file-upload/explanation.md)
- `v1.3.3 wil` — "quick fix on file upload" (removed the whitelist entirely).

## PocketBase admin ✅ → [pocketbase-admin](../pocketbase-admin/explanation.md)
- `x-pocketbase: http://localhost:8090`, admin at `/_/`.
- `INTERNAL NOTE: congrats on gate 3. one more to go. — sophie`
- `god-tier export OK — flag retained for the security audit: FLAG{th3_und3rsc0r3_sl4sh_kn0ws_th3_w4y}`

## SQL Injection (not confirmed)
- Stray comment hidden in the [robots.txt](#robotstxt) disallow list: `/backup' OR 1=1--@evil.com" we should probably sanitize the email field` → SQLi hint on the email field.
- `wil: someone subscribed "' OR 1=1--@evil.com" we should probably sanitize the email field`.

## SSRF / CSRF (not confirmed)
- Nothing solid yet.

---

# Dev comments & leaked secrets (HTML source)
```
BUILD: 1.3.7-prod | Campus: wilcity | 2042-12-01
DEPLOY LOG
  v1.3.7 — sophie — "fixed session handling" (she didn't, wil checked)
  v1.3.6 — wil    — "added telemetry" (it's just a console.log)
  v1.3.5 — emilie — "filed 12 issues" (wil closed 11 as wontfix)
  v1.3.4 — wil    — "disabled defusedxml temporarily"
  v1.3.3 — wil    — "quick fix on file upload" (removed the whitelist entirely)
  v1.2.0 — sophie — jwt secret was "42" → "42network"
```
- `emilie: removed hardcoded credentials from this file (see git history if needed)`.
- `[WARN] 7 tickets assigned to @wil are past due (oldest: 2042-03)`.
- Backup/rsync: nightly sync `localhost:/opt/pocketbase/pb_data`, staff channel `#staff-darkly`.
