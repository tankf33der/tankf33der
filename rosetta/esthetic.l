(de stringToNum (S Base)
   (default Base 10)
   (let N 0
      (for C (chop S)
         (when (> (setq C (- (char C) `(char "0"))) 9)
            (dec 'C 39) )
         (setq N (+ C (* N Base))) )
      N ) )
(de numL (N Base)
   (let L NIL
      (loop
         (let C (% N Base)
            #(and (> C 9) (inc 'C 39))
            (push 'L C) )
            #(push 'L (+ C 48) ) )
            # (push 'L (char (+ C `(char "0")))) )
         (T (=0 (setq N (/ N Base)))) )
      L ) )

(println (numL 2730 2))
# (println (numL 1234 3))
(println (numL 355 9))
(println (numL 2985 16))
(println (stringToNum "434" 9))


(msg 'ok)
(bye)
