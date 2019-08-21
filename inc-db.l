`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))

(de worker (ID)
   (let C (rand 100 1000)
      (co ID
         (do C
            (yield (cons ID C))
            (inc!> '{2} 'c 1) )
         NIL ) ) )

(class +Inc +Entity)
(rel c (+Number))
(pool (tmp "inc.db"))
(new! '(+Inc) 'c 0)

(setq 
   W
   (mapcar 
      '((N) (worker (format N)))
      (range 1 100) )
   Sum (sum cdr W) )
(while 
   (setq W
      (filter '((N) (worker (car N))) W) ) )
(test Sum (get '{2} 'c))
(msg 'OK-inc-db)
