(load "whirlpool-sbox.l")

(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de ror64 (X C)
   (| (>> C X) (mod64 (>> (- C 64) X))) )
(de num64big (L)
   (apply
      |
      (mapcar >> (-56 -48 -40 -32 -24 -16 -8 0) L) ) )
(de asvector (L)
   (let Steps `(range 8 1)
      (make
         (do 8
            (link
               (apply
                  x|
                  (mapcar
                     '((I N) (W I N))
                     `(range 0 7)
                     (mapcar
                        '((S N) (& (>> S N) `(hex "FF")))
                        `(range 56 0 8)      
                        (mapcar
                           '((S) (car (nth L S)))
                           (rot Steps) ) ) ) ) ) ) ) ) )
(de W (C N)
   (wsbox (inc (+ (* C 256) N)) ) )
(de wsbox (N)
   (cache
      '(NIL)
      N
      (car (nth *WHIRLPOOL-SBOX N)) ) )
(setq *WHIRLPOOL-SBOX
   (make
      (chain (copy *WHIRLPOOL-SBOX-C0)) # let it be
      (do 7
         (for (L *WHIRLPOOL-SBOX-C0 L)
            (set L (ror64 (car L) 8))
            (pop 'L) )
         (chain (copy *WHIRLPOOL-SBOX-C0)) ) ) )
(setq *WHIRLPOOL-RC
   (apply
      circ
      (make
         (for N (range 0 72 8)
            (link
               (x|
                  (& (W 0 (+ 0 N)) `(hex "FF00000000000000"))
                  (& (W 1 (+ 1 N)) `(hex "00FF000000000000"))
                  (& (W 2 (+ 2 N)) `(hex "0000FF0000000000"))
                  (& (W 3 (+ 3 N)) `(hex "000000FF00000000"))
                  (& (W 4 (+ 4 N)) `(hex "00000000FF000000"))
                  (& (W 5 (+ 5 N)) `(hex "0000000000FF0000"))
                  (& (W 6 (+ 6 N)) `(hex "000000000000FF00"))
                  (& (W 7 (+ 7 N)) `(hex "00000000000000FF")) ) ) ) ) ) )
(de whirlpool (Lst)
   (let
      (Len (length Lst)
         H (need 8 0)
         Lst
         (conc
            (need
               (- 32 (* 64 (/ (+ Len 1 32 63) 64)))
               (append Lst (cons `(hex "80")))
               0 )
            (make
               (setq Len (* 8 Len))
               (do 32
                  (yoke (& Len 255))
                  (setq Len (>> 8 Len)) ) ) ) )
      (while (cut 64 'Lst)
         (let
            (B 
               (make
                  (do 8
                     (link (num64big (cut 8 '@))) ) )
               K (copy H)
               State (mapcar x| B K) )
            (do 10
               (set 
                  'K (asvector K)
                  K (x| (car K) (pop '*WHIRLPOOL-RC))
                  'State (asvector State)
                  'State (mapcar x| State K) ) )
            (setq H (mapcar x| H State B)) ) )
      (mapcan
         '((N)
            (let R NIL
               (do 8
                  (push 'R (& `(hex "FF") N))
                  (setq N (>> 8 N)) )
               R ) )
         H ) ) )
(de whirlpool_hex (Lst)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (whirlpool Lst) ) ) )
