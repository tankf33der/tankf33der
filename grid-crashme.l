# not a crash (jun 2019), check ulimit -s 

(load "@lib/simul.l")

(setq G (grid 1000 1000))
(for Col G (for This Col (=: B6 1)))

(println 'im-ok-here)
(bye)
