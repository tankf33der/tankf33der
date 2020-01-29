# adventofcode 2019, day 7
#{ warmup
3 -->(+)-->--(+)-->--(+)---> 14
      ^       ^       ^
      |       |       |
      4       5       2
}#


(de sumsum (Lst)
   (apply + Lst) )
(de f (Lst)
   (let R (sumsum (head 2 Lst))
      (for N (cddr Lst)
         (setq R (sumsum (list R N))) )
      R
   )
)
(test 14 (f (3 4 5 2)))


(msg 'ok)
(bye)
