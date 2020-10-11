(de numToString (N Base)
   (default Base 10)
   (let L NIL
      (loop
         (let C (% N Base)
            (and (> C 9) (inc 'C 39))
            (push 'L (char (+ C `(char "0")))) )
         (T (=0 (setq N (/ N Base)))) )
      (pack L) ) )

(msg 'ok)
(bye)
