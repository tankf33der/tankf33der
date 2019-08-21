(de mod16 (N)
   (& N `(hex "FFFF")) )
(de mod16+ @
   (mod16 (pass +)) )
(de mod128 (N)
   (& N `(hex (pack (need 32 "F")))) )
(de rol128 (X C)
   (| (mod128 (>> (- C) X)) (>> (- 128 C) X)) )
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
(de expand (L)
   (let @ (num128 L)
      (make
         (do 7
            (chain
               (let N @
                  (make
                     (do 8
                        (yoke (& `(hex "FFFF") N))
                        (setq N (>> 16 N)) ) ) ) )
            (setq @ (rol128 @ 25)) ) ) ) )
(de totwo16 (N)
   (or
      (ge0 N)
      (x| (dec (abs N)) `(hex "FFFF")) ) )
(de mul (A B)
   (let N (* A B)
      (mod16
         (if (=0 N)
            (totwo16 (- 1 A B))
            (% N `(hex "10001")) ) ) ) )
(de idea (Lst Key)
   (let
      (Key (expand Key)
         X1 (| (>> -8 (pop 'Lst)) (pop 'Lst))
         X2 (| (>> -8 (pop 'Lst)) (pop 'Lst))
         X3 (| (>> -8 (pop 'Lst)) (pop 'Lst))
         X4 (| (>> -8 (pop 'Lst)) (pop 'Lst)) )
      (do 8
         (setq
            X1 (mul X1 (pop 'Key))
            X2 (mod16+ X2 (pop 'Key))
            X3 (mod16+ X3 (pop 'Key))
            X4 (mul X4 (pop 'Key))

            @ X3
            X3 (mul (x| X3 X1) (pop 'Key))
            @@ X2
            X2 (mul (mod16+ (x| X2 X4) X3) (pop 'Key))
            X3 (mod16+ X3 X2)

            X1 (x| X1 X2)
            X4 (x| X4 X3)
            X2 (x| X2 @) 
            X3 (x| X3 @@) ) )
      (setq
         X1 (mul X1 (pop 'Key))
         X3 (mod16+ X3 (pop 'Key))
         X2 (mod16+ X2 (pop 'Key))
         X4 (mul X4 (pop 'Key)) )
      (make
         (for N (list X4 X2 X3 X1)
            (do 2
               (yoke (& 255 N))
               (setq N (>> 8 N)) ) ) ) ) )

