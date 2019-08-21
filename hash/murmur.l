# 32-bit only
#
(load "hash-core.l")

(de mur1 (Lst Seed)
   (let
      (M `(hex "C6A4A793")
         L (length Lst)
         H (x| Seed (mod32* M L)) )
      (while (>= L 4)
         (and
            (apply
               +
               (mapcar >> (0 -8 -16 -24) (cut 4 'Lst)) )
            (setq
               H (mod32+ H @)
               H (mod32* H M)
               H (x| H (>> 16 H)) ) )
         (dec 'L 4) )
      (while (gt0 L)
         (case L
            (3
               (setq H 
                  (mod32+ H (>> -16 (caddr Lst))) ) )
            (2
               (setq H
                  (mod32+ H (>> -8 (cadr Lst))) ) )
            (1
               (setq
                  H (mod32+ H (car Lst))
                  H (mod32* H M)
                  H (x| H (>> 16 H)) ) ) )
         (dec 'L) )
      (setq 
         H (mod32* H M)
         H (x| H (>> 10 H))
         H (mod32* H M)
         H (x| H (>> 17 H)) ) ) )
(de mur2 (Lst Seed)
   (let (M `(hex "5BD1E995")  L (length Lst)  H (x| Seed L))
      (while (>= L 4)
         (let K
            (apply
               +
               (mapcar >> (0 -8 -16 -24) (cut 4 'Lst)) )
            (setq
               K (mod32* K M)
               K (x| K (>> 24 K))
               K (mod32* K M)
               H (mod32* H M)
               H (x| H K) )
            (dec 'L 4) ) )
      (while (ge0 L)
         (case L
            (3
               (setq H (x| H (>> -16 (caddr Lst)))) )
            (2
               (setq H (x| H (>> -8 (cadr Lst)))) )
            (1 (setq H (x| H (car Lst))))
            (0 (setq H (mod32* H M))) )
         (dec 'L) )
      (setq
         H (x| H (>> 13 H))
         H (mod32* H M)
         H (x| H (>> 15 H)) ) ) ) 
(de mur3 (Lst Seed)
   (let (C1 `(hex "CC9E2D51")
         C2 `(hex "1B873593")
         L (length Lst)
         LFin L
         H1 Seed)
      (while (>= L 4)
         (let K1
            (apply
               +
               (mapcar >> (0 -8 -16 -24) (cut 4 'Lst)) )
            (setq
               K1 (mod32* K1 C1)
               K1 (leftRotate K1 15)
               K1 (mod32* K1 C2)
               H1 (x| H1 K1)
               H1 (leftRotate H1 13)
               H1 (mod32+ `(hex "E6546B64") (mod32* H1 5)) )
            (dec 'L 4) ) )
      (let K1 0
         (while (ge0 L)
            (case L
               (3
                  (setq K1 (x| K1 (>> -16 (caddr Lst)))) )
               (2
                  (setq K1 (x| K1 (>> -8 (cadr Lst)))) )
               (1 (setq K1 (x| K1 (car Lst))) )
               (0
                  (setq
                     K1 (mod32* K1 C1)
                     K1 (leftRotate K1 15)
                     K1 (mod32* K1 C2)
                     H1 (x| H1 K1) ) ) )
            (dec 'L) ) )
      (setq
         H1 (x| H1 LFin)
         H1 (x| H1 (>> 16 H1))
         H1 (mod32* H1 `(hex "85EBCA6B"))
         H1 (x| H1 (>> 13 H1))
         H1 (mod32* H1 `(hex "C2B2AE35"))
         H1 (x| H1 (>> 16 H1)) ) ) )

