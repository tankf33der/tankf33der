(load "tiger-sbox.l")

(de _byte (C N)
   (& (>> (* 8 N) C) `(hex "FF")) )
(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de xor64 (N)
   (x| N `(hex "FFFFFFFFFFFFFFFF")) )
(de mod64+ (A B)
   (mod64 (+ A B)) )
(de mod64* (A B)
   (mod64 (* A B)) )
(de mod64- (A B)
   (let N (- A B)
      (or (ge0 N) (xor64 (dec (abs N)))) ) )
(de num64 (L)
   (apply
      |
      (mapcar >> (0 -8 -16 -24 -32 -40 -48 -56) L) ) )
(de T1 (N)
   (sbox (inc N)) )
(de T2 (N)
   (sbox (inc (+ 256 N))) )
(de T3 (N)
   (sbox (inc (+ 512 N))) )
(de T4 (N)
   (sbox (inc (+ 768 N))) ) 
(de sbox (N)
   (cache
      '(NIL)
      N
      (car (nth *TIGER-SBOX N)) ) )
(de tiger_schedule NIL
   (setq
      "*X0" (mod64- "*X0" (x| "*X7" `(hex "A5A5A5A5A5A5A5A5")))
      "*X1" (x| "*X1" "*X0")
      "*X2" (mod64+ "*X2" "*X1")
      "*X3"
      (mod64-
         "*X3"
         (x| "*X2" (mod64 (>> -19 (xor64 "*X1")))) )
      "*X4" (x| "*X4" "*X3")
      "*X5" (mod64+ "*X5" "*X4")
      "*X6" (mod64- "*X6" (x| "*X5" (>> 23 (xor64 "*X4"))))
      "*X7" (x| "*X7" "*X6")
      "*X0" (mod64+ "*X0" "*X7")
      "*X1"
      (mod64-
         "*X1"
         (x| "*X0" (mod64 (>> -19 (xor64 "*X7")))) )
      "*X2" (x| "*X2" "*X1")
      "*X3" (mod64+ "*X3" "*X2")
      "*X4" (mod64- "*X4" (x| "*X3" (>> 23 (xor64 "*X2"))))
      "*X5" (x| "*X5" "*X4")
      "*X6" (mod64+ "*X6" "*X5")
      "*X7" (mod64- "*X7" (x| "*X6" `(hex "123456789ABCDEF"))) ) )
(de tiger_pass ("A" "B" "C" M) # 'Vars
   (tiger_round "A" "B" "C" "*X0" M)
   (tiger_round "B" "C" "A" "*X1" M)
   (tiger_round "C" "A" "B" "*X2" M)
   (tiger_round "A" "B" "C" "*X3" M)
   (tiger_round "B" "C" "A" "*X4" M)
   (tiger_round "C" "A" "B" "*X5" M)
   (tiger_round "A" "B" "C" "*X6" M)
   (tiger_round "B" "C" "A" "*X7" M) )
(de tiger_round ("A" "B" "C" X M) # 'Vars 
   (set 
      "C" (x| (val "C") X)
      "A"
      (mod64-
         (val "A")
         (x|
            (T1 (_byte (val "C") 0))
            (T2 (_byte (val "C") 2))
            (T3 (_byte (val "C") 4))
            (T4 (_byte (val "C") 6)) ) ) 
      "B"
      (mod64+
         (val "B")
         (x|
            (T4 (_byte (val "C") 1))
            (T3 (_byte (val "C") 3))
            (T2 (_byte (val "C") 5))
            (T1 (_byte (val "C") 7)) ) )
      "B" (mod64* (val "B") M) ) )
(de tiger_compress (A B C)
   (tiger_pass 'A 'B 'C 5)
   (tiger_schedule)
   (tiger_pass 'C 'A 'B 7)
   (tiger_schedule)
   (tiger_pass 'B 'C 'A 9)
   (list A B C) )
(de tiger192 (Lst)
   (let 
      (A `(hex "0123456789ABCDEF")
         B `(hex "FEDCBA9876543210")
         C `(hex "F096A5B4C3B2E187")
         Len (length Lst)
         Lst
         (conc
            (need
               (- 8 (* 64 (/ (+ Len 1 8 63) 64)))
               (append Lst (cons 1))
               0 )
            (make
               (setq Len (* 8 Len))
               (do 8
                  (link (& Len 255))
                  (setq Len (>> 8 Len )) ) ) ) )
      (while Lst
         (let
            ("*X0" (num64 (cut 8 'Lst))
               "*X1" (num64 (cut 8 'Lst))
               "*X2" (num64 (cut 8 'Lst))
               "*X3" (num64 (cut 8 'Lst))
               "*X4" (num64 (cut 8 'Lst))
               "*X5" (num64 (cut 8 'Lst))
               "*X6" (num64 (cut 8 'Lst))
               "*X7" (num64 (cut 8 'Lst)) )
            (setq
               @ (tiger_compress A B C)
               A (x| (pop '@) A)
               B (mod64- (pop '@) B)
               C (mod64+ (pop '@) C) ) ) ) 
      (mapcan
         '((N)
            (make
               (do 8
                  (link (& 255 N))
                  (setq N (>> 8 N)) ) ) ) 
         (list A B C) ) ) ) 
(de tiger192_hex (Lst)
   (pack
      (mapcar
         '((B) (pad 2 (hex B)))
         (tiger192 Lst) ) ) )
