#!/bin/env picolisp

#(setq *Delim "-_.,\"'*[]?!&@#$%^\(\):; ^I^J^M")
#(setq *Skip (chop *Delim))

(set 'F (opt))
#(zero W)
#(off I)
(println (lines F))
#(println (car (info F)))
#{
(in F
   (while (char)
      (case @
         (" " (off I))
         ("^J" (off I))
         (T
            (or
               I
               (inc 'W) )
            (on I) )
      )
   )
)

(println W)
}#
(bye)
