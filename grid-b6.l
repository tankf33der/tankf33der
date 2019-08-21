(load "@lib/simul.l")
#(load "/home/mpech/simul.l")

(bench (setq G (grid 1000 1000)))
(bench
   (for Col G
      (for This Col
         (=: B6-1 0) ) ) )
(msg 'ok)
(bye
