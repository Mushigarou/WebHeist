# Evidence — PocketBase Admin

- Admin panel: `http://localhost:8090/_/` — creds leaked via [xxe](../../xxe/explanation.md): `admin@42network.local` / `Darkly42Admin!`.
- Flag record: collection `internal_audit` (id `jr14rsbssjmwfrm`), record `go4l9rxo0hlid0h`:
  `note = "god-tier export OK — flag retained for the security audit: FLAG{th3_und3rsc0r3_sl4sh_kn0ws_th3_w4y}"`
- Verified via the PB admin API (auth-with-password → GET `internal_audit` records).
