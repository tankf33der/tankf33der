(setq *XOROSTATE (1 2)) # seed hint: splitmix64
(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de rol64 (X C)
   (| (mod64 (>> (- C) X)) (>> (- 64 C) X)) )
(de xoronext NIL
   (let 
      (S0 (car *XOROSTATE)
         S1 (cadr *XOROSTATE)
         R (mod64 (+ S0 S1))
         S1 (x| S1 S0) )
      (set
         *XOROSTATE (x| (rol64 S0 55) S1 (mod64 (>> -14 S1)))
         (cdr *XOROSTATE) (rol64 S1 36) )
      R ) )
(de xorojump NIL
   (let (S0 0  S1 0)
      (for C (27 37)
         (do C
            (setq
               S0 (x| S0 (car *XOROSTATE))
               S1 (x| S1 (cadr *XOROSTATE)) ) )
         (xoronext) )
      (set *XOROSTATE S0 (cdr *XOROSTATE) S1) ) )

