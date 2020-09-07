(load "des-const.l")
(de hex2L (L)
   (make
      (while (cut 2 'L)
         (link (hex (pack @))) ) ) )
(de bin64 (L)
   (mapcan
      '((N)
         (chop (pad 8 (bin N))) )
      L ) )
(de rotate (L N)
   (append (nth L (inc N)) (head N L)) )
(de getL (Lst N)
   (let (X 1  Y N)
      (when (> N 28)
         # orgasmic
         (inc 'X)
         (dec 'Y 28) )
      (get Lst X Y) ) )
(de subkeys (K)
   (let
      (B (bin64 K)
         KK (mapcar '((I) (get B I)) *PC1)
         # split
         C0 (head 28 KK)
         D0 (tail 28 KK)
         # pairs
         PP
         (make
            (mapc
               '((S)
                  (link
                     (make
                        (link
                           (setq C0 (rotate C0 S))
                           (setq D0 (rotate D0 S)) ) ) ) )
               *SHIFTS ) ) )
      (mapcar
         '((L)
            (bin (mapcar '((N) (getL L N)) *PC2)) )
         PP ) ) )
(test
   223465186400245
   (last (subkeys (hex2L (chop "133457799BBCDFF1")))) )
(de rF (A B)
   (let
      (A1 (chop (pad 32 (bin A)))
         # overwrite
         A1
         (chop
            (pad
               48
               (bin
                  (x|
                     B
                     (bin (mapcar '((I) (get A1 I)) *E)) ) ) ) )
         # again
         A1
         (mapcan
            '((A B)
               (let
                  (X (bin (list (car B) (last B)))
                     Y (bin (head 4 (cdr B))) )
                  (chop
                     (pad
                        4
                        (bin
                           (get A (inc (+ (* 16 X) Y))) ) ) ) ) )
            *S
            (make (while (cut 6 'A1) (link @))) ) )
      (bin (mapcar '((I) (get A1 I)) *P)) ) )
(test
   473342384
   (rF 123456789 987654321) )
(test
   1507189517
   (rF 12345678 87654321) )
(test
   3639529468
   (rF 0 87654321) )


#{
(setq
   Da (hex2L (chop "0123456789ABCDEF"))
   B (bin64 Da)
   KK (mapcar '((I) (get B I)) *IP) )
(println (pack KK))
}#


(msg 'ok)
(bye)
