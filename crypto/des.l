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
(de encrypt (Key Msg)
   (let
      (Msg (bin64 Msg)
         Msg (mapcar '((I) (get Msg I)) *IP)
         # split
         Lo (bin (head 32 Msg))
         Ro (bin (tail 32 Msg))
         L NIL
         R NIL )
      (mapc
         '((Key)
            (setq
               L Ro
               R (x| Lo (rF Ro Key))
               Lo L
               Ro R ) )
         (subkeys Key) )
      (setq R
         (chop
            (pad 64 (bin (x| (>> -32 R) L))) ) )
      (pad
         16
         (hex
            (bin (mapcar '((I) (get R I)) *IP_INV)))) ) )
