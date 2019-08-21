(de foldl (F I . @)
   (pass 
      mapc
      '(@ 
         (setq I (apply F (conc (rest) (cons I)))) ) ) )
(test 
   10
   (foldl '+ 0 (1 2 3 4)) )
(test
   (range 5 1)
   (foldl 'cons NIL (1 2 3 4 5)) )
(test
   -27
   (foldl
      '((A B R) (* R (- A B)))
      1
      (1 2 3)
      (4 5 6) ) )
(msg 'ok)
(bye)
