(setq D
   (quote
      (a 3)
      (b 4)
      (c 5)
      (d 6 a b)
      (e 7 c z)
      (f 3 d c)
      (z 1)
      (t 3 d e) ) )

(de mm (L)
   (cond
      ((not L) 0)
      ((atom L)
         (let A (assoc L D)
            (ifn (cddr A)
               (cadr A)
               (+
                  (cadr A)
                  (mm (caddr A))
                  (mm (cdddr A)) ) ) ) )
      (T (+ (mm (car L)) (mm (cdr L)))) ) )

(test 0 (mm))
(test 3 (mm 'a))
(test 13 (mm 'd))
(test 13 (mm 'e))   
(test 21 (mm 'f))   
(test 29 (mm 't))   

(msg 'ok)
(bye)
