(load "pbkdf2.l")
(load "../rosetta/sha256.l")

(setq *SRnds
   (quote # inc
      ( 5  1 13  7) ( 9  5  1  9) (13  9  5 13) ( 1 13  9 18)
      (10  6  2  7) (14 10  6  9) ( 2 14 10 13) ( 6  2 14 18)
      (15 11  7  7) ( 3 15 11  9) ( 7  3 15 13) (11  7  3 18)
      ( 4 16 12  7) ( 8  4 16  9) (12  8  4 13) (16 12  8 18)
      ( 2  1  4  7) ( 3  2  1  9) ( 4  3  2 13) ( 1  4  3 18)
      ( 7  6  5  7) ( 8  7  6  9) ( 5  8  7 13) ( 6  5  8 18)
      (12 11 10  7) ( 9 12 11  9) (10  9 12 13) (11 10  9 18)
      (13 16 15  7) (14 13 16  9) (15 14 13 13) (16 15 14 18) ) )
(de mod8 (N)
   (& N `(hex "FF")) )
(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de mod32+ @
   (mod32 (pass +)) )
(de rol (X C)
   (| (mod32 (>> (- C) X)) (>> (- 32 C) X)) )
(de lsthex (L)
   (mapcar '((N) (hex (sym N))) L) )
(de dec32 (L)
   (make
      (while (cut 4 'L)
         (link
            (apply
               |
               (mapcar
                  >>
                  (0 -8 -16 -24)
                  @ ) ) ) ) ) )
(de salsa ("Lst")
   (let L (copy "Lst")
      (do 4
         (for R *SRnds
            (let Y (nth "Lst" (car R))
               (set Y
                  (x|
                     (car Y)
                     (rol
                        (mod32+ # XXX
                           (car (nth "Lst" (cadr R)))
                           (car (nth "Lst" (caddr R))) )
                        (cadddr R) ) ) ) ) ) )
      (map
         '((A B) (set A (mod32+ (car A) (car B))))
         "Lst"
         L ) ) )
(de integerify (Lst N)
   (let X (tail 16 Lst)
      (inc 
         (& 
            (| (>> -32 (cadr X)) (car X))
            (dec N) ) ) ) )
(de blockmix (Lst) # Let it be that way.
   (let
      (X (tail 16 Lst)
         L
         (make
            (for (Z (nth Lst 1) Z (nth (cdr Z) 16))
               (setq X (mapcar x| X Z))
               (salsa X)
               (link X) ) ) ) 
      (conc
          (make
            (for (I . X1) L
               (and (bit? 1 I) (chain X1)) ) ) 
         (make
            (for (I . X1) L
               (or (bit? 1 I) (chain X1)) ) ) ) ) )
(de smix (Lst N)
   (let (L NIL Tr NIL)
      (setq L
         (make
            (for Y N
               (link (cons Y Lst))
               (setq Lst (blockmix Lst)) ) ) )
      (balance 'Tr L)
      (do N
         (setq Lst
             (blockmix (mapcar x| Lst (cdr (lup Tr (integerify Lst N)))) ) ) ) ) ) 
(de scrypt (Pwd Slt N R P H)
   (unless
      (and 
         (> N 1) 
         (=0 (& N (dec N))) ) 
      (quit "wrong N") )
   (let B 
      (dec32 
         (pbkdf2 'sha256 Pwd Slt 1 (* 128 R P)) )
      (pbkdf2
         'sha256
         Pwd
         (make
            (for A
               (make
                  (do P
                     (chain (smix (cut (* 32 R) 'B) N)) ) )
               (do 4
                  (link (mod8 A))
                  (setq A (>> 8 A)) ) ) )
         1
         H ) ) )

