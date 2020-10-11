(de numL (N Base)
   (let L NIL
      (loop
         (let C (% N Base)
            (and (> C 9) (inc 'C 39))
            (push 'L (+ C 48) ) )
            # (push 'L (char (+ C `(char "0")))) )
         (T (=0 (setq N (/ N Base)))) )
      L ) )

(println (numL 1234 2))
(println (numL 1234 3))
(println (numL 1234 12))
(println (numL 1234 16))

(msg 'ok)
(bye)
