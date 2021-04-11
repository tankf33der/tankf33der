(setq E '(NIL))

(for (I . S) (range 1 7)
   (set (enum 'E I) S) )

(println 'E E)
(set (enum 'E 8))


(println (val (enum? E 7)))


(msg 'ok)
(bye)
