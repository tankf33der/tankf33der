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
         (setq X 2  Y (- N 28)) )
      (get Lst X Y) ) )
(de subkeys (K)
   (let
      (B (bin64 K)
         KK (mapcar '((I) (get B I)) *PC1)
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
            (bin
               (pack (mapcar '((N) (getL L N)) *PC2)) ) )
         PP ) ) )
(test
   223465186400245
   (last (subkeys (hex2L (chop "133457799BBCDFF1")))) )

(setq
   Da (hex2L (chop "0123456789ABCDEF"))
   B (bin64 Da)
   KK (mapcar '((I) (get B I)) *IP) )
(println (pack KK))



(msg 'ok)
(bye)
