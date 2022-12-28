# https://rosettacode.org/wiki/Priority_queue
(off PQ)
(de insertPQ (Q Lst)
   (let C 1
      (set
         Q
         (insert
            (or
               (for L (val Q)
                  (T (> (car L) (car Lst)) C)
                  (inc 'C) )
               C )
            PQ
            Lst ) ) ) )
(insertPQ 'PQ '(3 (Clear drains)))
(insertPQ 'PQ '(4 (Feed cat)))
(insertPQ 'PQ '(5 (Make tea)))
(insertPQ 'PQ '(1 (Solve RC tasks)))
(insertPQ 'PQ '(2 (Tax return)))

(while PQ
   (println (cadr (++ PQ))) )

(msg 'ok)
(bye)
