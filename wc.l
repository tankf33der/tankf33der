#!/bin/env picolisp
(setq *Delim " ^I^J^M-_.,\"'*[]?!&@#$%^\(\):;")
(setq *Skip (chop *Delim))

(set 'F (opt))
(zero W)
(println (lines F))
(println (car (info F)))

(in F
   (until (eof)
      (when (till *Delim)
         
         (inc 'W)
      )
      (char)
       ) )
(println W)

(bye)
