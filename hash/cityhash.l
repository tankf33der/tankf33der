# http://web.stanford.edu/class/ee380/Abstracts/121017-slides.pdf
# https://en.wikipedia.org/wiki/CityHash
#
(load "hash-core.l")

(setq 
   *C1 `(hex "CC9E2D51")
   *C2 `(hex "1B873593")
   *C3 `(hex "E6546B64") )
(de bswap32 (N)
   (|
      (& `(hex "FF") (>> 24 N))
      (& `(hex "FF00") (>> 8 N))
      (& `(hex "FF0000") (>> -8 N))
      (& `(hex "FF000000") (>> -24 N)) ) )
(de fetch32 (Lst)
   (apply + (mapcar >> (0 -8 -16 -24) Lst)) )
(de fetchLst (Lst)
   (mod32*
      (rightRotate
         (mod32* (fetch32 Lst) *C1)
         17 )
      *C2 ) )
(de fmix (H)
   (let (A `(hex "85EBCA6B")  B `(hex "C2B2AE35"))
      (setq
         H (x| H (>> 16 H))
         H (mod32* H A)
         H (x| H (>> 13 H))
         H (mod32* H B)
         H (x| H (>> 16 H)) ) ) )
(de mur (A H)
   (setq
      A (mod32* A *C1)
      A (rightRotate A 17)
      A (mod32* A *C2)
      H (x| H A)
      H (rightRotate H 19)
      H (mod32+ (mod32* 5 H) *C3) ) ) 
(de hash32Len4 (Lst Len)
   (let (B 0  C 9  C1 `(hex "CC9E2D51"))
      (for X Lst
         (setq
            B (mod32+ X (mod32* B C1) )
            C (x| C B) ) )
      (fmix (mur B (mur Len C))) ) )
(de hash32Len12 (Lst Len)
   (let (A Len  B (* 5 Len)  C 9)
      (setq
         A (mod32+ A (fetch32 Lst)) 
         B
         (mod32+
            B
            (fetch32 (nth Lst (inc (- Len 4)))) )
         C
         (mod32+ 
            C 
            (fetch32 
               (nth Lst (inc (& 4 (>> 1 Len)))) ) ) )
      (fmix (mur C (mur B (mur A (* 5 Len))))) ) )
(de hash32Len24 (Lst Len)
   (use (A B C D E F)
      (setq 
         A 
         (fetch32
            (nth Lst (inc (- (>> 1 Len) 4))) )
         B (fetch32 (nth Lst (inc 4)))
         C (fetch32 (nth Lst (inc (- Len 8))))
         D (fetch32 (nth Lst (inc (>> 1 Len))))
         E (fetch32 Lst)
         F (fetch32 (nth Lst (inc (- Len 4)))) )
      (fmix
         (mur 
            F 
            (mur 
               E 
               (mur D (mur C (mur B (mur A Len)))) ) ) ) ) )
(de hash32Len24+ (Lst Len)
   (let
      (H Len
         G (mod32* *C1 Len)
         F G
         Iters (/ (dec Len) 20) )
      (setq
         H (x| H (fetchLst (tail 4 Lst)))
         H (rightRotate H 19)
         H (mod32+ *C3 (mod32* H 5))
         H (x| H (fetchLst (tail 16 Lst))) 
         H (rightRotate H 19)
         H (mod32+ *C3 (mod32* H 5))
         G (x| G (fetchLst (tail 8 Lst)))
         G (rightRotate G 19)
         G (mod32+ *C3 (mod32* G 5))
         G (x| G (fetchLst (tail 12 Lst)))
         G (rightRotate G 19)
         G (mod32+ *C3 (mod32* G 5))
         F (mod32+ F (fetchLst (tail 20 Lst)))
         F (rightRotate F 19)
         F (mod32+ *C3 (mod32* F 5)) )
      (while (ge0 (dec 'Iters))
         (let
            (A0 (fetchLst Lst)
               A1 (fetch32 (nth Lst (inc 4)))
               A4 (fetch32 (nth Lst (inc 16))) )
            (setq
               H (x| H A0)
               H (rightRotate H 18)
               H (mod32+ *C3 (mod32* H 5))
               F (mod32+ F A1)
               F (rightRotate F 19)
               F (mod32* F *C1)
               G (mod32+ G (fetchLst (nth Lst (inc 8))))
               G (rightRotate G 18)
               G (mod32+ *C3 (mod32* G 5))
               H (x| H (mod32+ A1 (fetchLst (nth Lst (inc 12)))))
               H (rightRotate H 19)
               H (mod32+ *C3 (mod32* H 5))
               G (x| G A4)
               G (mod32* 5 (bswap32 G))
               H (mod32+ H (mod32* 5 A4))
               H (bswap32 H)
               F (mod32+ F A0) )
            (swap 'F (swap 'G (swap 'H F)))
            (cut 20 'Lst) ) )
      (setq
         G (mod32* *C1 (rightRotate G 11))
         G (mod32* *C1 (rightRotate G 17))
         F (mod32* *C1 (rightRotate F 11))
         F (mod32* *C1 (rightRotate F 17))
         H (rightRotate (mod32+ H G) 19)
         H (mod32+ *C3 (mod32* H 5))
         H (mod32* *C1 (rightRotate H 17))
         H (rightRotate (mod32+ H F) 19)
         H (mod32+ *C3 (mod32* H 5))
         H (mod32* *C1 (rightRotate H 17))
      ) ) )
(de city32 (Lst)
   (let Len (length Lst)
      (cond
         ((>= 4 Len) (hash32Len4 Lst Len))
         ((>= 12 Len) (hash32Len12 Lst Len))
         ((>= 24 Len) (hash32Len24 Lst Len))
         (T (hash32Len24+ Lst Len)) ) ) )

