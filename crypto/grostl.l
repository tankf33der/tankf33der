(load "grostl-sbox.l")

(de addp (N)
   (let S 0
      (map
         '((R)
            (set R (x| S (car R) N))
            (inc 'S 16) )
         "A" ) ) )
(de addq (N)
   (let S 255
      (map
         '((R)
            (set R (x| S (car R) N))
            (dec 'S 16) )
         "H" )
      (mapc
         '((Lst)
            (map
               '((L) (set L (x| (car L) `(hex "FF"))))
               (val Lst) ) )
         '("A" "B" "C" "D" "E" "F" "G") ) ) )
(de subbytes ()
   (mapc
      '((Lst)
         (map
            '((L)
               (set L (car (nth *AES-S (inc (car L))))) )
            (val Lst) ) )
      '("A" "B" "C" "D" "E" "F" "G" "H") ) )
(de shiftbytes (Steps)
   (mapc
      '((S L) 
            (let L (val L)
               (do S 
                  (rot L) ) ) )
      Steps
      '("A" "B" "C" "D" "E" "F" "G" "H") ) )
(de gf_mul (A B)
   (cache # Memoization
      '(NIL)
      (cons A B)
      (if (or (=0 A) (=0 B))
         0
         (car 
            (nth 
               *GF256_EXP
               (inc
                  (% 
                     (+ 
                        (car (nth *GF256_LOG (inc A)))
                        (car (nth *GF256_LOG (inc B))) )  
                     `(hex "FF") ) ) ) ) ) ) )
(de mixbytes ()
   (map
      '(("X1" "X2" "X3" "X4" "X5" "X6" "X7" "X8")
         (let L
            (mapcar 
               '((L) (car (val L))) 
               '("X1" "X2" "X3" "X4" "X5" "X6" "X7" "X8") )
            (mapc
               '((L N) (set (val L) N))
               '("X1" "X2" "X3" "X4" "X5" "X6" "X7" "X8")
               (mapcar
                  '((M)
                     (apply
                        x|
                        (mapcar '((X Y) (gf_mul X Y)) L M) ) )
                  *MIXMATRIX ) ) ) )
      "A" 
      "B" 
      "C" 
      "D" 
      "E" 
      "F" 
      "G" 
      "H" ) )
(de p512 (Lst)
   (let
      ("A" NIL
         "B" NIL
         "C" NIL
         "D" NIL
         "E" NIL
         "F" NIL
         "G" NIL
         "H" NIL )
      (while Lst
         (mapc
            queue
            '("A" "B" "C" "D" "E" "F" "G" "H") 
            (cut 8 'Lst) ) )
      (for (N 0 (>= 9 N) (inc N))
         (addp N)
         (subbytes)
         (shiftbytes `(range 8 1))
         (mixbytes) )
      (make
         (do 8
            (link
               (pop '"A")
               (pop '"B")
               (pop '"C")
               (pop '"D")
               (pop '"E")
               (pop '"F")
               (pop '"G")
               (pop '"H") ) ) ) ) )
(de q512 (Lst)
   (let
      ("A" NIL
         "B" NIL
         "C" NIL
         "D" NIL
         "E" NIL
         "F" NIL
         "G" NIL
         "H" NIL )
      (while Lst
         (mapc
            queue
            '("A" "B" "C" "D" "E" "F" "G" "H")
            (cut 8 'Lst) ) )
      (for (N 0 (>= 9 N) (inc N))
         (addq N)
         (subbytes)
         (shiftbytes (7 5 3 1 8 6 4 2))
         (mixbytes) )
      (make
         (do 8
            (link
               (pop '"A")
               (pop '"B")
               (pop '"C")
               (pop '"D")
               (pop '"E")
               (pop '"F")
               (pop '"G")
               (pop '"H") ) ) ) ) )
(de grostl256 (Lst)
   (let
      (Len (length Lst)
         H (need 64 (list 1 0) 0) )
      (setq Lst
         (conc
            (need
               (-
                  8
                  (setq @
                     (* 64 (/ (+ Len 1 8 63) 64)) ) )
               (append Lst (cons `(hex "80")))
               0 )
            (make
               (setq @ (/ @ 64))
               (do 8
                  (yoke (& @ 255))
                  (setq @ (>> 8 @)) ) ) ) )
      (while (cut 64 'Lst)
         (setq H
            (mapcar
               x|
               (p512 (mapcar x| H @))
               (q512 @)
               H ) ) )
      (tail 32 (mapcar x| (p512 H) H)) ) )
(de grostl256_hex (Lst)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (grostl256 Lst) ) ) )

