(load "twofish-sbox.l")

(de mod8 (N)
   (& N `(hex "FF")) )
(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de mod32+ @
   (mod32 (pass +)) )
(de mod32* @
   (mod32 (pass *)) )
(de leftRotate (X C)
   (| (mod32 (>> (- C) X)) (>> (- 32 C) X)) )
(de rightRotate (X C)
   (| (>> C X) (mod32 (>> (- C 32) X))) )
(de gfMult (A B P) # XXX overflow?
   (let R 0
      (do 7
         (and
            (bit? 1 A) (setq R (x| R B)) )
         (setq 
            A (>> 1 A)
            B
            (x|
               (if (=1 (>> 7 B)) P 0)
               (>> -1 B) ) ) )
      (and (bit? 1 A) (setq R (x| R B)))
      R ) )
(de mdsColumnMult (Mul01 Col)
   (let
      (Mul5B (gfMult Mul01 `(hex "5B") `(hex "169"))
         MulEF (gfMult Mul01 `(hex "EF") `(hex "169")) )
      (case Col
         (0
            (| 
               Mul01 
               (mod32 (>> -8 Mul5B))
               (mod32 (>> -16 MulEF))
               (mod32 (>> -24 MulEF)) ) )
         (1
            (| 
               MulEF
               (mod32 (>> -8 MulEF))
               (mod32 (>> -16 Mul5B))
               (mod32 (>> -24 Mul01)) ) )
         (2
            (| 
               Mul5B 
               (mod32 (>> -8 MulEF))
               (mod32 (>> -16 Mul01))
               (mod32 (>> -24 MulEF)) ) )
         (3
            (| 
               Mul5B 
               (mod32 (>> -8 Mul01))
               (mod32 (>> -16 MulEF))
               (mod32 (>> -24 Mul5B)) ) ) ) ) )
(de hFunc (X L1 L2)
   (x|
      (mdsColumnMult
         (get 
            *Sbox1
            (inc
               (x|
                  (get
                     *Sbox0 
                     (inc (x| (get *Sbox0 X) (car L2))) ) 
                  (car L1) ) ) ) 
         0 )
      (mdsColumnMult
         (get
            *Sbox0
            (inc
               (x|
                  (get
                     *Sbox0
                     (inc (x| (get *Sbox1 X) (cadr L2))) ) 
                  (cadr L1) ) ) ) 
         1 )
      (mdsColumnMult
         (get
            *Sbox1
            (inc
               (x|
                  (get 
                     *Sbox1
                     (inc (x| (get *Sbox0 X) (caddr L2))) ) 
                  (caddr L1) ) ) ) 
         2 )
      (mdsColumnMult
         (get 
            *Sbox0
            (inc
               (x| 
                  (get 
                     *Sbox1 
                     (inc (x| (get *Sbox1 X) (cadddr L2))) )
                  (cadddr L1) ) ) )
         3 ) ) )
(de createK (K)
   (let
      (K1 (head 4 K)
         K2 (head 4 (nth K 5))
         K3 (head 4 (nth K 9))
         K4 (tail 4 K) )
      (make
         (for (I 1 (>= 40 I) (+ 2 I))
            (let
               (A (hFunc I K1 K3)
                  B (leftRotate (hFunc (inc I) K2 K4) 8) )
               (link
                  (mod32+ A B)
                  (leftRotate (mod32+ A (mod32* 2 B)) 9) ) ) ) ) ) )
(de twofish (Lst Key)
   (let
      (*Stemp (need 8 0)
         Lst
         (need
            (- (>> -4 (>> 4 (+ 15 (length Lst)))))
            (copy Lst)
            0 )
         Key (need -16 (copy Key) 0)
         WhiteKeys (createK Key)
         S1 NIL
         S2 NIL
         S3 NIL
         S4 NIL )
      (for (S *Stemp S)
         (let K (cut 8 'Key)
            (do 4
               (for N K
                  (set S
                     (x| (car S) (gfMult N (pop '*RS) `(hex "14D"))) ) )
               (pop 'S) ) ) )
      (setq # depression
         S1
         (make
            (for I 256
               (link
                  (mdsColumnMult
                     (get
                        *Sbox1
                        (inc
                           (x|
                              (get
                                 *Sbox0
                                 (inc (x| (get *Sbox0 I) (get *Stemp 1))) )
                              (get *Stemp 5) ) ) )
                     0 ) ) ) )
         S2
         (make
            (for I 256
               (link
                  (mdsColumnMult
                     (get
                        *Sbox0
                        (inc
                           (x|
                              (get
                                 *Sbox0
                                 (inc (x| (get *Sbox1 I) (get *Stemp 2))) )
                              (get *Stemp 6) ) ) )
                     1 ) ) ) )
         S3
         (make
            (for I 256
               (link
                  (mdsColumnMult
                     (get
                        *Sbox1
                        (inc
                           (x|
                              (get
                                 *Sbox1
                                 (inc (x| (get *Sbox0 I) (get *Stemp 3))) )
                              (get *Stemp 7) ) ) )
                     2 ) ) ) )
         S4
         (make
            (for I 256
               (link
                  (mdsColumnMult
                     (get
                        *Sbox0
                        (inc
                           (x|
                              (get
                                 *Sbox1
                                 (inc (x| (get *Sbox1 I) (get *Stemp 4))) )
                              (get *Stemp 8) ) ) )
                     3 ) ) ) ) )
      (let
         (Start (apply circ (cut 4 'WhiteKeys))
            End (apply circ (cut 4 'WhiteKeys))
            WhiteKeys (apply circ WhiteKeys)
            A NIL
            B NIL
            C NIL
            D NIL )
         (make
            (while Lst
               (setq
                  A
                  (|
                     (pop 'Lst)
                     (>> -8 (pop 'Lst))
                     (>> -16 (pop 'Lst))
                     (>> -24 (pop 'Lst)) )
                  A (x| A (pop 'Start))
                  B
                  (|
                     (pop 'Lst)
                     (>> -8 (pop 'Lst))
                     (>> -16 (pop 'Lst))
                     (>> -24 (pop 'Lst)) )
                  B (x| B (pop 'Start))
                  C
                  (|
                     (pop 'Lst)
                     (>> -8 (pop 'Lst))
                     (>> -16 (pop 'Lst))
                     (>> -24 (pop 'Lst)) )
                  C (x| C (pop 'Start))
                  D
                  (|
                     (pop 'Lst)
                     (>> -8 (pop 'Lst))
                     (>> -16 (pop 'Lst))
                     (>> -24 (pop 'Lst)) )
                  D (x| D (pop 'Start)) )
               (do 8
                  (let (Temp1 NIL  Temp2 NIL)
                     (setq
                        Temp2
                        (x|
                           (get S2 (inc (mod8 B)))
                           (get S3 (inc (mod8 (>> 8 B))))
                           (get S4 (inc (mod8 (>> 16 B))))
                           (get S1 (inc (mod8 (>> 24 B)))) )
                        Temp1
                        (mod32+
                           Temp2
                           (x|
                              (get S1 (inc (mod8 A)))
                              (get S2 (inc (mod8 (>> 8 A))))
                              (get S3 (inc (mod8 (>> 16 A))))
                              (get S4 (inc (mod8 (>> 24 A)))) ) )
                        C (rightRotate (x| C (mod32+ Temp1 (pop 'WhiteKeys))) 1)
                        D
                        (x|
                           (leftRotate D 1)
                           (mod32+ (pop 'WhiteKeys) Temp1 Temp2) )
                        Temp2
                        (x|
                           (get S2 (inc (mod8 D)))
                           (get S3 (inc (mod8 (>> 8 D))))
                           (get S4 (inc (mod8 (>> 16 D))))
                           (get S1 (inc (mod8 (>> 24 D)))) )
                        Temp1
                        (mod32+
                           Temp2
                           (x|
                              (get S1 (inc (mod8 C)))
                              (get S2 (inc (mod8 (>> 8 C))))
                              (get S3 (inc (mod8 (>> 16 C))))
                              (get S4 (inc (mod8 (>> 24 C)))) ) )
                        A (rightRotate (x| A (mod32+ Temp1 (pop 'WhiteKeys))) 1)
                        B 
                        (x|
                           (leftRotate B 1)
                           (mod32+ (pop 'WhiteKeys) Temp1 Temp2) ) ) ) )
               (let
                  (Ta (x| C (pop 'End))
                     Tb (x| D (pop 'End))
                     Tc (x| A (pop 'End))
                     Td (x| B (pop 'End)) )
                     (link
                        (mod8 Ta)
                        (mod8 (>> 8 Ta))
                        (mod8 (>> 16 Ta))
                        (mod8 (>> 24 Ta))
                        (mod8 Tb)
                        (mod8 (>> 8 Tb))
                        (mod8 (>> 16 Tb))
                        (mod8 (>> 24 Tb))
                        (mod8 Tc)
                        (mod8 (>> 8 Tc))
                        (mod8 (>> 16 Tc))
                        (mod8 (>> 24 Tc))
                        (mod8 Td)
                        (mod8 (>> 8 Td))
                        (mod8 (>> 16 Td))
                        (mod8 (>> 24 Td)) ) ) ) ) ) ) )
(de twofish_hex (Lst Key)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (twofish Lst Key) ) ) )
