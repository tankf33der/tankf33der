(load "@lib/simul.l")
(symbols 'simul 'pico)
(de display ()
   (for L G
      (for This L
         (prin ".")
      )
      (prinl)
   )
)

(setq G (grid 26 80 T T))
(setq S (list 0 NIL))
(fifo (cdr S) 'm39)
(inc S)
(fifo (cdr S) 'm40)
(inc S)
(fifo (cdr S) 'm41)
(inc S)
(println 'S S)
(println 'north)
# (println G)
# (show 'z80)
(display)

(with 'm40
   (println (north This)) )

(msg 'ok)
(bye)
