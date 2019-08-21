(let Lst (range 0 3)
   (for N Lst
      (when (=1 N)
         (println 'boom)
         (del (inc N) 'Lst) )
      (println N) ) )
(msg 'ok)
(bye)
