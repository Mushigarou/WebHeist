# Unrestricted File Upload

`/upload/avatar` accepts any file type — the whitelist was removed — so a `.php` uploads fine.

## How I found it (comments, OSINT)
- [OSINT](../recon/osint.md): a comment said the upload whitelist was removed ("quick fix").
- Uploaded a non-image (`shell.sh`) to `/upload/avatar` → accepted, 302 with `upload_flag`.

## Exploit
`python3 exploit.py` → uploads `Resources/shell.sh` → flag in the redirect.

## Fix
Whitelist real image types (check content); store non-executable, outside web root.

## References
- OWASP: https://owasp.org/www-community/attacks/Unrestricted_File_Upload
- Related: [xxe](../xxe/explanation.md)
