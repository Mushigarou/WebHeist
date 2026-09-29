# Path Traversal

`/projects/download?file=` joins paths unchecked — any logged-in user can read any file.

## How I found it (browser, Burp, inspect)
- [OSINT comments](../recon/osint.md) pointed to a download endpoint serving any file.
- `/etc/passwd`, `/etc/shadow` returned empty.
- [`/backup` headers](../recon/osint.md#response-headers-debug-leaks) leaked `x-backup-exclude: data/private_notes.txt`.
- Read it via `../../` as a student → flag (see [leaked note](Resources/notes.md)).

## Exploit
`GET /projects/download?file=../../data/private_notes.txt`

## Fix
Strip `../`, resolve the real path, confine to the allowed folder.

## References
- OWASP: https://owasp.org/www-community/attacks/Path_Traversal
- Related: [pocketbase-admin](../pocketbase-admin/explanation.md) · [xxe](../xxe/explanation.md)
