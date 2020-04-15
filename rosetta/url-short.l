(load "@lib/http.l" "@lib/xhtml.l")
(allowed NIL "!short" u)
(pool "urls.db")
(de short (R)
   (if *Post
      (prog
         (store NIL 123 (get 'u 'http))
         (commit)
         (respond "kuku") )
      (ht:Prin "Get:" R "res:" (fetch NIL R) ";")
   )
)
(server 8080 "!short")
