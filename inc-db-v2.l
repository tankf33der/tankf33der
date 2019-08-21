# Evolution
# small but significant changes against inc-db.l

`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))

(de worker (ID)
   (co ID
      (let C (rand 100 1000)
         (yield C)
         (do C
            (yield ID)
            (inc!> '{2} 'c 1) )
         NIL ) ) )

(class +Inc +Entity)
(rel c (+Number))
(pool (tmp "inc-v2.db"))
(new! '(+Inc) 'c 0)

(setq 
   W (mapcar format (range 1 100))
   Sum (sum prog (mapcar worker W)) )
(while (setq W (filter worker W)))
(test Sum (get '{2} 'c))
(msg 'OK-inc-db-v2)

