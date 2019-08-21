(load "jh-sbox.l")

(de x|set (S D)
   (set D (x| (car S) (car D))) )
(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de xor64 (N)
   (x| N `(hex "FFFFFFFFFFFFFFFF")) )
(de swap1 (N)
   (|
      (mod64 (>> -1 (& N `(hex "5555555555555555"))))
      (>> 1 (& N `(hex "AAAAAAAAAAAAAAAA"))) ) )
(de swap2 (N)
   (|
      (mod64 (>> -2 (& N `(hex "3333333333333333"))))
      (>> 2 (& N `(hex "CCCCCCCCCCCCCCCC"))) ) )
(de swap4 (N)
   (|
      (mod64 (>> -4 (& N `(hex "0F0F0F0F0F0F0F0F"))))
      (>> 4 (& N `(hex "F0F0F0F0F0F0F0F0"))) ) )
(de swap8 (N)
   (|
      (mod64 (>> -8 (& N `(hex "00FF00FF00FF00FF"))))
      (>> 8 (& N `(hex "FF00FF00FF00FF00"))) ) )
(de swap16 (N)
   (|
      (mod64 (>> -16 (& N `(hex "0000FFFF0000FFFF"))))
      (>> 16 (& N `(hex "FFFF0000FFFF0000"))) ) )
(de swap32 (N)
   (| (mod64 (>> -32 N)) (>> 32 N)) )
(de endian (L) # little
   (apply
      |
      (mapcar >> (0 -8 -16 -24 -32 -40 -48 -56) L) ) )
(de SS (L C0 C1)
   (use (T0 T1)
      (set
         (nth L 7) (xor64 (get L 7))
         (nth L 8) (xor64 (get L 8))
         (nth L 1)
         (x|
            (get L 1)
            (& (xor64 (get L 5)) C0) )
         (nth L 2)
         (x|
            (get L 2)
            (& (xor64 (get L 6)) C1) )
         'T0 (x| C0 (& (get L 1) (get L 3)))
         'T1 (x| C1 (& (get L 2) (get L 4)))
         (nth L 1)
         (x|
            (get L 1)
            (& (get L 5) (get L 7)) )
         (nth L 2)
         (x|
            (get L 2)
            (& (get L 6) (get L 8)) )
         (nth L 7)
         (x|
            (get L 7)
            (& (xor64 (get L 3)) (get L 5)) )
         (nth L 8)
         (x|
            (get L 8)
            (& (xor64 (get L 4)) (get L 6)) )
         (nth L 3)
         (x|
            (get L 3)
            (& (get L 1) (get L 5)) )
         (nth L 4)
         (x|
            (get L 4)
            (& (get L 2) (get L 6)) )
         (nth L 5)
         (x|
            (get L 5)
            (& (get L 1) (xor64 (get L 7))) )
         (nth L 6)
         (x|
            (get L 6)
            (& (get L 2) (xor64 (get L 8))) )
         (nth L 1)
         (x|
            (get L 1)
            (| (get L 3) (get L 7)) )
         (nth L 2)
         (x|
            (get L 2)
            (| (get L 4) (get L 8)) )
         (nth L 7)
         (x|
            (get L 7)
            (& (get L 3) (get L 5)) )
         (nth L 8)
         (x|
            (get L 8)
            (& (get L 4) (get L 6)) )
         (nth L 3) (x| (get L 3) (& T0 (get L 1)))
         (nth L 4) (x| (get L 4) (& T1 (get L 2)))
         (nth L 5) (x| (get L 5) T0)
         (nth L 6) (x| (get L 6) T1) ) ) )
(de LL (L)
   (set
      (nth L 2) (x| (get L 2) (get L 3))
      (nth L 4) (x| (get L 4) (get L 5))
      (nth L 6)
      (x|
         (get L 6)
         (get L 1)
         (get L 7) )
      (nth L 8) (x| (get L 8) (get L 1))
      (nth L 1) (x| (get L 1) (get L 4))
      (nth L 3) (x| (get L 3) (get L 6))
      (nth L 5)
      (x|
         (get L 5)
         (get L 2)
         (get L 8) )
      (nth L 7) (x| (get L 7) (get L 2)) ) )
(de jh256 (Lst)
   (let
      (Len (length Lst)
         HL (copy *JH-HL)
         HR (copy *JH-HR)
         Lst
         (conc
            (need
               (- 
                  16
                  (* 64 (/ (+ Len 16 63 48) 64)) )
               (append Lst (cons `(hex "80")))
               0 ) 
            (make
               (setq Len (* 8 Len))
               (do 16
                  (yoke (& Len 255))
                  (setq Len (>> 8 Len)) ) ) ) )
      (while (cut 64 'Lst)
         (let 
            (B
               (make
                  (do 8
                     (link (endian (cut 8 '@))) ) ) 
               BL (filter prog2 B '(T NIL .))  
               BR (filter prog2 B '(NIL T .)) )
            (map x|set BL HL)
            (map x|set BR HR)
            (do 6
               (mapc
                  '((F)
                     (mapc
                        '((Lst)
                           (SS (val Lst) (pop '*JH-RC) (pop '*JH-RC))
                           (LL (val Lst))
                           (for (L (cdr (val Lst)) L (cddr L))
                              (set L (F (car L))) ) )
                        '(HL HR) ) )
                  '(swap1 swap2 swap4 swap8 swap16 swap32) )
               (mapc
                  '((Lst)
                      (SS (val Lst) (pop '*JH-RC) (pop '*JH-RC))
                      (LL (val Lst)) )
                  '(HL HR) )
               (map
                  '((L1 L2 F)
                     (and (car F) (xchg L1 L2)) )
                  HL
                  HR
                  '(NIL T .) ) )
            (map x|set BL (nth HL 5))
            (map x|set BR (nth HR 5)) ) )
      (make
         (map
            '((L1 L2)
               (mapc
                  '((N)
                     (do 8
                        (link (& 255 N))
                        (setq N (>> 8 N)) ) )
               (list (car L1) (car L2)) ) )
            (tail 2 HL)
            (tail 2 HR) ) ) ) )
(de jh256_hex (Lst)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (jh256 Lst) ) ) ) 

