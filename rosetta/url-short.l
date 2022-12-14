(load "@lib/http.l")
(allowed NIL "!short" u)
(pool "urls.db" (6))
(de short (R)
   (ifn *Post
      (redirect (fetch NIL (format R)))
      (let K (count)
         (dbSync)
         (store NIL K (get 'u 'http))
         (commit 'upd)
         (respond (pack "http://127.0.0.1:8080/?" K "\n")) ) ) )
(server 8080 "!short")
(wait)
