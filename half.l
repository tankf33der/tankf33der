# super slow
(de half-tankfeeder (Lst)
   (let Flg NIL
      (by '(NIL (onOff Flg)) group Lst) ) )
# super fast
(de half-Regenaxer (Lst)
      (list
         (filter prog2 Lst '(T NIL .))
         (filter prog2 Lst '(NIL T .)) ) )
(test
   (half-tankfeeder (range 1 128))
   (half-Regenaxer (range 1 128)) )

(de half-universal (Lst N)
   (let L (apply circ (need N '(T)))
      (make
         (do N
            (link 
               (filter prog2 Lst (rot L)) ) ) ) ) )
(test
   '((1 3 5 7 9 11 13 15 17 19) (2 4 6 8 10 12 14 16 18 20))
   (half-universal (range 1 20) 2) )
(test
   '((1 5 9 13 17) (2 6 10 14 18) (3 7 11 15 19) (4 8 12 16 20))
   (half-universal (range 1 20) 4) )
(test
   '((1 11) (2 12) (3 13) (4 14) (5 15) (6 16) (7 17) (8 18) (9 19) (10 20))
   (half-universal (range 1 20) 10) )

(msg 'ok)
(bye)
