# PocketBase Admin — God Export

PocketBase admin is exposed on `:8090/_/` and its creds leaked via XXE → full DB access; flag in `internal_audit`.

## How I found it (browser)
- Source comments referenced `internal_audit`.
- Logged into PB admin with the creds leaked by [xxe](../xxe/explanation.md).
- Opened `internal_audit` → flag in a record's `note`.

## Exploit
`python3 exploit.py` → PB admin auth (leaked creds) → read `internal_audit` → flag.

## Fix
Don't expose the admin panel; rotate the password; don't store secrets in readable collections.

## References
- OWASP: https://owasp.org/Top10/2025/A02_2025-Security_Misconfiguration/
- Related: [xxe](../xxe/explanation.md) (leaked the creds)
