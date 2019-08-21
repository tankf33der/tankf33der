(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de swap1 (N)
   (|
      (mod64 (>> -1 (& N `(hex "5555555555555555"))))
      (>> 1 (& N `(hex "AAAAAAAAAAAAAAAA"))) ) )
(de swap2 (N)
   (|
      (mod64 (>> -2 (& N `(hex "3333333333333333"))))
      (>> 2 (& N `(hex "CCCCCCCCCCCCCCCC"))) ) )

(for (X (>> -31 1) (> (>> -66 1) X) (inc X))
   (println (swap1 X) (swap2 X)) )


(bye)
