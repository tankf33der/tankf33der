(setq Lst (range 1 16))
(println 'start Lst)
(for (L (nth Lst 1) L (nth (cdr L) 4))
   (println 'L L) ) 
(println 'end Lst)

(msg 'ok)
(bye)
