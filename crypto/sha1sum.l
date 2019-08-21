(de rol (X C)
   (| (mod32 (>> (- C) X)) (>> (- 32 C) X)) )
(de mod32 (N)
   (& N `(hex "FFFFFFFF")) )
(de not32 (N)
   (x| N `(hex "FFFFFFFF")) )
(de add32 @
   (mod32 (pass +)) )
(de _sha1 (H Lst)
   (let
      (#H (val "H")
         A (get H 1)
         B (get H 2)
         C (get H 3)
         D (get H 4)
         E (get H 5) 
         W
         (conc
            (make
               (do 16
                   (link
                      (apply
                         |
                         (mapcar >> (-24 -16 -8 0) (cut 4 'Lst)) ) ) ) )
            (need 64 0) ) )
         (for (I 17 (>= 80 I) (inc I))
            (set (nth W I)
               (rol
                  (x|
                     (get W (- I 3))
                     (get W (- I 8))
                     (get W (- I 14))
                     (get W (- I 16)) )
                  1 ) ) )
         (use (Tmp F K)
            (for I 80
               (cond
                  ((>= 20 I)
                     (setq
                        F (| (& B C) (& (not32 B) D))
                        K `(hex "5A827999") ) )
                  ((>= 40 I)
                     (setq
                        F (x| B C D)
                        K `(hex "6ED9EBA1") ) )
                  ((>= 60 I)
                     (setq
                        F
                        (| 
                           (& B C) 
                           (& B D) 
                           (& C D) )
                        K `(hex "8F1BBCDC") ) )
                  (T
                     (setq
                        F (x| B C D)
                        K `(hex "CA62C1D6") ) ) )
               (setq
                  Tmp (add32 (rol A 5) F E K (get W I) )
                  E D
                  D C
                  C (rol B 30)
                  B A
                  A Tmp ) ) )
         (map
            '((A B) (set A (add32 (car A) (car B))))
            H
            (list A B C D E) ) ) )
(de sha1sum (F)
   (let
      (H 
         (list
            `(hex "67452301")
            `(hex "EFCDAB89")
            `(hex "98BADCFE")
            `(hex "10325476")
            `(hex "C3D2E1F0") )
         Lst NIL
         Len 0 )
      (in F
         (while
            (and
               (setq Lst
                  (make
                     (do 64
                        (NIL (setq @@ (rd 1)))
                        (link @@) ) ) )
               (= 64 (length Lst)) )
            (inc 'Len 64)
            (_sha1 H Lst) ) )
      (inc 'Len (setq @@ (length Lst)))
      (setq
         Lst
         (conc
            (need
               (- 
                  8 
                  (* 64 (/ (+ @@ 1 8 63) 64)) )
               (conc Lst (cons `(hex "80")))
               0 ) 
            (flip 
               (make
                  (setq Len (* 8 Len))
                  (do 8
                     (link (& Len 255))
                     (setq Len (>> 8 Len )) ) ) ) ) )
      (while Lst
         (_sha1 H (cut 64 'Lst)) )
      (make
         (for N H
            (chain
               (make
                  (do 4
                     (yoke (& N 255))
                     (setq N (>> 8 N)) ) ) ) ) ) ) )
(de sha1sumhex (F)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (sha1sum F) ) ) )
