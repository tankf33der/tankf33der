(load "@lib/http.l" @lib/xhtml.l")

(de mike1 (N)
   (msg N)
)
(server 8080 "!mike1")
