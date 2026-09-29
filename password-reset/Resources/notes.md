# Evidence — Password Reset

Forum PSA (thread `r8y1ib6ub8g47u2`, jdoe):
> "Used the password reset. The link worked instantly — no email, the token was
> just sitting in the URL. And that token is literally the md5 of my email
> address. Anyone could reset anyone's account this way."

- Endpoint: `POST /reset-password/confirm` (form: `email`, `token`, `new_password`).
- Token = `md5(email)`. Verified: `md5("jdoe@student.42.tech")` = `5ae99e7ca0a3fd84337cecfa705f5321` (the captured token).
- Raw request/response: [http-capture.md](http-capture.md).
