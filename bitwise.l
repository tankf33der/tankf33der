(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )

(de totwo (N)
   (or
      (ge0 N)
      (x| (dec (abs N)) `(hex "FFFFFFFF")) ) )

(de fromtwo (N)
   (if (> `(hex "80000000") N)
      N
      (- (x| (dec N) `(hex "FFFFFFFF"))) ) )

(de totwo22 (N)
   (let
      (Lst (mapcar format (flip (chop (bin (abs N)))))
         Lst (conc Lst (need (- 32 (length Lst)) 0))
         C 1 )
      (and 
         (lt0 N)
         (for (I . X) Lst 
            # reverse bits
            (set (nth Lst I) (if (=0 X) 1 0))
            # add 1
            (if 
               (= 
                  2 
                  (setq X (+ C (car (nth Lst I)))) )
               (set (nth Lst I) 0)
               (set (nth Lst I) X)
               (zero C) ) ) )
      Lst ) )

(de fromtwo22 (Lst)
   (let (C 1  S NIL  R NIL)
      (and 
         (setq S (= 1 (car (nth Lst 32))))
         (for (I . X) Lst
            (set (nth Lst I) (if (=0 X) 1 0))
            (if 
               (= 
                  2 
                  (setq X (+ C (car (nth Lst I)))) )
               (set (nth Lst I) 0)
               (set (nth Lst I) X)
               (zero C) ) ) )
      (setq R (bin (pack (flip Lst))))
      (if S (- R) R) ) )

(de bitwise (F N1 N2)
   (fromtwo
      (F (totwo N1) (totwo N2)) ) )

(de tilde (N)
   (fromtwo 
      (x| (totwo N) `(hex "FFFFFFFF")) ) )

(test -124 (tilde 123))
(test -1235 (tilde 1234))
(test -12346 (tilde 12345))
(test -123457 (tilde 123456))
(test -1234568 (tilde 1234567))
(test -12345679 (tilde 12345678))
(test -123456790 (tilde 123456789))
(test -1234567891 (tilde 1234567890))

(test
   -208
   (bitwise & -200 -14) )
(test
   -6
   (bitwise | -200 -14) )
(test
   202
   (bitwise x| -200 -14) )
(test
   -1234
   (bitwise & -1234 -1234) )
(test
   -1234
   (bitwise | -1234 -1234) )
(test
   0
   (bitwise x| -1234 -1234) )
(test
   -13562
   (bitwise & -12345 -1234) )
(test
   -17
   (bitwise | -12345 -1234) )
(test
   13545
   (bitwise x| -12345 -1234) )
(test
   (bitwise & 200 14)
   (& 200 14) )
(test
   (bitwise | 200 14)
   (| 200 14) )
(test
   (bitwise x| 200 14)
   (x| 200 14) )

# unsigned to signed
(test
   999999999
   (fromtwo (mod32 999999999)) )
(test
   1410065407
   (fromtwo (mod32 9999999999)) )
(test
   1215752191
   (fromtwo (mod32 99999999999)) )
(test
   -727379969
   (fromtwo (mod32 999999999999)) )

(msg 'OK-bitwise)

