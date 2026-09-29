# Evidence — File Upload

- Endpoint: `POST /upload/avatar` (multipart, field `file`).
- Upload any non-image (e.g. `shell.sh`) — the whitelist was removed in v1.3.3.
- 302 → `/profile/me/settings?upload_flag=FLAG{unr3str1ct3d_upl0ad_g0_brrr}`.
- Flag: `FLAG{unr3str1ct3d_upl0ad_g0_brrr}`
