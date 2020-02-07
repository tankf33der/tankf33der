# intcode warmup
(de c ("Var" Lst)
   (put "Var" 'c Lst)
   (put "Var" 'l (length (get "Var" 'c))) )
(off R)
(c 'R (range 1 10))
(put 'R 'c 3 333)
(show 'R)

(msg 'ok)
(bye)
