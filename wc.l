#!/bin/env picolisp
(set 'F (opt))
(zero W)
(println (lines F))
(println (car (info F)))

(in F
   (while (from " " "\t" "\n" "\r")
      (inc 'W) ) )
(println W)

(bye)
