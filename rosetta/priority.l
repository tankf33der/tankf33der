# https://rosettacode.org/wiki/Priority_queue
(off PQ)

(setq PQ '((1 (mike P))))

(de insertPQ (Q Lst)
   (let C 1
   (for L (val Q)
      (T (> (car L) (car Lst)) I) )
   (set PQ (insert 2 (val Q) Lst))
)



(insertPQ 'PQ '(3 (Clear drains)))

# (println PQ)
# (setq PQ (insert 2 PQ 2))
(println PQ)


(msg 'ok)
(bye)
