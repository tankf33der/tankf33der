(setq *Theta
   (circ 5 2 1 3 2 4 3 5 4 1) )
(setq *Chi
   (circ 2 3 4 5 1) )
(de leftRotate64 (X N)
   (let N (% N 64)
      (mod64
         (x|
            (>> (- 64 N) X)
            (>> (- N) X) ) ) ) )
(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de totwo (N)
   (or (ge0 N) (x| (dec (abs N)) `(hex "FFFFFFFFFFFFFFFFFF"))) )
(de fromtwo (N)
   (if (> `(hex "800000000000000000") N)
      N
      (- (x| (dec N) `(hex "FFFFFFFFFFFFFFFFFF"))) ) )
(de bitwise (F N1 N2)
   (fromtwo (F (totwo N1) (totwo N2))) )
(de tilde (N)
   (fromtwo (x| N `(hex "FFFFFFFFFFFFFFFFFF"))) )
(de i (X Y) # my favourite part
   (cache
      '(NIL)
      (cons X Y)
      (inc
         (+
            (* (dec X) 8)
            (* 40 (dec Y)) ) ) ) )
(de load64 (Lst)
   (let (R 0  C 0)
      (for (L Lst L)
         (NIL (>= 7 C))
         (inc
            'R
            (>> (- (* C 8)) (car L)) )
         (inc 'C)
         (pop 'L) )
      R ) )
(de xorlane (Lst D)
   (let C 8
      (for (L Lst L)
         (T (=0 C))
         (set L (& (x| (car L) D) `(hex "FF")))
         (setq D (>> 8 D))
         (dec 'C)
         (pop 'L) ) ) )
(de setlane (Lst D)
   (let C 8
      (for (L Lst L)
         (T (=0 C))
         (set L (& D `(hex "FF")))
         (setq D (>> 8 D))
         (dec 'C)
         (pop 'L) ) ) )
(de f1600 (State Kanga)
   (let
      (C (need 5)
         H (need 5)
         Rshift 1
         Loop (circ 1 2 3 4 5) )
      (and
         Kanga
         (do Kanga
            (do 7
               (setq Rshift
                  (&
                     (x| (>> -1 Rshift) (* (>> 7 Rshift) `(hex "71")))
                     `(hex "FF") ) ) ) ) )
      (do (if Kanga 12 24)
         # theta
         (for X 5
            (set (nth C X)
               (x|
                  (load64 (nth State (i X 1)))
                  (load64 (nth State (i X 2)))
                  (load64 (nth State (i X 3)))
                  (load64 (nth State (i X 4)))
                  (load64 (nth State (i X 5))) ) ) )
         (for X 5
            (let D
               (x|
                  (car (nth C (pop '*Theta)))
                  (leftRotate64 (car (nth C (pop '*Theta))) 1) )
               (for Y 5
                  (xorlane (nth State (i X Y)) D) ) ) )
         # rho and pi
         (let
            (X 2
               Y 1
               Shift 0
               Current (load64 (nth State (i X Y))) )
            (for (S 0 (>= 23 S) (inc S))
               (setq Shift
                  (/ (* (+ S 1) (+ S 2)) 2) )
               (swap
                  'X
                  (swap
                     'Y
                     (inc 
                        (%
                           (+ 
                              (* 2 (dec X))
                              (* 3 (dec Y)) )
                           5 ) ) ) )
               (setq Current
                  (prog1
                     (load64 (nth State (i X Y)))
                     (setlane
                        (nth State (i X Y))
                        (leftRotate64 Current Shift) ) ) ) ) )
         # chi
         (for Y 5
            (for (L H L)
               (set L
                  (load64 (nth State (i (pop 'Loop) Y))) )
               (NIL (pop 'L)) )
            (for X 5
               (setlane
                  (nth State (i X Y))
                  (x|
                     (car (nth H X))
                     (bitwise
                        &
                        (tilde (car (nth H (pop '*Chi))))
                        (car (nth H (pop *Chi))) ) ) ) ) )
         # iota
         (for (J 0 (>= 6 J) (inc J))
            (setq Rshift
               (&
                  (x| (>> -1 Rshift) (* (>> 7 Rshift) `(hex "71")))
                  `(hex "FF") ) )
            (and
               (bit? 2 Rshift)
               (setlane
                  (nth State (i 1 1))
                  (x|
                     (load64 (nth State (i 1 1)))
                     (>> (- (dec (>> (- J) 1))) 1) ) ) ) ) ) ) )
(de keccak (R C I DS OL File Kanga) 
   (or
      (and
         (= 1600 (+ R C))
         (=0 (% R 8)) )
      (quit "assert") )
   (let
      (State (need 200 0)
         RB (/ R 8)
         DSPos 0 )
      # Absorb
      (use (Lst Len)
         (in File # dirty
            (while
               (and
                  (setq 
                     Lst 
                     (if File
                        (make
                           (do RB
                              (NIL (setq @@ (rd 1)))
                              (link @@) ) )
                        (cut RB 'I) ) )
                  (setq Len (length Lst))
                  (setq DSPos (inc Len)) )
               (map
                  '((L S)
                     (set S (x| (car L) (car S))) )
                  Lst
                  State )
               (when (= Len RB)
                  (f1600 State Kanga)
                  (one DSPos) ) )
               (or Len (one DSPos)) ) ) # it was NIL input
      # Padding
      (set (setq @ (nth State DSPos))
         (x| (car @) DS) )
      (and
         (n0 (& `(hex "80") DS))
         (= DSPos (dec RB))
         (f1600 State Kanga) )
      (set (setq @ (nth State RB))
         (x| (car @) `(hex "80")) )
      (f1600 State Kanga)
      # Squeeze
      (make
         (while 
            (and # I like LEGO
               (gt0 OL)
               (setq @@ (min OL RB))
               (chain (head @@ State))
               (dec 'OL @@)
               (gt0 OL)
               (f1600 State Kanga) ) ) ) ) ) 
(de shake128 (I)
   (keccak 1344 256 I `(hex "1F") 32) )
(de shake128sum (F)
   (keccak 1344 256 NIL `(hex "1F") 32 F) )
(de shake256 (I)
   (keccak 1088 512 I `(hex "1F") 64) )
(de sha3-224 (I)
   (keccak 1152 448 I `(hex "06") 28) )
(de sha3-224_hex (I)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (sha3-224 I) ) ) )
(de shake128_hex (I)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (shake128 I)) ) )
(de shake128sum_hex (F)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (shake128sum F) ) ) )
(de shake256_hex (I)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (shake256 I)) ) )
(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
