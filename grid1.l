(load "@lib/simul.l")

(setq Grid (grid 5 5 T T))
(zero C)

(for G Grid
   (for This G
      (=: V (inc 'C))
   )
)  
(show 'a1)
(show 'a2)
(prinl)
(mapc
   '((L)
      (for This L (prin (align 4 (: V))))
      (prinl) )
   Grid )

(show (last (last Grid)))
(with 'e5
   (println 'east (east 'e5)) )
# cut corner
(with (last (last Grid))
   (con (: 0 1)) )
(show (last (last Grid)))
(with 'e5
   (println 'east (east 'e5)) )
(msg "next")
(with 'c3
   (show (north (east This)))
)

(msg 'ok)
(bye)
