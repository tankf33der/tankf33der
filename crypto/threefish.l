#
# Threefish from SKEIN v1.3
# crypt one block without feed-forward
#
(setq 
   *THREEFISH-RS
   `(circ 14 16 52 57 23 40 5 37 25 33 46 12 58 22 32 32) )
(de circR ("Var" Lst)
   (set "Var" (cons (apply circ Lst) Lst)) )
(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de mod64+ (A B)
   (mod64 (+ A B)) )
(de rol64 (X C)
   (| (mod64 (>> (- C) X)) (>> (- 64 C) X)) )
(de endian (L) # little
   (apply
      |
      (mapcar >> (0 -8 -16 -24 -32 -40 -48 -56) L) ) )
(de InjectKey (R)
   (circR '"Ks" (cdr "Ks"))
   (circR '"Tweak" (cdr "Tweak"))
   (do (% R 5)
      (pop "Ks") )
   (do (% R 3)
      (pop "Tweak") )
   (mapc
      '((N)
         (set N (mod64+ (val N) (pop "Ks"))) )
         '("X0" "X1" "X2" "X3") )
   (set '"X1" (mod64+ "X1" (pop "Tweak")))
   (set '"X2" (mod64+ "X2" (pop "Tweak")))
   (set '"X3" (mod64+ "X3" R)) )
(de threefish256 (Lst "Key" "Tweak")
   (let ("Ks" NIL  Lst (copy Lst)) 
      (circR 
         '"Ks"
         (append 
            (val "Key")
            (cons (apply x| (val "Key") `(hex "1BD11BDAA9FC1A22"))) ) )
      (circR
         '"Tweak"
         (append "Tweak" (cons (x| (car "Tweak") (cadr "Tweak")))) )
      (map
         '((L)
            (set L (mod64+ (car L) (pop "Ks"))) )
         Lst )
      (set (cdr Lst) (mod64+ (cadr Lst) (pop "Tweak")))
      (set (cddr Lst) (mod64+ (caddr Lst) (pop "Tweak")))
      (let
         ("X0" (car Lst)
            "X1" (cadr Lst)
            "X2" (caddr Lst)
            "X3" (cadddr Lst) )
         (for (R 1 (>= (/ 72 8) R) (inc R))
            (for N 2
               (do 2
                  (setq
                     "X0" (mod64+ "X0" "X1")
                     "X1" (rol64 "X1" (pop '*THREEFISH-RS))
                     "X1" (x| "X1" "X0")
                     "X2" (mod64+ "X2" "X3")
                     "X3" (rol64 "X3" (pop '*THREEFISH-RS))
                     "X3" (x| "X3" "X2")
                     "X0" (mod64+ "X0" "X3")
                     "X3" (rol64 "X3" (pop '*THREEFISH-RS))
                     "X3" (x| "X3" "X0")
                     "X2" (mod64+ "X2" "X1")
                     "X1" (rol64 "X1" (pop '*THREEFISH-RS))
                     "X1" (x| "X1" "X2") ) )
               (InjectKey
                  ((if (=1 N) dec prog) (* 2 R)) ) ) )
         (map
            '((K R) (set K (car R)))
            (val "Key")
            (list "X0" "X1" "X2" "X3") ) ) ) )
