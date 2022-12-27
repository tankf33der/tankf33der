# https://rosettacode.org/wiki/Priority_queue
(off PQ)

(setq PQ '((1 (mike P))))

(de insertPQ (Q Lst)
   (for (I . L) (val Q)
      (println 'I I 'L L (car L) (car Lst) (< (car L) (car Lst)))
      (T (< (car L) (car Lst)) (insert I (val Q)))
   )
   (insert 2 (val Q))
)



(insertPQ 'PQ '(3 (Clear drains)))

(println PQ)
(println (insert 2 PQ 2))

(msg 'ok)
(bye)
