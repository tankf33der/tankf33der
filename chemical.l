# parse and validate chemical formulas
# http://pyparsing.wikispaces.com/file/view/chemicalFormulas.py/31041705/chemicalFormulas.py
#
(setq *F
   (quote
      ("O" . 16)
      ("H" . 1)
      ("Na" . 23)
      ("Cl" . 35)
      ("C" . 12)
      ("S" . 32) ) )
(de weights (Lst)
   (make
      (for (C Lst C)
         (let (R (cons (pop 'C)) N)
            (while (and C (<= `(char "a") (char (pop C)) `(char "z")))
               (queue 'R (pop 'C)) )
            (while (and C (format (pop C)))
               (queue 'N (pop 'C)) )
            (link (cons (cdr (assoc (pack R) *F)) (or (format N) 1))) ) ) ) )
(de summa (Str) # and validation
   (let S 0
      (for L (weights (chop Str))
         (NIL (car L) (off S))
         (inc 'S (* (car L) (cdr L))) )
      S ) )
(test 48 (summa "OOO"))
(test 3 (summa "HHH"))
(test 18 (summa "H2O"))
(test 58 (summa "NaCl"))
(test 94 (summa "C6H5OH"))
(test 98 (summa "H2SO4"))
(test NIL (summa "A"))
(test NIL (summa "HA"))
(test NIL (summa "Naa"))
(test NIL (summa "123"))
(msg 'ok)
(bye)
