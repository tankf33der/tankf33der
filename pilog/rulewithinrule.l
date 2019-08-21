(be stone (1 2))
(be stone (2 2))
(be mike (@C)
   (^ @ (apply = (cdr (-> @C)))) )
(be mike2 (@C)
   (equal @C (@ @A @A)) )
(test
    (solve '((mike  (stone 1 2))))
    (solve '((mike2 (stone 1 2)))) )
(test # T 
   (solve '((mike (stone 2 2))))
   (solve '((mike2 (stone 2 2)))) )

(msg 'ok)
(bye)
