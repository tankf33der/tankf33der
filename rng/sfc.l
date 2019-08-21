(de add64 @
   (mod64 (pass +)) )
(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de sfc64_raw ("C") # without endianess swap
   (let D
      (add64
         (car (val "C"))
         (cadr (val "C"))
         (caddr (val "C")) )
      (set
         (nth (val "C") 1)
         (add64 (car (val "C")) 1)
         (nth (val "C") 2)
         (x|
            (caddr (val "C"))
            (>> 11 (caddr (val "C"))) )
         (nth (val "C") 3)
         (add64
            (cadddr (val "C"))
            (mod64 (>> -3 (cadddr (val "C")))) )
         (nth (val "C") 4)
         (add64
            D
            (|
               (mod64 (>> -24 (cadddr (val "C"))))
               (>> 40 (cadddr (val "C"))) ) ) )
      D ) )
(de sfc64_seed ("C" N)
   (set "C" (need 4 N))
   (set (val "C") 1) 
   (do 12 (sfc64_raw "C")) )

(off Sctx)
(sfc64_seed 'Sctx `(hex "5050505050505050"))
(test
   (quote
      13304661554259542759 721025649592675641
      10225151784302587394 3405643810333356647
      10622406643228381254 15322141046476238536
      12063287609152869934 6233142028658701493 )
   (make (do 8 (link (sfc64_raw 'Sctx)))) )

