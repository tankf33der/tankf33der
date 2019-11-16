(load "@lib/simul.l")

(setq Grid (grid 5 5))
(zero C)

(for G Grid
   (for This G
      (=: V (inc 'C))
   )
)  
(show 'a2)
(prinl)
(mapc
   '((L)
      (for This L (prin (align 4 (: V))))
      (prinl) )
   Grid )

(with 'a1
   (println (south This))
)


(msg 'ok)
(bye)
