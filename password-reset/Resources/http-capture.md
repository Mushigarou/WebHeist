POST /reset-password/confirm HTTP/1.1
Host: localhost:4942
Content-Length: 87
Cache-Control: max-age=0
sec-ch-ua: "Not;A=Brand";v="8", "Chromium";v="150"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Linux"
Accept-Language: en-US,en;q=0.9
Upgrade-Insecure-Requests: 1
Content-Type: application/x-www-form-urlencoded
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36
Origin: http://localhost:4942
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Sec-Fetch-Site: same-origin
Sec-Fetch-Mode: navigate
Sec-Fetch-User: ?1
Sec-Fetch-Dest: document
Referer: http://localhost:4942/reset-password?email=jdoe@student.42.tech&token=5ae99e7ca0a3fd84337cecfa705f5321
Accept-Encoding: gzip, deflate, br
Connection: keep-alive

email=jdoe%40student.42.tech&token=5ae99e7ca0a3fd84337cecfa705f5321&new_password=123456


---


HTTP/1.1 302 Found
date: Thu, 24 Sep 2026 15:49:04 GMT
server: uvicorn
content-length: 0
location: /login?success=Password+updated
x-powered-by: Python/3.11 FastAPI/0.104
server: uvicorn/0.24.0 Linux
x-pocketbase: http://localhost:8090
x-42-internal: campus=paris




