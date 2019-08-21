(de bsearch (@X)
   (curry 
      (@X) 
      (Lst)
      (let (Len (length Lst)  N 0  L NIL  Flg)
         (loop
            (T (=0 Len))
            (setq
               N (inc (/ Len 2))
               L (nth Lst N) )
            ((if (lst? (car L)) on off) Flg)
            (T (= @X (if Flg (caar L) (car L))) 
               (cons (car L)) )
            (if (> @X (if Flg (caar L) (car L)))
               (setq Lst (cdr L)  Len (- Len N))
               (setq Len (dec N)) ) ) ) ) )
(let
   (L1 (1 3 13 23 45 66 (77 . z) 888)
      L2
      (quote
         ((luda k)  1 (3 4 55))
         ((alex b)  3 (44 55))
         ((nick z) 13 (a b c))
         ((jura l) 23 (Z))
         ((john g) 45 (H))
         ((mary q) 66 (7 g g))
         ((mike p) 77 (g H j))
         ((jelena) 888 (X Y Z)) ) ) 
   (test
      '((77 . z))
      ((bsearch 77) L1) )
   (test
      (888)
      ((bsearch 888) L1) )
   (test
      '(((mike p) 77 (g H j)))
      (by cadr (bsearch 77) L2) ) )

(bye)
