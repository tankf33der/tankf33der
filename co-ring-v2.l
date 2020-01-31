`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))

(de i7-wrap (N Input)
   (co (intern (pack 'i7 N))
      (let
         (N N
            Input Input
            Send (intern (pack 'i7 (if (= 3 N) 1 (inc N))))
         )
         (yield)
         (println 'boom N Input)
         (msg 1)
         (while Input
            (println (++ Input)) )
         (yield 456 Send)
      )
   )
)

# prepear
(i7-wrap 1 (list 1 11))
(i7-wrap 2 (list 22))
(i7-wrap 3 (list 33))

# go
(yield T 'i71)

(msg 'ok)
(bye)
