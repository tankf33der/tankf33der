(load "rc2-sbox.l")

(de mod16 (N)
   (& N `(hex "FFFF")) )
(de mod16+ @
   (mod16 (pass +)) )
(de rol16 (X C)
   (| (mod16 (>> (- C) X)) (>> (- 16 C) X)) )
(de xor16 (N)
   (x| N `(hex "FFFF")) )
(de little16 (L)
   (| (>> -8 (cadr L)) (car L)) )
(de expandKey (Lst)
   (let
      (Len (length Lst)
         Bits (* 8 Len)
         Bytes (/ (+ Bits 7) 8)
         Mask
         (%
            255
            (>> (- (* 8 Bytes) (+ 8 Bits)) 1) )
         Last (last Lst)
         Lst (need -128 (copy Lst) 0) )
      (or
         (and (>= Len 1) (>= 128 Len))
         (quit "wrong key length") )
      (map
         '((L1 L2)
            (setq Last
               (set L1
                  (get
                     *RC2-P
                     (inc (& (+ Last (car L2)) 255)) ) ) ) )
         (nth Lst (inc Len))
         Lst )
      (let L (nth Lst (inc (- 128 Bytes)))
         (set L
            (get *RC2-P (inc (& (car L) Mask))) ) )
      (setq Lst (flip Lst)  Last (get Lst Len))
      (map
         '((L1 L2)
            (setq Last
               (set L1
                  (get *RC2-P (inc (x| Last (car L2)))) ) ) )
         (nth Lst (inc Len))
         Lst )
      (make
         (for (L Lst L (cddr L))
            (yoke (mod16+ (* (car L) 256) (cadr L))) ) ) ) ) 
(de rc2 (Lst Key)
   (let
      (Key (expandKey Key)
         Len (length Lst)
         R0 (little16 (cut 2 'Lst))
         R1 (little16 (cut 2 'Lst))
         R2 (little16 (cut 2 'Lst))
         R3 (little16 (cut 2 'Lst))
         Shift (circ 1 2 3 5) )
      (or
         (= 8 Len)
         (quit "wrong input") )
      (let K Key
         (do 5
            (setq
               R0
               (mod16+ 
                  R0 
                  (pop 'K)
                  (& R3 R2)
                  (& R1 (xor16 R3)) )
               R0 (rol16 R0 (pop 'Shift))
               R1 
               (mod16+ 
                  R1
                  (pop 'K)
                  (& R0 R3)
                  (& R2 (xor16 R0)) )
               R1 (rol16 R1 (pop 'Shift))
               R2
               (mod16+ 
                  R2 
                  (pop 'K) 
                  (& R1 R0) 
                  (& R3 (xor16 R1)) )
               R2 (rol16 R2 (pop 'Shift))
               R3
               (mod16+ 
                  R3 
                  (pop 'K) 
                  (& R2 R1) 
                  (& R0 (xor16 R2)) )
               R3 (rol16 R3 (pop 'Shift)) ) ) )
      (setq
         R0 (mod16+ R0 (get Key (inc (& R3 63))))
         R1 (mod16+ R1 (get Key (inc (& R0 63))))
         R2 (mod16+ R2 (get Key (inc (& R1 63))))
         R3 (mod16+ R3 (get Key (inc (& R2 63)))) )
      (let K (nth Key 21)
         (do 6
            (setq
               R0
               (mod16+ 
                  R0 
                  (pop 'K) 
                  (& R3 R2) 
                  (& R1 (xor16 R3)) )
               R0 (rol16 R0 (pop 'Shift))
               R1
               (mod16+ 
                  R1 
                  (pop 'K) 
                  (& R0 R3) 
                  (& R2 (xor16 R0)) )
               R1 (rol16 R1 (pop 'Shift))
               R2
               (mod16+ 
                  R2 
                  (pop 'K) 
                  (& R1 R0) 
                  (& R3 (xor16 R1)) )
               R2 (rol16 R2 (pop 'Shift))
               R3
               (mod16+ 
                  R3 
                  (pop 'K) 
                  (& R2 R1) 
                  (& R0 (xor16 R2)) )
               R3 (rol16 R3 (pop 'Shift)) ) ) )
      (setq
         R0 (mod16+ R0 (get Key (inc (& R3 63))))
         R1 (mod16+ R1 (get Key (inc (& R0 63))))
         R2 (mod16+ R2 (get Key (inc (& R1 63))))
         R3 (mod16+ R3 (get Key (inc (& R2 63)))) )
      (let K (nth Key 45)
         (do 5
            (setq
               R0 
               (mod16+ 
                  R0 
                  (pop 'K) 
                  (& R3 R2) 
                  (& R1 (xor16 R3)) )
               R0 (rol16 R0 (pop 'Shift))
               R1 
               (mod16+ 
                  R1 
                  (pop 'K) 
                  (& R0 R3) 
                  (& R2 (xor16 R0)) )
               R1 (rol16 R1 (pop 'Shift))
               R2
               (mod16+ 
                  R2 
                  (pop 'K) 
                  (& R1 R0) 
                  (& R3 (xor16 R1)) )
               R2 (rol16 R2 (pop 'Shift))
               R3
               (mod16+ 
                  R3 
                  (pop 'K) 
                  (& R2 R1) 
                  (& R0 (xor16 R2)) )
               R3 (rol16 R3 (pop 'Shift)) ) ) )
      (make
         (for N (list R0 R1 R2 R3)
            (link (& 255 N) (>> 8 N)) ) ) ) )

