# XXX on pil64 works after v16.1.10
#
(load "sha512.l")

(de modulo (X Y)
   (% (+ Y (% X Y)) Y) )
(de hexL (Lst)
   (make
      (while (cut 2 'Lst)
         (link (hex (pack @))) ) ) )
(de steps (E)
   (flip
      (make
         (while
            (and
               (link (swap 'E (/ E 2)))
               (gt0 E) ) ) ) ) )
(de expmod (B E M)
   (let R 1
      (for I (steps E)
         (and
            (setq R (modulo (* R R) M))
            (bit? 1 I)
            (setq R (modulo (* R B) M)) ) )
      R ) )
(de inv (X)
   (expmod X (- *Q 2) *Q) )
(de xrecover (Y)
   (let
      (YY (* Y Y)
         XX (* (dec YY) (inv (inc (* *D YY))))
         X (expmod XX (/ (+ *Q 3) 8) *Q) )
      (and
         (n0 (% (- (* X X) XX) *Q))
         (setq X (% (* *I X) *Q)) )
      (and
         (n0 (% X 2))
         (setq X (- *Q X)) )
      X ) )

(setq *S (0 -1 -2 -3 -4 -5 -6 -7 .))
(setq *B 256)
(setq *Q `(- (** 2 255) 19))
(setq *L `(+ (** 2 252) 27742317777372353535851937790883648493))
(setq *D `(* -121665 (inv 121666)))
(setq *I `(expmod 2 (/ (dec *Q) 4) *Q))
(setq *By `(* 4 (inv 5)))
(setq *Bxy
   (cons
      (% (xrecover *By) *Q)
      (% *By *Q) ) )

(de edwards (P Q)
   (let
      (X1 (car P)
         Y1 (cdr P)
         X2 (car Q)
         Y2 (cdr Q) )
      (cons
         (%
            (*
               (+ (* X1 Y2) (* X2 Y1))
               (inv (inc (* *D X1 X2 Y1 Y2))) )
            *Q )
         (%
            (*
               (+ (* Y1 Y2) (* X1 X2))
               (inv (- 1 (* *D X1 X2 Y1 Y2))) )
            *Q ) ) ) )
(de scalarmult (P E)
   (let Q (cons 0 1)
      (for I (steps E)
         (and
            (setq Q (edwards Q Q))
            (bit? 1 I)
            (setq Q (edwards Q P)) ) )
      Q ) )
(de isoncurve (P)
   (let
      (X (car P)
         Y (cdr P)
         XX (* X X)
         YY (* Y Y) )
      (=0
         (modulo
            (-
               (+ (* -1 XX) YY)
               1
               (* *D XX YY) )
            *Q ) ) ) )

(de bits (Y B)
   (make
      (for (I 0 (> B I) (inc I))
         (link (or (bit? 1 (>> I Y)) 0)) ) ) )
(de ints (Lst)
   (make
      (do 32
         (link
            (sum
               '((L) (>> (pop '*S) L))
               (cut 8 'Lst) ) ) ) ) )
(de encodeint (Y)
   (ints (bits Y *B)) )
(de encodepoint (P)
   (ints
      (append
         (bits (cdr P) (dec *B))
         (cons (or (bit? 1 (car P)) 0)) ) ) )
(de bit (L I)
   (bit?
      1
      (>>
         (% I 8)
         (get L (inc (/ I 8)))) ) )
(de bitsum (S A B)
   (let R 0
      (for (I A (> B I) (inc I))
         (and
            (bit S I)
            (inc 'R (** 2 I)) ) )
      R ) )
(de decodeint (S)
   (bitsum S 0 *B) )
(de decodepoint (S)
   (let
      (Y (bitsum S 0 (dec *B))
         X (xrecover Y)
         R NIL )
      (or
         (= (bit? 1 X) (bit S (dec *B)))
         (setq X (- *Q X)) )
      (setq R (cons X Y))
      (or (isoncurve R) (quit "decoding point that is not on curve"))
      R ) )
(de Hint (Lst)
   (bitsum (sha512 Lst) 0 (* 2 *B)) )
(de publickey (Lst)
   (let A
      (+
         `(** 2 (- *B 2))
         (bitsum (sha512 Lst) 3 `(- *B 2)) )
      (println 'A A)
      (encodepoint (scalarmult *Bxy A)) ) )
(de signature (M SK PK)
   (let
      (H (sha512 SK)
         A (+ `(** 2 (- *B 2)) (bitsum H 3 `(- *B 2)))
         r
         (Hint
            (append (head 32 (nth H `(inc 32))) M) )
         R (scalarmult *Bxy r)
         S
         (%
            (+
               r
               (* A (Hint (append (encodepoint R) PK M))) )
            *L ) )
      (println 'H H 'A A 'r r 'R R 'S S)
      (append (encodepoint R) (encodeint S)) ) )
(de checkvalid (S M PK)
   (or
      (= `(/ *B 4) (length S))
      (quit "signature length is wrong") )
   (or
      (= `(/ *B 8) (length PK))
      (quit "public-key length is wrong") )
   (let
      (R (decodepoint (head 32 S))
         A (decodepoint PK)
         S (decodeint (head 32 (nth S `(inc 32))))
         H (Hint
            (append
               (encodepoint R)
               PK
               M ) ) )
      (= (scalarmult *Bxy S) (edwards R (scalarmult A H))) ) )
