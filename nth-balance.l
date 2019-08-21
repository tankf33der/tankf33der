(seed (in "/dev/urandom" (rd 8)))

# try on one tree
(off Tr)
(off L)
(setq 
   L
   (make 
      (for X 256
         (link (cons X (rand 1 256))) ) ) )
(balance 'Tr L)
(println (lup Tr 123))
(con (lup Tr 123) (rand 10 20))
(println (lup Tr 123))

# try 4 trees in list
# '(((1 . X) .. (256 . X)) ((1 . X) .. (256 . X)) ..)
(off Tr L Lst)
(setq *P (need 18 0))
(setq *S0 (range 30 50))
(setq *S1 (range 100 110))
(println *S1)
(setq Lst (need 3))
(map
   '((A B)
      (balance
         B
         (make
            (for (I . N) (val (car A))
               (link (cons I N)) ) ) ) )
   '(*P *S0 *S1)
   Lst )
(println 'Lst (last Lst))
(println (lup (car (nth Lst 2)) 19))
(con (lup (car (nth Lst 2)) 19) 777)
(println (lup (car (nth Lst 2)) 19))


(msg 'ok)
(bye)
