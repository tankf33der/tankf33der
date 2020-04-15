(load "@lib/http.l" "@lib/xhtml.l")
(allowed NIL "!short" u)
(de ukey NIL
   (pack
      (make
         (do 4
            (link
               (char
                  (case (rand 1 3)
                     (1 (rand 48 57))
                     (2 (rand 65 90))
                     (T (rand 97 122) ]
(pool "urls.db")
(de short (R)
   (seed (list (usec) *Pid))
   (if *Post
      (let K (ukey)
         (dbSync)
         (store NIL K (get 'u 'http))
         (commit 'upd)
         (respond (pack "http://127.0.0.1:8080/?" K "\n")) )
      (redirect (fetch NIL R)) ) )
(server 8080 "!short")
