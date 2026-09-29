# Stored XSS + Session Hijacking

Forum comments store raw HTML/JS, so a comment runs in the bot's browser; its `flag` cookie isn't HttpOnly.

## How I found it (browser)
- Confirmed XSS (alert popped).
- [OSINT](../recon/osint.md): `/api/collect?c=` logs input, returns it on GET.
- Payload `fetch("/api/collect?c="+document.cookie)` → bot runs it, its `flag` cookie lands in `/api/collect`.

## Exploit
Store [`exploit.html`](exploit.html) as a comment; read cookie at `GET /api/collect`.

## Fix
Escape HTML; set cookies `HttpOnly`; add CSP; drop the debug `/api/collect`.

## References
- OWASP: https://owasp.org/Top10/2025/A05_2025-Injection/
- Related: [pocketbase-admin](../pocketbase-admin/explanation.md)
