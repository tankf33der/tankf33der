(de mod128 (N)
   (& N `(hex "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")) )
(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de mod8 (N)
   (& N `(hex "FF")) )
(de rol128 (X C)
   (| (mod128 (>> (- C) X)) (>> (- 128 C) X)) )
(de rol32 (X C)
   (| (mod32 (>> (- C) X)) (>> (- 32 C) X)) )
(de rol8 (X C)
   (| (mod8 (>> (- C) X)) (>> (- 8 C) X)) )

(load "camellia-sbox.l")

(de f (A B)
   (let 
      (X (x| A B)
         T1 (car (nth *SBOX1 (inc (mod8 (>> 56 X)))))
         T2 (car (nth *SBOX2 (inc (mod8 (>> 48 X)))))
         T3 (car (nth *SBOX3 (inc (mod8 (>> 40 X)))))
         T4 (car (nth *SBOX4 (inc (mod8 (>> 32 X)))))
         T5 (car (nth *SBOX2 (inc (mod8 (>> 24 X)))))
         T6 (car (nth *SBOX3 (inc (mod8 (>> 16 X)))))
         T7 (car (nth *SBOX4 (inc (mod8 (>> 8 X)))))
         T8 (car (nth *SBOX1 (inc (mod8 X)))) )
      (|
         (>> -56 (x| T1 T3 T4 T6 T7 T8))
         (>> -48 (x| T1 T2 T4 T5 T7 T8))
         (>> -40 (x| T1 T2 T3 T5 T6 T8))
         (>> -32 (x| T2 T3 T4 T5 T6 T7))
         (>> -24 (x| T1 T2 T6 T7 T8))
         (>> -16 (x| T2 T3 T5 T7 T8))
         (>> -8  (x| T3 T4 T5 T6 T8))
         (x| T1 T4 T5 T6 T7) ) ) ) 
(de fl (A B)
   (let
      (X1 (>> 32 A)
         X2 (mod32 A)
         X2 (x| X2 (rol32 (& X1 (>> 32 B)) 1))
         X1 (x| X1 (| X2 (mod32 B))) )
      (| (>> -32 X1) X2) ) )
(de flinv (A B)
   (let
      (X1 (>> 32 A)
         X2 (mod32 A)
         X1 (x| X1 (| X2 (mod32 B)))
         X2 (x| X2 (rol32 (& X1 (>> 32 B)) 1)) )
      (x| (>> -32 X1) X2) ) )
(de num128 (L)
   (apply
      |
      (mapcar
         >>
         (-120 -112 -104 -96 
            -88 -80 -72 -64 
            -56 -48 -40 -32 
            -24 -16 -8 0 )
         L ) ) )
(de num64 (L)
   (apply
      |
      (mapcar >> (-56 -48 -40 -32 -24 -16 -8 0) L) ) )
(de create (A)
   (let
      (@ (>> 64 A)
         @@ (mod64 A)
         D1 @
         D2 @@
         D2 (x| D2 (f D1 *SIGMA1))
         D1 (x| D1 (f D2 *SIGMA2))
         D1 (x| D1 @)
         D2 (x| D2 @@)
         D2 (x| D2 (f D1 *SIGMA3))
         D1 (x| D1 (f D2 *SIGMA4)) )
      (| D2 (>> -64 D1)) ) )
(de boom (X N)
   (and
      (rol128 X N)
      (list (>> 64 @) (mod64 @)) ) )
(de genkey (A B)
   (make
      (link
         (>> 64 A)
         (mod64 A)
         (>> 64 B)
         (mod64 B) )
      (chain
         (boom A 15)
         (boom B 15)
         (boom B 30)
         (boom A 45) )
      (link 
         (car (boom B 45))
         (cadr (boom A 60)) )
      (chain
         (boom B 60)
         (boom A 77)
         (boom A 94)
         (boom B 94)
         (boom A 111)
         (boom B 111) ) ) )
(de camellia128 (Lst Key)
   (or
      (= 16 (length Key) (length Lst))
      (quit "wrong length") )
   (let
      (K (num128 Key)
         Key (genkey K (create K))
         L1 (num64 (cut 8 'Lst))
         L2 (num64 (cut 8 'Lst)) )
      (setq
         L1 (x| L1 (pop 'Key))
         L2 (x| L2 (pop 'Key)) )
      (do 2
         (do 3
            (setq
               L2 (x| L2 (f L1 (pop 'Key)))
               L1 (x| L1 (f L2 (pop 'Key))) ) )
         (setq 
            L1 (fl L1 (pop 'Key))
            L2 (flinv L2 (pop 'Key)) ) )
      (do 3
         (setq
            L2 (x| L2 (f L1 (pop 'Key)))
            L1 (x| L1 (f L2 (pop 'Key))) ) )
      (setq
         L2 (x| L2 (pop 'Key))
         L1 (x| L1 (pop 'Key)) )
      (make
         (for N (list L1 L2)
            (do 8
               (yoke (& 255 N))
               (setq N (>> 8 N)) ) ) ) ) )

