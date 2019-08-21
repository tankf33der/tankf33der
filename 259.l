(setq *D NIL)
(de init*D ()
   (for I 26
      (accu '*D (char (+ 96 I)) I) ) )
(de sum*D (Str)
   (sum
      '((C)
         (cdr (assoc C *D)) )
      (chop Str) ) )
(init*D)
(println
   (sum*D "two hundred and fifty nine") )

