(load "hash/xxhash.l")
(de hash32 (S)
   (xxhash32
      (mapcar char (chop S)) ) )
(off H)

# insert
(idx 'H (cons (hash32 'mike) 'mike) T)
(idx 'H (cons (hash32 'nick) 'nick) T)

# lookup
(println
   (lup H (hash32 'mike)) )

(msg 'ok)
(bye)
