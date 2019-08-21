(de accu1 (Var Acc Key)
   (if (member Key (val Var))
      (inc Acc 1)
      (push Var Key)
      (inc Acc 2) ) )
(de main ()
   (let (R NIL  S 0)
      (accu1 'R 'S 2)
      (accu1 'R 'S 2)
      (println 'R R 'S S) ) )

(main)      

(bye)
