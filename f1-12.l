(de f1-12 (Str)
   (glue 
      NIL
      (mapcon
         '((L)
            (unless (= (car L) (cadr L))
               (cons (car L)) ) )
         (chop Str) ) ) )
(test
   "a ab abc" 
   (f1-12 "a ab  abc") )

(msg 'ok)
(bye)
