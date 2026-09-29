# Evidence — IDOR

- `/profile/<id>` is reachable by any logged-in user; ids appear in every link (forum, user list).
- wil's id `k1asdfeditojrb4` → `/profile/k1asdfeditojrb4` renders his **Private note**:
  `FLAG{1d0r_ur_pr0f1l3_1s_m1n3}`
- `GET /api/profile` is PATCH-only (405) — the leak is the HTML profile page, not the API.
