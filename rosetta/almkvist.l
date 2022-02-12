# https://www.rosettacode.org/wiki/Almkvist-Giullera_formula_for_pi
(de fact (N)
   (cache '(NIL) N
      (if (=0 N)
         1
         (* N (fact (dec N))) ) ) )
(de almkvist (N)
   (let
      (A (* 32 (fact (* 6 N)))
         B (+ (* 532 N N) (* 126 N) 9)
         C (* (** (fact N) 6) 3) )
      (/ (* A B) C) ) )
(msg 'ok)
(bye)
