(load "anubis-sbox.l")

(de mod8 (N)
   (& N `(hex "FF")) )
(de num32 (L)
   (apply
      |
      (mapcar >> (-24 -16 -8 0) L) ) )
(de unnum (A B)
   (mod8 (>> B A)) )
(de anbsKey (Key)
   (let 
      (K0 0
         K1 0
         K2 0
         K3 0
         Kappa
         (make
            (do 4
               (link (num32 (cut 4 'Key))) ) ) )
      (make
         (for R 13
            (let (I NIL  K (get Kappa 4))
               (setq
                  K0 (anbs 4 (unnum K 24))
                  K1 (anbs 4 (unnum K 16))
                  K2 (anbs 4 (unnum K 8))
                  K3 (anbs 4 (unnum K 0)) )
               (for (R 3 (>= R 1) (dec R))
                  (let K (get Kappa R)
                     (setq
                        K0
                        (x|
                           (anbs 4 (unnum K 24))
                           (& (anbs 5 (unnum K0 24)) `(hex "FF000000"))
                           (& (anbs 5 (unnum K0 16)) `(hex "00FF0000"))
                           (& (anbs 5 (unnum K0  8)) `(hex "0000FF00"))
                           (& (anbs 5 (unnum K0  0)) `(hex "000000FF")) )
                        K1
                        (x|
                           (anbs 4 (unnum K 16))
                           (& (anbs 5 (unnum K1 24)) `(hex "FF000000"))
                           (& (anbs 5 (unnum K1 16)) `(hex "00FF0000"))
                           (& (anbs 5 (unnum K1  8)) `(hex "0000FF00"))
                           (& (anbs 5 (unnum K1  0)) `(hex "000000FF")) )
                        K2
                        (x|
                           (anbs 4 (unnum K 8))
                           (& (anbs 5 (unnum K2 24)) `(hex "FF000000"))
                           (& (anbs 5 (unnum K2 16)) `(hex "00FF0000"))
                           (& (anbs 5 (unnum K2  8)) `(hex "0000FF00"))
                           (& (anbs 5 (unnum K2  0)) `(hex "000000FF")) )
                        K3
                        (x|
                           (anbs 4 (unnum K 0))
                           (& (anbs 5 (unnum K3 24)) `(hex "FF000000"))
                           (& (anbs 5 (unnum K3 16)) `(hex "00FF0000"))
                           (& (anbs 5 (unnum K3  8)) `(hex "0000FF00"))
                           (& (anbs 5 (unnum K3  0)) `(hex "000000FF")) ) ) ) )
               (link (list K0 K1 K2 K3))
               (setq
                  I
                  (let L (1 4 3 2)
                     (make
                        (do 4
                           (link
                              (x|
                                 (anbs 0 (unnum (get Kappa (car L)) 24))
                                 (anbs 1 (unnum (get Kappa (cadr L)) 16))
                                 (anbs 2 (unnum (get Kappa (caddr L)) 8))
                                 (anbs 3 (unnum (get Kappa (cadddr L)) 0)) ) )
                           (rot L) ) ) ) )
               (set
                  Kappa
                  (x|
                     (& 
                        (anbs 0 (+ 0 (* 4 (dec R)))) 
                        `(hex "FF000000") )
                     (& 
                        (anbs 1 (+ 1 (* 4 (dec R)))) 
                        `(hex "00FF0000") )
                     (& 
                        (anbs 2 (+ 2 (* 4 (dec R)))) 
                        `(hex "0000FF00") )
                     (& 
                        (anbs 3 (+ 3 (* 4 (dec R)))) 
                        `(hex "000000FF") )
                     (car I) )
                  (cdr Kappa) 
                  (cadr I)
                  (cddr Kappa) 
                  (caddr I)
                  (cdddr Kappa) 
                  (cadddr I) ) ) ) ) ) )
(de anubis128 (Lst Key)
   (let
      (K (anbsKey Key)
         I (need 4 0)
         S
         (mapcar 
            x| 
            (pop 'K) 
            (make
               (do 4
                  (link (num32 (cut 4 'Lst))) ) ) ) )
      (do 11
         (let Rnd (pop 'K)
            (map
               '((A B C)
                  (set A
                     (x|
                        (anbs 0 (unnum (car S) (car B)))
                        (anbs 1 (unnum (cadr S) (car B)))
                        (anbs 2 (unnum (caddr S) (car B)))
                        (anbs 3 (unnum (cadddr S) (car B)))
                        (car C) ) ) )
               I
               (24 16 8 0)
               Rnd )
            (setq S (copy I)) ) )
      (map
         '((A B C)
            (set A
               (x|
                  (& 
                     (anbs 0 (unnum (car S) (car B))) 
                     `(hex "FF000000") )
                  (& 
                     (anbs 1 (unnum (cadr S) (car B))) 
                     `(hex "00FF0000") )
                  (& 
                     (anbs 2 (unnum (caddr S) (car B))) 
                     `(hex "0000FF00") )
                  (& 
                     (anbs 3 (unnum (cadddr S) (car B))) 
                     `(hex "000000FF") )
                  (car C) ) ) )
         I
         (24 16 8 0)
         (pop 'K) )
      (mapcan
         '((N)
            (let R NIL
               (do 4
                  (push 'R (mod8 N))
                  (setq N (>> 8 N)) )
               R ) )
         I ) ) )

