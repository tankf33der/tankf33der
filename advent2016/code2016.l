`(== 64 64)
(load "@lib/simul.l")
(scl 0) # against md5

# --- Day 1: No Time for a Taxicab ---
(de right? (Lst)
   (= "R" (car Lst)) )
(de z1-1 (F)
   (let XY (list 0 0)
      (in F
         (while (prog1 (setq @@ (till ",")) (do 2 (char)))
            (let N (format (cdr @@))
               (state '(north)
                  (north
                     (cond
                        ((right? @@) (inc XY N) 'east)
                        (T (dec XY N) 'west) ) )
                  (south
                     (cond
                        ((right? @@) (dec XY N) 'west)
                        (T (inc XY N) 'east) ) )
                  (east
                     (cond
                        ((right? @@) (dec (cdr XY) N) 'south)
                        (T (inc (cdr XY) N) 'north) ) )
                  (west
                     (cond
                        ((right? @@) (inc (cdr XY) N) 'north)
                        (T (dec (cdr XY) N) 'south) ) ) ) ) ) )
      (+ (abs (car XY)) (abs (cadr XY))) ) )
(test 5 (z1-1 "data/1-test-1.txt"))
(test 2 (z1-1 "data/1-test-2.txt"))
(test 12 (z1-1 "data/1-test-3.txt"))
(test 231 (z1-1 "data/1.txt"))

(de _pushz1 ("L" D)
   (unless (member D (val "L")) (push "L" D)) )
(de z1-2 (F)
   (let (XY (list 0 0)  L)
      (catch 'Found
         (in F
            (while (prog1 (setq @@ (till ",")) (do 2 (char)))
               (let
                  (N (format (cdr @@))
                     D (list 'prog 'prog) )
                  (state '(north)
                     (north
                        (cond
                           ((right? @@) (set D 'inc) 'east)
                           (T (set D 'dec) 'west) ) )
                     (south
                        (cond
                           ((right? @@) (set D 'dec) 'west)
                           (T (set D 'inc) 'east) ) )
                     (east
                        (cond
                           ((right? @@) (set (cdr D) 'dec) 'south)
                           (T (set (cdr D) 'inc) 'north) ) )
                     (west
                        (cond
                           ((right? @@) (set (cdr D) 'inc) 'north)
                           (T (set (cdr D) 'dec) 'south) ) ) )
                  (do N
                     (NIL 
                        (_pushz1
                           'L 
                           (setq 
                              XY 
                              (mapcar '((A B) (A B)) D XY) ) )
                        (throw 'Found) ) ) ) ) ) )
      (+ (abs (car XY)) (abs (cadr XY))) ) )
(test 4 (z1-2 "data/1-test-4.txt"))
(test 147 (z1-2 "data/1.txt"))

# --- Day 2: Bathroom Security ---
(de z2-1 (F)
   (let (G (grid 3 3)  Z 0  R)
      (for Col G
         (for This Col
            (=: Z2 (inc 'Z)) ) )
      (in F
         (with 'b2
            (until (eof)
               (for D (line)
                  (and
                     ((case D
                           ("R" north)
                           ("L" south)
                           ("U" west)
                           ("D" east) )
                        This )
                     (setq This @) ) )
               (queue 'R (: Z2)) ) ) )
      (format R) ) )
(test 1985 (z2-1 "data/2-test-1.txt"))
(test 36629 1985 (z2-1 "data/2.txt"))

(de z2-2 (F Lst)
   (let (Grid (grid 5 5)  R)
      (mapc
         '((G L)
            (mapc
               '((This Val)
                  (cond
                     ((=0 Val)
                        (with (: 0 1 1) (con (: 0 1)))    # Cut off west
                        (with (: 0 1 -1) (set (: 0 1)))   # east
                        (with (: 0 -1 1) (con (: 0 -1)))  # south
                        (with (: 0 -1 -1) (set (: 0 -1))) # north
                        (set This) )
                     (T (=: Z2-2 Val)) ) )
               G L) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (in F
         (with 'a3
            (until (eof)
               (for D (line)
                  (and
                     ((case D
                           ("R" east)
                           ("L" west)
                           ("U" north)
                           ("D" south) )
                        This )
                     (setq This @) ) )
               (queue 'R (: Z2-2)) ) ) )
      (pack R) ) )
(test
   "5DB3"
   (z2-2
      "data/2-test-1.txt"
      (quote
         (0 0 1 0 0)
         (0 2 3 4 0)
         (5 6 7 8 9)
         (0 A B C 0)
         (0 0 D 0 0) ) ) )
(test
   "99C3D"
   (z2-2
      "data/2.txt"
      (quote
         (0 0 1 0 0)
         (0 2 3 4 0)
         (5 6 7 8 9)
         (0 A B C 0)
         (0 0 D 0 0) ) ) )

# --- Day 3: Squares With Three Sides ---
(de z3-1 (F)
   (let C 0
      (in F
         (until (eof)
            (let
               (N (list (read) (read) (read))
                  N (sort N) )
               (when (> (+ (car N) (cadr N)) (caddr N))
                  (inc 'C) ) ) ) )
      C ) )
(test 869 (z3-1 "data/3.txt"))

(de z3-2 (F)
   (let (C1 NIL  C2 NIL  C3 NIL  R 0)
      (in F
         (until (eof)
            (skip)
            (push 'C1 (format (till " ")))
            (skip)
            (push 'C2 (format (till " ")))
            (skip)
            (push 'C3 (format (line))) ) )
      (conc C1 C2 C3)
      (for (L C1 (cddr L) (cdddr L))
         (and
            (> (+ (car L) (cadr L)) (caddr L))
            (> (+ (cadr L) (caddr L)) (car L))
            (> (+ (caddr L) (car L)) (cadr L))
            (inc 'R) ) )
      R ) ) 
(test 6 (z3-2 "data/3-test-1.txt"))
(test 1544 (z3-2 "data/3.txt"))

# --- Day 4: Security Through Obscurity ---
(de z4-1 (F)
   (let Lst
      (make
         (in F
            (until (eof)
               (let D (head -1 (split (line) "-" "[" "]"))
                  (link
                     (cons (mapcan prog (head -2 D)) (tail 2 D)) ) ) ) ) )
      (sum
         '((L)
            (use R
               (mapc
                  '((C) (accu 'R C 1))
                  (car L) )
               (and
                  (=
                     (pack (caddr L))
                     (pack
                        (head
                           5
                           (mapcar
                              car
                              (by
                                 '((X) (cons (- (cdr X)) (car X)))
                                 sort
                                 R ) ) ) ) )
                  (format (cadr L)) ) ) )
         Lst ) ) )
(test 1514 (z4-1 "data/4-test-1.txt"))
(test 137896 (z4-1 "data/4.txt"))

(setq *z4-Letters (apply circ (mapcar char (range 97 122))))
(de z4-caesar (Str Key)
   (pack
      (mapcar 
         '((C) (cadr (nth (member C *z4-Letters) Key)))
         Str ) ) )
(de z4-2 (F)
   (let Lst
      (make
         (in F
            (until (eof)
               (let D (split (line) "-" "[")
                  (link
                     (conc
                        (head -2 D)
                        (cons (format (car (tail 2 D)))) ) ) ) ) ) )
      (pick
         '((L)
            (and
               (= 9 (length (car L)))
               (= "northpole" (z4-caesar (car L) (last L)))
               (last L) ) )
         Lst ) ) )
(test 501 (z4-2 "data/4.txt")) 

# --- Day 5: How About a Nice Game of Chess? ---
(de z5-md5 (Str)
   (native
      "libcrypto.so"
      "MD5"
      '(B . 16)
      Str
      (length Str)
      '(NIL (16)) ) )
(de z5-1 (Str)
   (let N 2200000
      (lowc
         (pack
            (make
               (do 8
                  (until
                     (and
                        (setq @@ (z5-md5 (pack Str (inc 'N))))
                        (= 0 (car @@) (cadr @@))
                        (> 16 (caddr @@))
                        (link (hex (get @@ 3))) ) ) ) ) ) ) ) )
# Long run
#(test "2414bc77" (z5-1 "wtnhxymk"))

(de z5-22 (Str)
   (let (N 2200000  R (need 8))
      (do 8
         (until
            (and
               (setq @@ (z5-md5 (pack Str (inc 'N))))
               (= 0 (car @@) (cadr @@))
               (<= 0 (caddr @@) 7)
               (not (get R (inc (caddr @@)))) # empty slot?
               (set (nth R (inc (caddr @@)))
                  (hex (>> 4 (cadddr @@))) ) ) ) )
      (lowc (pack R)) ) )
# Long run
#(test "437e60fc" (z5-22 "wtnhxymk"))

# --- Day 6: Signals and Noise ---
(de z6-1 (F Fun N)
   (let Lst (need N)
      (in F
         (until (eof)
            (for (I . C) (line)
               (accu (nth Lst I) C 1) ) ) )
      (pack
         (mapcar '((L) (car (Fun cdr L))) Lst) ) ) )
(test "easter" (z6-1 "data/6-test-1.txt" maxi 6))
(test "ikerpcty" (z6-1 "data/6.txt" maxi 8))
(test "advent" (z6-1 "data/6-test-1.txt" mini 6))
(test "uwpfaqrq" (z6-1 "data/6.txt" mini 8))

# --- Day 7: Internet Protocol Version 7 ---
(de z7-1-check (Lst)
   (for (L Lst (cdddr L) (cdr L))
      (T 
         (and
            (<> (car L) (cadr L))
            (= (car L) (cadddr L))
            (= (cadr L) (caddr L)) )
         T ) ) )
(de z7-1 (F)
   (let C 0
      (in F
         (until (eof)
            (let R (list 0 0) 
               (for (I . L) (split (line) "[" "]")
                  (and
                     (z7-1-check L)
                     (inc (if (bit? 1 I) R (cdr R))) ) )
               (and
                  (gt0 (car R))
                  (=0 (cadr R))
                  (inc 'C) ) ) ) )
      C ) )
(test 2 (z7-1 "data/7-test-1.txt"))
(test 110 (z7-1 "data/7.txt"))

(de z7-2-create (Lst)
   (make
      (for (L Lst (cddr L) (cdr L))
         (and
            (<> (car L) (cadr L))
            (= (car L) (caddr L))
            (link (list (cadr L) (car L) (cadr L))) ) ) ) )
(de z7-2-seek (Lst Y)
   (seek '((L) (fully = Y L)) Lst) )
(de z7-2 (F)
   (let C 0 
      (in F
         (until (eof)
            (let R (need 2)
               (for (I . L) (split (line) "[" "]")
                  (push (if (bit? 1 I) R (cdr R)) L) )
               (and
                  (mapcan z7-2-create (car R))
                  (find 
                     '((A) 
                        (find '((B) (z7-2-seek B A)) (cadr R)) )
                     @ ) 
                  (inc 'C) ) ) ) )
      C ) )
(test 3 (z7-2 "data/7-test-2.txt"))
(test 242 (z7-2 "data/7.txt"))

# --- Day 8: Two-Factor Authentication ---
(de z8-row (Lst R N)
   (let L (get Lst (inc R))
      (do N 
         (rot L) ) ) )
(de z8-column (Lst C N)
   (let Col (mapcar '((L) (get L (inc C))) Lst)
      (do N
         (rot Col) )
      (mapc
         '((A B) (set (nth A (inc C)) B))
         Lst
         Col ) ) )
(de z8-create (R C) 
   (make
      (do R
         (link (need C 0)) ) ) )
(de z8-print (Lst)
   (prinl)
   (for X Lst
      (for Y X
         (prin (if (=0 Y) "." "#")) )
      (prinl) ) )
(de z8-rect (Lst X Y)
   (for (L Lst (gt0 Y) (dec 'Y) (cdr L))
      (let L (car L)
         (do X
            (set L 1)
            (++ L) ) ) ) )
(de z8-count (Lst)
   (sum
      '((L) (cnt =1 L))
      Lst ) )
(de z8-1 (F Lst)
   (in F
      (until (eof)
         (let L
            (mapcan
               '((X) (and X (cons (pack X))))
               (split (line) " " "=" "b" "y" "x") )
            (if (= "rect" (car L))
               (z8-rect Lst (format (cadr L)) (format (caddr L)))
               (case (cadr L)
                  ("row"
                     (z8-row Lst (format (caddr L)) (format (cadddr L))))
                  (T (z8-column Lst (format (caddr L)) (format (cadddr L)))) ) ) ) ) )
   #(z8-print Lst)
   (z8-count Lst) )
(test 6 (z8-1 "data/8-test-1.txt" (z8-create 3 7)))
(test 110 (z8-1 "data/8.txt" (z8-create 6 50)))

# --- Day 9: Explosives in Cyberspace ---
(de z9-1 (F)
   (let Len 0
      (in F
         (until (eof)
            (ifn (= "(" (char))
               (inc 'Len)
               (let (A 0  B 0)
                  (setq
                     A (prog1 (format (till "x")) (char))
                     B (prog1 (format (till ")")) (char)) )
                  (inc 'Len (* A B))
                  (do A
                     (char) ) ) ) ) )
      Len ) )
(test 107035 (z9-1 "data/9.txt"))

(de z9-set (Lst S N B)
   (for ((I . L) (nth Lst S) L (cdr L))
      (set L B)
      (T (>= I N)) ) )
(de z9-2 (F)
   (let 
      (Len 0
         Pos 1
         Lst 
         (need (in F (length (line T))) 1) )
      (in F
         (until (eof)
            (let Mult (get Lst Pos)
               (ifn (= "(" (char))
                  (prog (inc 'Pos) (inc 'Len Mult))
                  (let (A 0  B 0)
                     (setq
                        A (prog1 (format (till "x")) (char))
                        B (prog1 (format (till ")")) (char)) )
                     (inc 'Pos (+ 3 (length A) (length B)))
                     (z9-set Lst Pos A (* Mult B)) ) ) ) ) )
      Len ) )
(test 20 (z9-2 "data/9-test-2.txt"))
(test 11451628995 (z9-2 "data/9.txt"))

# --- Day 10: Balance Bots ---
(de z10-bots (F)
   (in F
      (make
         (until (eof)
            (and
               (= "b" (peek))
               (link
                  (make
                     (link (prog (read) (read)))
                     (do 3
                        (read) )
                     (char)
                     (link
                        ((if2 (= "b" (peek)) (read)
                              prog
                              NIL
                              cons )
                           (read) ) )
                     (do 3
                        (read) )
                     (char)
                     (link
                        ((if2 (= "b" (peek)) (read)
                              prog
                              NIL
                              cons )
                        (read) ) ) ) ) )
                  (line) ) ) ) )
(de z10-values (F)
   (in F
      (make
         (until (eof)
            (use A
               (and
                  (= "v" (peek))
                  (link
                     (make
                        (setq A (prog (read) (read)))
                        (do 3
                           (read) )
                        (link (read) A) ) ) ) )
            (line) ) ) ) )
(de z10-worker (Lst)
   (ifn (assoc (car Lst) R)
      (push 'R Lst)
      (let 
         (L (sort (list (cadr @) (cadr Lst)))
            A (cdr (assoc (car Lst) D)) )
         (push 'Fin (cons (car Lst) L))
         (mapc
            '((X Y)
               (cond
                  ((and (lst? X) (>= 3 (inc (car X))))
                     (set (nth O (inc (car X))) Y) )
                  (T (z10-worker (list X Y))) ) )
            A
            L ) ) ) )
(de z10-1-2 (F)
   (let
      (D (z10-bots F)
         A (z10-values F)
         R NIL
         Fin NIL
         O (need 3) )
      (mapc z10-worker A)
      (list
         (car (rassoc (17 61) Fin))
         (apply * O) ) ) )
(test (116 23903) (z10-1-2 "data/10.txt"))

# --- Day 11: Radioisotope Thermoelectric Generators ---

# --- Day 12: Leonardo's Monorail ---
(de z12-parse (F)
   (make
      (in F
         (until (eof)
            (link (make (until (eol) (link (read)))))
            (line) ) ) ) )
(de z12-1 (Lst R)
   (let (I 1  Len (length Lst))
      (while (>= Len I)
         (let Op (get Lst I)
            (case (car Op)
               ("cpy"
                  (or
                     (assoc (caddr Op) R)
                     (push 'R (list (caddr Op) 0)) )
                  (set (cdr (assoc (caddr Op) R))
                     (if (num? (cadr Op))
                        @
                        (cadr (assoc (cadr Op) R)) ) )
                  (inc 'I) )
               ("inc"
                  (inc (cdr (assoc (cadr Op) R)))
                  (inc 'I) )
               ("dec"
                  (dec (cdr (assoc (cadr Op) R)))
                  (inc 'I) )
               ("jnz"
                  (let N
                     (if (num? (cadr Op))
                        @
                        (cadr (assoc (cadr Op) R)) )
                     (or
                        (assoc (cadr Op) R)
                        (push 'R (list (cadr Op) 0)) )
                     (inc 'I (if (gt0 N) (caddr Op) 1)) ) ) ) ) )
      (cadr (assoc 'a R)) ) )
(test 42 (z12-1 (z12-parse "data/12-test-1.txt")))
(test 318117 (z12-1 (z12-parse "data/12.txt")))
# part 2
(test 9227771 (z12-1 (z12-parse "data/12.txt") '((c 1))))

# --- Day 13: A Maze of Twisty Little Cubicles ---
(de z13-space (X Y N) # T - space, NIL - wall
   (not
      (bit? 
         1
         (cnt
            '((D) (= "1" D))
            (chop
               (bin
                  (+
                     N
                     (* X X)
                     (* 3 X)
                     (* 2 X Y)
                     Y
                     (* Y Y) ) ) ) ) ) ) )
(de z13-floor (X Y N) # column, row
   (let (X (+ X 7)  Y (+ Y 7))
      (make
         (for R Y
            (link
               (make
                  (for C X
                     (link (z13-space C R N)) ) ) ) ) ) ) )
(de z13-1 (X Y N)
   (let 
      (Path NIL
         Best NIL
         Goal NIL
         Lst (z13-floor X Y N)
         Grid (grid (length Lst) (length (car Lst))) )
      (mapc
         '((G)
            (mapc 
               '((This) 
                  (=: visit NIL) (=: V NIL)) 
               G ) )
         Grid )
      (mapc
         '((G L)
            (mapc
               '((This Val)
                  (if Val
                     (=: space T)
                     (with (: 0 1 1) (con (: 0 1)))    # W
                     (with (: 0 1 -1) (set (: 0 1)))   # E
                     (with (: 0 -1 1) (con (: 0 -1)))  # S
                     (with (: 0 -1 -1) (set (: 0 -1))) # N
                     (set This) ) )
               G
               L ) )
         Grid
         Lst ) 
      (setq Goal (car (nth Grid Y X)))
      (with (caar Grid)
         (recur (This Path)
            (when (and This (not (: visit)))
               (push 'Path This)
               (if (== Goal This)
                  (unless (and Best (>= (length Path) (length Best)))
                     (setq Best Path) )
                  (=: visit T)
                  (recurse (west This) Path)
                  (recurse (east This) Path)
                  (recurse (south This) Path)
                  (recurse (north This) Path)
                  (=: visit NIL) ) ) ) )
      (dec (length Best)) ) )
(test 11 (z13-1 7 4 10))
(test 90 (z13-1 31 39 1352))

# --- Day 14: One-Time Pad ---
(de z14-md5 (Str)
   (native
      "libcrypto.so"
      "MD5"
      '(B . 16)
      Str
      (length Str)
      '(NIL (16)) ) )
(de z14-three (Lst)
   (for (L Lst (cddr L) (cdr L))
      (T (apply = (head 3 L))
         (cons (car L) 3) ) ) ) 
(de z14-five (Lst)
   (make
      (for (L Lst (cddddr L) (cdr L))
         (and
            (apply = (head 5 L))
            (link (cons (car L) 5)) ) ) ) )
(de z14-store (Str)
   (cache
      '(NIL) 
      Str
      (let Lst
         (chop
            (pack
               (mapcar 
                  '((B) (pad 2 (hex B)))
                  (z14-md5 Str) ) ) )
         (cons (z14-three Lst) (z14-five Lst)) ) ) )
(de z14-1 (Str)
   (let N 1
      (do 64
         (until
            (and
               (setq @@
                  (car
                     (rassoc 3 (z14-store (pack Str (inc 'N)))) ) )
               (for (I (inc N) (>= (+ 1000 N) I) (inc I))
                  (T (member (cons @@ 5) (z14-store (pack Str I))) 
                     T ) ) ) ) )
      N ) )
(test 16106 (z14-1 "zpqevtbw"))

(de z14-md5-2 (Str)
   (lowc
      (pack
         (mapcar
            '((B) (pad 2 (hex B)))
            (native
               "libcrypto.so"
               "MD5"
               '(B . 16)
               Str
               (length Str)
               '(NIL (16)) ) ) ) ) )
(de z14-2016 (Str)
   (do 2017
      (setq Str (z14-md5-2 Str)) ) )
(de z14-store-2 (Str N)
   (cache
      '(NIL)
      N
      (let Lst (chop (z14-2016 (pack Str N)))
         (cons (z14-three Lst) (z14-five Lst)) ) ) ) 
(de z14-2 (Str)
   (let N 5460
      (do 64
         (until
            (and
               (setq @@
                  (car
                     (rassoc 3 (z14-store-2 Str (inc 'N))) ) )
               (for (I (inc N) (>= (+ 1000 N) I) (inc I))
                  (T (member (cons @@ 5) (z14-store-2 Str I))
                     T ) ) ) ) )
      N ) )
# Long run
#(test 22423 (z14-2 "zpqevtbw")))

# --- Day 15: Timing is Everything ---
# http://rosettacode.org/wiki/Chinese_remainder_theorem#PicoLisp
(de z15-modinv (A B)
   (let (B0 B  X0 0  X1 1  Q 0  T1 0)
      (while (< 1 A)
         (setq
            Q (/ A B)
            T1 B
            B (% A B)
            A T1
            T1 X0
            X0 (- X1 (* Q X0))
            X1 T1 ) )
      (if (lt0 X1) (+ X1 B0) X1) ) )
(de z15-modulo (X Y)
   (% (+ Y (% X Y)) Y) )
(de z15-chinrem (N A)
   (let P (apply * N)
      (%
         (sum
            '((N A)
               (setq T1 (/ P N))
               (* A (z15-modinv T1 N) T1) )
            N
            A )
         P ) ) )
(de z15-1 (F)
   (let D
      (in F
         (make
            (until (eof)
               (link
                  (make
                     (from "#")
                     (link (read))
                     (read)
                     (link (read))
                     (from "at position")
                     (link (read)) ) )
               (line) ) ) )
      (z15-chinrem 
         (mapcar '((L) (get L 2)) D)
         (mapcar
            '((L)
               (z15-modulo
                  (- (cadr L) (car L) (caddr L))
                  (cadr L) ) )
            D ) ) ) )
(test 400589 (z15-1 "data/15.txt"))
(test 3045959 (z15-1 "data/15-2.txt"))

# --- Day 16: Dragon Checksum ---
(de z16-flip (Lst) # flip and reverse
   (make
      (for L Lst
         (yoke (if (=0 L) 1 0)) ) ) )
(de z16-cksum (Lst)
   (until (bit? 1 (length Lst))
      (setq Lst
         (make
            (for (L Lst (cdr L) (cddr L))
               (link
                  (if (= (car L) (cadr L)) 1 0) ) ) ) ) ) )
(de z16-1 (Str N)
   (let Str (mapcar format (chop Str))
      (while (>= N (length Str))
         (let Lst (z16-flip Str)
            (conc Str (cons 0) Lst) ) )
      (pack (z16-cksum (head N Str))) ) )
(test "01100" (z16-1 "10000" 20))
(test "11101010111100010" (z16-1 "10111011111001111" 272))

# --- Day 17: Two Steps Forward ---
(de z17-md5 (Str)
   (lowc
      (pack
         (mapcar
            '((B) (pad 2 (hex B)))
            (native
               "libcrypto.so"
               "MD5"
               '(B . 16)
               Str
               (length Str)
               '(NIL (16)) ) ) ) ) )
(de z17-1 (Str)
   (let
      (Path NIL
         Best NIL
         Goal 'd1
         Grid (grid 4 4)
         Door "b" )
      (with 'a4
         (recur (This Path Dir Door)
            (when (and This (member Door '("b" "c" "d" "e" "f")))
               (setq Path (append Path (cons Dir)))
               (if (== Goal This)
                  (unless (and Best (>= (length Path) (length Best)))
                     (setq Best Path) )
                  (let L (head 4 (chop (z17-md5 (pack Str Path))))
                     (recurse (west This) Path "L" (caddr L))
                     (recurse (east This) Path "R" (cadddr L))
                     (recurse (south This) Path "D" (cadr L))
                     (recurse (north This) Path "U" (car L)) ) ) ) ) )
      (pack (cdr Best)) ) )
(test "DDRRRD" (z17-1 "ihgpwlah"))
(test "DDUDRLRRUDRD" (z17-1 "kglvqrro"))
(test "DRURDRUDDLLDLUURRDULRLDUUDDDRR" (z17-1 "ulqzkmiv"))
(test "RLRDRDUDDR" (z17-1 "rrrbmfta"))

(de z17-2 (Str)
   (let
      (Path NIL
         Best NIL
         Goal 'd1
         Grid (grid 4 4)
         Door "b" )
      (with 'a4
         (recur (This Path Dir Door)
            (when (and This (member Door '("b" "c" "d" "e" "f")))
               (setq Path (append Path (cons Dir)))
               (if (== Goal This)
                  (unless (<= (length Path) (length Best))
                     (setq Best Path) )
                  (let L (head 4 (chop (z17-md5 (pack Str Path))))
                     (recurse (west This) Path "L" (caddr L))
                     (recurse (east This) Path "R" (cadddr L))
                     (recurse (south This) Path "D" (cadr L))
                     (recurse (north This) Path "U" (car L)) ) ) ) ) )
      (length (cdr Best)) ) )
(test 370 (z17-2 "ihgpwlah"))
(test 492 (z17-2 "kglvqrro"))
(test 830 (z17-2 "ulqzkmiv"))
(test 420 (z17-2 "rrrbmfta"))

# --- Day 18: Like a Rogue ---
(de z18-safe (L C R)
   (default L 0  R 0)
   (or
      (and (= 1 L C) (=0 R) 1)
      (and (= 1 C R) (=0 L) 1)
      (and (=1 L) (= 0 R C) 1)
      (and (=1 R) (= 0 L C) 1)
      0 ) )
(de z18-1 (F X)
   (sum
      '((L) (cnt =0 L))
      (make
         (setq @@
            (link
               (make
                  (in F
                     (for C (line)
                        (link (if (= C ".") 0 1)) ) ) ) ) )
         (do (dec X)
            (setq @@
               (link
                  (make
                     (for N (length @@)
                        (link
                           (z18-safe
                              (get @@ (dec N))
                              (get @@ N)
                              (get @@ (inc N)) ) ) ) ) ) ) ) ) ) )
(test 38 (z18-1 "data/18-test-1.txt" 10))
(test 2016 (z18-1 "data/18.txt" 40))
#(test 19998750 (z18-1 "data/18.txt" 400000)) # ~600MB heap

# --- Day 19: An Elephant Named Joseph ---
# http://rosettacode.org/wiki/Josephus_problem#PicoLisp
(de z19-1 (N)
   (let P 1
      (while (<= P N)
         (setq P (* 2 P))
         (+ (- (* 2 N) P) 1) ) ) )
(test 1834903 (z19-1 3014603)) 

(de z19-2 (N)
   (let I 1
      (while (> N (* 3 I))
         (setq I (* I 3)) )
      (- N I) ) )
(test 1420280 (z19-2 3014603))

# --- Day 20: Firewall Rules ---
(de z20-1 (F)
   (let 
      (Lst
         (sort
            (in F
               (make
                  (until (eof)
                     (link
                        (list (format (till "-")) (prog (char) (read))) )
                     (line) ) ) ) )
         R 0 )
      (for L Lst
         (T (> (car L) R) R)
         (and
            (<= R (cadr L))
            (setq R (inc (cadr L))) ) ) ) )
(test 3 (z20-1 "data/20-test-1.txt"))
(test 17348574 (z20-1 "data/20.txt"))

(de z20-2 (F)
   (let
      (Lst
         (sort
            (in F
               (make
                  (until (eof)
                     (link
                        (list (format (till "-")) (prog (char) (read))) )
                     (line) ) ) ) )
         I 0
         S 0 )
      (for L Lst
         (and
            (< I (car L))
            (inc 'S (- (car L) I)) )
         (setq I (max I (inc (cadr L)))) )
      (inc 'S (- (** 2 32) I)) ) )
(test 104 (z20-2 "data/20.txt"))
      
# --- Day 21: Scrambled Letters and Hash ---
(de z21-swap (A B Lst) # zero based
   (let Lst (copy Lst)
      (if (num? A)
         (setq A (inc A)  B (inc B))
         (setq A (index A Lst)  B (index B Lst)) )
      (xchg (nth Lst A) (nth Lst B))
      Lst ) )
(de z21-move (A B Lst) # zero based
   (let (A (inc A)  B (inc B))
      (insert B (remove A Lst) (get Lst A)) ) )
(de z21-reverse (A B Lst) # zero based
   (let (A (inc A)  B (inc B))
      (append
         (head (dec A) Lst)
         (reverse
            (head (inc (- B A)) (nth Lst A) ) )
         (tail (- (length Lst) B) Lst) ) ) )
(de z21-left (N Lst)
   (do N
      (setq Lst
         (append
            (cdr Lst)
            (cons (car Lst)) ) ) )
   Lst )
(de z21-right (N Lst)
   (do N
      (setq Lst
         (append
            (cons (last Lst))
            (head (dec (length Lst)) Lst) ) ) )
   Lst )
(de z21-rotate (C Lst)
   (let Idx (index C Lst)
      (and (> Idx 4) (inc 'Idx))
      (z21-right Idx Lst) ) )
(de z21-rotate-2 (C Lst)
   (for N (+ 2 (length Lst))
      (T (= Lst (z21-rotate C (setq @@ (z21-left N Lst)))) 
         @@ ) ) )
(test
   '("b" "c" "d" "e" "f" "a")
   (z21-rotate-2 "b" (chop "abcdef")) )
(test
   '("d" "e" "f" "a" "b" "c")
   (z21-rotate-2 "f" (chop "abcdef")) )
(test '(e c a b d) (z21-rotate 'b '(a b d e c)))
(test '(d e c a b) (z21-rotate 'd '(e c a b d)))
(test
   '("d" "e" "c" "a" "b")
   (z21-rotate "d" '("e" "c" "a" "b" "d")) )
(test (range 1 4) (z21-right 0 (range 1 4)))
(test '(d a b c) (z21-right 1 '(a b c d)))
(test '(b c d a) (z21-right 3 '(a b c d)))
(test '(d e c a b) (z21-right 6 '(e c a b d)))
(test '(b c d e a) (z21-left 1 '(a b c d e)))
(test '(c d e a b) (z21-left 2 '(a b c d e)))
(test (range 1 4) (z21-left 0 (range 1 4)))
(test (3 2 1 4) (z21-reverse 0 2 (range 1 4)))
(test (1 2 4 3) (z21-reverse 2 3 (range 1 4)))
(test (2 1 3 4) (z21-reverse 0 1 (range 1 4)))
(test (4 3 2 1) (z21-reverse 0 3 (range 1 4)))
(test (4 3 2 1 5 6 7) (z21-reverse 0 3 (range 1 7)))
(test (1 4 3 2 5 6) (z21-reverse 1 3 (range 1 6)))
(test '(a d c b e) (z21-swap 1 3 '(a b c d e)))
(test '(d b c a e) (z21-swap 3 0 '(a b c d e)))
(test '(c z z z a) (z21-swap 'a 'c '(a z z z c)))
(test '(y x) (z21-swap 'x 'y '(x y)))
(test '(b d e a c) (z21-move 1 4 '(b c d e a)))
(test '(a b d e c) (z21-move 3 0 '(b d e a c)))
(test (range 1 4) (z21-move 0 0 (range 1 4)))

(de z21-1 (F Lst)
   (in F
      (until (eof)
         (let L
            (mapcar
               '((L) (if (format L) @ (pack L)))
               (split (line) " ") )
            (setq Lst
               (case (car L)
                  ("swap" (z21-swap (get L 3) (get L 6) Lst))
                  ("reverse" (z21-reverse (get L 3) (get L 5) Lst))
                  ("rotate"
                     (cond
                        ((= "left" (cadr L))
                           (z21-left (get L 3) Lst) )
                        ((= "right" (cadr L)) 
                           (z21-right (get L 3) Lst) )
                        (T (z21-rotate (last L) Lst)) ) )
                  ("move" (z21-move (get L 3) (get L 6) Lst)) ) ) ) ) )
   (pack Lst) )
(test "decab" (z21-1 "data/21-test-1.txt" (chop "abcde")))
(test "gbhcefad" (z21-1 "data/21.txt" (chop "abcdefgh")))

(de z21-2 (F Lst)
   (let Op
      (make
         (in F
            (until (eof)
               (yoke
                  (mapcar
                     '((L) (if (format L) @ (pack L)))
                     (split (line) " ") ) ) ) ) )
      (for L Op
         (setq Lst
            (case (car L)
               ("swap" (z21-swap (get L 3) (get L 6) Lst))
               ("reverse" (z21-reverse (get L 3) (get L 5) Lst))
               ("rotate"
                  (cond
                     ((= "left" (cadr L))
                        (z21-right (get L 3) Lst) )
                     ((= "right" (cadr L))
                        (z21-left (get L 3) Lst) )
                     (T (z21-rotate-2 (last L) Lst)) ) )
               ("move" (z21-move (get L 6) (get L 3) Lst)) ) ) )  
      (pack Lst) ) )
(test "gahedfcb" (z21-2 "data/21.txt" (chop "fbgdceah")))

# --- Day 22: Grid Computing ---

# --- Day 23: Safe Cracking ---

# --- Day 24: Air Duct Spelunking ---

# --- Day 25: Clock Signal ---

(msg 'OK-AoC16)
