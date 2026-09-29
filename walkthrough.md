# Darkly — Combined Walkthrough

Audit of `http://localhost:4942` (and its PocketBase backend on `:8090`).
Full per-breach detail is in each folder's `explanation.md`; this ties them together.

## 1. Recon
- `robots.txt` → hidden paths (`/admin`, `/staff`, `/backup`, `/internal`, `/_/`, …).
- HTML comments, console eggs and the deploy log leak a lot: the JWT secret history (`42` → `42network`), endpoints, and a debug `/api/collect`.
- `/backup` response headers leak the backup config (incl. `data/private_notes.txt` and `x-pocketbase: :8090`).
- Forum PSAs explain the reset flaw and the md5 hints.
- Full notes: [recon/osint.md](recon/osint.md).

## 2. The privilege chain (student → staff → god)
1. **Leak the config** — [xxe](xxe/explanation.md): upload XML to `/agenda/import`; an external entity reads the localhost-only `/internal/config`, leaking the JWT secret `42network`, the PocketBase admin creds, and a flag.
2. **Forge any session** — [jwt-forgery](jwt-forgery/explanation.md): with `42network`, sign a JWT for any user/role. IDs come from [user-enumeration](user-enumeration/explanation.md) (`/api/users`) and `/profile/<id>`.
3. **Or take over an account** — [weak-password-hash](weak-password-hash/explanation.md): `/staff/dashboard` lists md5 `pw_hint`s; crack → jdoe `123456`, benjamin `b3njamin!`. Or [password-reset](password-reset/explanation.md): the reset token is just `md5(email)`.
4. **Or just promote yourself** — [privilege-escalation](privilege-escalation/explanation.md): `PATCH /api/profile {"role":"cadet"}`, then open `/staff/dashboard`.
5. **Own the database** — [pocketbase-admin](pocketbase-admin/explanation.md): log into PB admin `:8090/_/` with the leaked creds; the flag sits in the `internal_audit` collection.

## 3. Other breaches
- [path-traversal](path-traversal/explanation.md): `/projects/download?file=../../…` reads any file.
- [idor](idor/explanation.md): `/profile/<id>` exposes any user's private note.
- [stored-xss](stored-xss/explanation.md): a forum comment runs in the bot's browser and exfiltrates its non-HttpOnly `flag` cookie to `/api/collect`.
- [file-upload](file-upload/explanation.md): `/upload/avatar` accepts any file type.

## 4. Flags (8)
| Flag | Breach |
|---|---|
| `FLAG{d0t_d0t_sl4sh_4ll_th3_w4y_d0wn}` | path-traversal |
| `FLAG{d3fus3dxml_n3xt_spr1nt_pr0m1s3}` | xxe |
| `FLAG{1d0r_ur_pr0f1l3_1s_m1n3}` | idor |
| `FLAG{just_p4tch_y0ur_0wn_r0l3_lol}` | privilege-escalation |
| `FLAG{md5_1s_4_n4m3pl4t3_n0t_4_l0ck}` | weak-password-hash |
| `FLAG{xss_st0r3d_1s_n0t_4_f34tur3_w1l}` | stored-xss |
| `FLAG{unr3str1ct3d_upl0ad_g0_brrr}` | file-upload |
| `FLAG{th3_und3rsc0r3_sl4sh_kn0ws_th3_w4y}` | pocketbase-admin |

**11 vulnerabilities** documented (mandatory needs 10) · **8 flags** (mandatory needs 6).
