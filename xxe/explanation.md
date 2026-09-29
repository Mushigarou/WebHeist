# XXE — XML External Entity

`/agenda/import` parses XML with entities enabled, so an entity reads the localhost-only `/internal/config`.

## How I found it (browser)
- Leaked `/backup` headers + source comments said `/internal/config` is **localhost-only**.
- The app runs on localhost, so I made the XML importer fetch it via an external entity `&xxe;`.
- Uploaded the XML through the agenda import → response returned the full JSON: pocketbase creds + flag.

## Exploit
`python3 exploit.py` → POST `exploit.xml` to `/agenda/import`.

## Fix
Use defusedxml; disable DTDs and external entities.

## References
- OWASP: https://owasp.org/www-community/vulnerabilities/XML_External_Entity_(XXE)_Processing
- Related: [pocketbase-admin](../pocketbase-admin/explanation.md) (leaked pb creds) · [jwt-forgery](../jwt-forgery/explanation.md) (leaked secret)
