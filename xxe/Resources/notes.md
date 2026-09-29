# Evidence — XXE

- Endpoint: `POST /agenda/import` (multipart, field `file`).
- Payload: [../exploit.xml](../exploit.xml) — entity `&xxe;` = `SYSTEM http://localhost:4942/internal/config`.
- Leaked config: [leaked-config.json](leaked-config.json) — jwt_secret, pb_admin creds, `darkly_flag`.
