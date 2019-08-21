# from Practically random v0.93

(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de add64 (A B)
   (mod64 (+ A B)) )
(de totwo (N)
   (or (ge0 N) (x| (dec (abs N)) `(hex "FFFFFFFFFFFFFFFFFF"))) )
# yoke as is
# link swap
(de endianess (N)
   (make
      (do 8
         (link (& `(hex "FF") N))
         (setq N (>> 8 N)) ) ) )
(de jsf64_raw ("C")
   (let E 
      (mod64
         (totwo
            (- 
               (car (val "C")) 
               (|
                  (mod64 (>> -39 (cadr (val "C")))) 
                  (>> 25 (cadr (val "C"))) ) ) ) )
      (set
         (nth (val "C") 1) 
         (x| 
            (cadr (val "C")) 
            (| 
               (mod64 (>> -11 (caddr (val "C"))))
               (>> 53 (caddr (val "C"))) ) )
         (nth (val "C") 2)
         (add64 (caddr (val "C")) (cadddr (val "C")))
         (nth (val "C") 3)
         (add64 (cadddr (val "C")) E)
         (nth (val "C") 4)
         (add64 (car (val "C")) E) )
      (endianess (last (val "C"))) ) )
(de jsf64_seed ("C" N)
   (set "C" (need 4 N))
   (set (val "C") `(hex "f1ea5eed"))
   (do 20 (jsf64_raw "C")) )

(off Jctx)
(jsf64_seed 'Jctx `(hex "5050505050505050"))
(test (9 46 201 100 239 33 15 86) (jsf64_raw 'Jctx))

