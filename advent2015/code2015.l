(load "@lib/simul.l")

# --- Day 1: Not Quite Lisp ---
(de b1-1 (F)
   (let C 0
      (in F
         (until (eof)
            (case (char)
               ("(" (inc 'C))
               (")" (dec 'C)) ) ) )
      C ) )
(test 3 (b1-1 "data/1-test-1.txt"))
(test 138 (b1-1 "data/1.txt"))

(de b1-2 (F)
   (let (C 0  P 0)
      (in F
         (until (lt0 C)
            (inc 'P)
            (case (char)
               ("(" (inc 'C))
               (")" (dec 'C)) ) ) )
      P ) )
(test 5 (b1-2 "data/1-test-2.txt"))
(test 1771 (b1-2 "data/1.txt"))

# --- Day 2: I Was Told There Would Be No Math ---
(de b2-1 (F)
   (let S 0
      (in F
         (until (eof)
            (let L
               (list
                  (setq @ (format (till "x")))
                  (prog (char) (format (till "x")))
                  (prog (char) (format (line T)))
                  @ )
               (inc
                  'S
                  (min
                     (* (car L) (cadr L))
                     (* (cadr L) (caddr L))
                     (* (caddr L) (car L)) ) )
               (for (A L (cdr A) (cdr A))
                  (inc 'S (* 2 (car A) (cadr A))) ) ) ) )
      S ) )
(test 101 (b2-1 "data/2-test-1.txt"))
(test 1606483 (b2-1 "data/2.txt"))

(de prod1 (Lst)
   (let P 1
      (for L Lst
         (setq P (* P (car L))) ) ) )
      
(de b2-2 (F)
   (let S 0
      (in F
         (until (eof)
            (let L
               (list
                  (list
                     (setq @@ (format (till "x")))
                     (prog (char) (setq @ (format (till "x")))) )
                  (list
                     @
                     (prog (char) (setq @ (format (line T)))) )
                  (list @ @@) )
               (setq @
                  (mini
                     '((L) (* (car L) (cadr L)))
                     L ) )
               (inc 'S (sum + @ @))
               (inc 'S (prod1 L)) ) ) )
      S ) )

(test 48 (b2-2 "data/2-test-1.txt"))
(test 3842356 (b2-2 "data/2.txt"))

# --- Day 3: Perfectly Spherical Houses in a Vacuum ---
(de b3-1 (F)
   (let (L (list 0 0)  R)
      (push1 'R (copy L))
      (in F
         (until (eof)
            (case (char)
               (^ (inc L))
               ("v" (dec L))
               ("<" (inc (cdr L)))
               (">" (dec (cdr L))) )
            (push1 'R (copy L)) ) )
      (length R) ) )
(test 4 (b3-1 "data/3-test-1.txt"))
(test 2565 (b3-1 "data/3.txt"))

(de b3-2 (F)
   (let (L (circ (list 0 0) (list 0 0))  R)
      (push1 'R (copy (++ L)))
      (in F
         (until (eof)
            (case (char)
               (^ (inc (car L)))
               ("v" (dec (car L)))
               ("<" (inc (cdar L)))
               (">" (dec (cdar L))) )
            (push1 'R (copy (++ L))) ) )
      (length R) ) )
(test 3 (b3-2 "data/3-test-1.txt"))
(test 2639  (b3-2 "data/3.txt"))

# --- Day 4: The Ideal Stocking Stuffer ---
(load "../md5.l") # RosettaCode
(de b4-1 (Str Z)
   (let
      (Str (mapcar char (chop Str))
         Len (length Str)
         Start (pack (need Z "0"))
         N (if (= 5 Z) 346000 9958000)) # for faster runtime
      (until
         (prog
            (con
               (nth Str Len)
               (mapcar char (chop (format (inc 'N)))) )
            (pre? Start (md5_hex Str)) ) )
      N ) )
(test 346386 (b4-1 "iwrupvqb" 5))
(test 9958218 (b4-1 "iwrupvqb" 6))

# --- Day 5: Doesn't He Have Intern-Elves For This? ---
(de b5-1 (F)
   (let L 0
      (in F
         (until (eof)
            (let (V 0  D 0  S 0  Lst (line))
               (for (A Lst A (cdr A))
                  (and
                     (member (car A) '(a e i o u))
                     (inc 'V) )
                  (and
                     (= (car A) (cadr A))
                     (inc 'D) )
                  (and
                     (find
                        '((L) (pre? L A))
                        '((a b) (c d) (p q) (x y)) )
                     (inc 'S) )
               )
               (and
                  (>= V 3)
                  (gt0 D)
                  (=0 S)
                  (inc 'L) ) ) ) )
      L ) )
(test 2 (b5-1 "data/5-test-1.txt"))
(test 255 (b5-1 "data/5.txt"))

(de b5-accuP (Var Key Pos)
   (if (setq @@ (assoc Key (val Var)))
      (and
         (>= Pos (+ 2 (caadr @)))
         (push (cdr @@) Pos) )
      (push Var (list Key (list Pos))) ) )
(de b5-2 (F)
   (let L 0
      (in F
         (until (eof)
            (let (D NIL  R 0  Lst (line))
               (for ((I . A) Lst A (cdr A))
                  (b5-accuP 'D (list (car A) (cadr A)) I)
                  (and
                     (= (car A) (caddr A))
                     (inc 'R) ) )
               (and (find cdadr D) (gt0 R) (inc 'L)) ) ) )
      L ) )
(test 2 (b5-2 "data/5-test-2.txt"))
(test 55 (b5-2 "data/5.txt"))

# --- Day 6: Probably a Fire Hazard ---
(de b6-1 (F)
   (let G (grid 1000 1000)
      (for Col G
         (for This Col
            (=: B6-1 0) ) )
      (in F
         (until (eof)
            (let (Fun NIL  L (split (line) "," " ")  Lst)
               (case (cadadr L)
                  ("n" (one Fun))
                  ("f" (zero Fun))
                  (T (on Fun)) )
               (setq Lst
                  (mapcar
                     '((N)
                        (and (ge0 Fun) (inc 'N))
                        (inc (format (get L N))) )
                     (2 5 3 6) ) ) # X1 X2 Y1 Y2
               (with (get G (car Lst) (caddr Lst))
                  (do (inc (- (cadddr Lst) (caddr Lst)))
                     (use (This) 
                        (do (inc (- (cadr Lst) (car Lst)))
                           (=: B6-1
                              (if2 (=T Fun) (=0 (: B6-1))
                                 1
                                 0
                                 Fun
                                 Fun ) )
                           (setq This (east This)) ) )
                     (setq This (north This)) ) ) ) ) )
      (sum
         '((L)
            (cnt '((This) (=1 (: B6-1))) L) )
         G ) ) )
(test 400410 (b6-1 "data/6.txt"))

(de b6-2 (F)
   (let G (grid 1000 1000)
      (for Col G
         (for This Col
            (=: B6-2 0) ) )
      (in F
         (until (eof)
            (let (Fun NIL  L (split (line) "," " ")  Lst)
               (case (cadadr L)
                  ("n" (one Fun))
                  ("f" (zero Fun))
                  (T (on Fun)) )
               (setq Lst
                  (mapcar
                     '((N)
                        (and (ge0 Fun) (inc 'N))
                        (inc (format (get L N))) )
                     (2 5 3 6) ) ) # X1 X2 Y1 Y2
               (with (get G (car Lst) (caddr Lst))
                  (do (inc (- (cadddr Lst) (caddr Lst)))
                     (use (This)
                        (do (inc (- (cadr Lst) (car Lst)))
                           (=: B6-2
                              (case Fun
                                 (1 (+ 1 (: B6-2)))
                                 (0
                                    (if (=0 (: B6-2))
                                       0
                                       (- (: B6-2) 1) ) )
                                 (T (+ 2 (: B6-2))) ) )
                           (setq This (east This)) ) )
                     (setq This (north This)) ) ) ) ) )
      (sum
         '((L) (sum '((This) (: B6-2)) L))
         G ) ) )
(test 2000001 (b6-2 "data/6-test-2.txt"))
(test 15343601 (b6-2 "data/6.txt"))

# --- Day 7: Some Assembly Required ---
(de mod16 (N)
   (& N `(hex "FFFF")) )
(de not16 (N)
   (x| N `(hex "FFFF")) )
(setq 
   AND    &
   OR     |
   RSHIFT >>
   NOT    not16 )
(de LSHIFT (A B) # only this extend bits
   (mod16 (>> A B)) )
(setq *B7-F '(AND OR RSHIFT LSHIFT NOT))
(off *B7-R)

(de b7-parse (F)
   (make
      (in F
         (until (eof)
            (link
               (make
                  (if (= "N" (peek))
                     (link (read) (read))
                     (link (read))
                     (char)
                     (unless (= "-" (peek))
                        (yoke (read))
                        (link (read))
                        (and
                           (memq (car (made)) '(LSHIFT RSHIFT))
                           (xchg (nth (made) 2) (nth (made) 3)) )
                        (and
                           (== (car (made)) 'LSHIFT)
                           (set (cdr (made)) (- (get (made) 2))) ) ) )
                  (read)
                  (yoke (read)) ) )
            (line) ) ) ) ) 
(test
   '((x 123) (y 456) (d AND x y) (e OR x y) (f LSHIFT -2 x) 
      (g RSHIFT 2 y) (h NOT x) (i NOT y) )
   (b7-parse "data/7-test-1.txt") )

(de b7-1 (Lst)
   (cond
      ((num? Lst) Lst)
      ((atom Lst) # have to collect partial results 
         (cdr
            (if (assoc Lst *B7-R)
               @
               (accu '*B7-R Lst (b7-1 (cdr (assoc Lst *B7-D)))) ) ) )
      (T
         (if (memq (car Lst) *B7-F)
            (apply (car Lst) (mapcar b7-1 (cdr Lst)))
            (b7-1 (car Lst)) ) ) ) )

(setq *B7-D (b7-parse "data/7-test-1.txt"))
(test 72 (b7-1 'd))
(test 507 (b7-1 'e))
(test 492 (b7-1 'f))
(test 114 (b7-1 'g))
(test 65412 (b7-1 'h))
(test 65079 (b7-1 'i))
(test 123 (b7-1 'x))
(test 456 (b7-1 'y))

(off *B7-R)
(setq *B7-D (b7-parse "data/7.txt"))
(test 16076 (b7-1 'a))

# part 2
(off *B7-R)
(set (cdr (assoc 'b *B7-D)) 16076)
(test 2797 (b7-1 'a))

# --- Day 8: Matchsticks ---
(de b8-1-size (F)
   (let S 0
      (in F
         (until (eof)
            (inc 'S (size (line))) ) )
      S ) )
(test 23 (b8-1-size "data/8-test-1.txt"))

(de b8-1-mem (F)
   (let M 0
      (in F
         (until (eof)
            (char)
            (loop
               (T (= "\"" (peek)) (line))
               (inc 'M)
               (when (= "\\" (peek))
                  (char)
                  (and (= "x" (peek)) (do 2 (char))) )
               (char) ) ) )
      M ) )
(test 11 (b8-1-mem "data/8-test-1.txt"))
(test
   1333
   (- 
      (b8-1-size "data/8.txt")
      (b8-1-mem "data/8.txt") ) )

# part 2
(de b8-2-q (F)
   (let Q 0
      (in F
         (until (eof)
            (for (L (cdr (line)) (cdr L) (cdr L))
               (inc
                  'Q
                  (if 
                     (or
                        (= "\\" (car L))
                        (= "\"" (car L)))
                     2 
                     1 ) ) )
            (inc 'Q 6) ) )
      Q ) )
(test 42 (b8-2-q "data/8-test-1.txt"))
(test 2046
   (-
      (b8-2-q "data/8.txt")
      (b8-1-size "data/8.txt") ) )

# --- Day 9: All in a Single Night ---
(de b9-list (F)
   (put 'mike 'mm 122)
   (make
      (in F
         (until (eof)
            (link
               (make
                  (link (read))
                  (read)
                  (link (read))
                  (read)
                  (link (read)) ) ) ) ) ) )
(de b9-1 (F Funz)
   (let
      (Lst (b9-list F)
         U (uniq (mapcan '((L) (head 2 L)) Lst)) )
      (mapc
         '((L)
            (put (car L) (cadr L) (caddr L))
            (put (cadr L) (car L) (caddr L)) )
         Lst )
      (Funz
         '((L)
            (let S 0
               (for (A L (cdr A) (cdr A))
                  (inc 'S (get (car A) (cadr A))) ) ) )
         (permute U) )
      (mapc wipe U)
      @@ ) )
(test 605 (b9-1 "data/9-test-1.txt" mini))
(test 207 (b9-1 "data/9.txt" mini))

# part 2
(test 982 (b9-1 "data/9-test-1.txt" maxi))
(test 804 (b9-1 "data/9.txt" maxi))

# --- Day 10: Elves Look, Elves Say ---
# http://rosettacode.org/wiki/Look-and-say_sequence#PicoLisp
(de las (Lst)
   (make
      (while Lst
         (let (N 1  C)
            (while (= (setq C (pop 'Lst)) (car Lst))
               (inc 'N) )
            (link N C) ) ) ) )
(de b10-1 (Lst N)
   (do N
      (setq Lst (las Lst)) )
   (length Lst) )
(test 329356  (b10-1 (3 1 1 3 3 2 2 1 1 3) 40))
(test 4666278 (b10-1 (3 1 1 3 3 2 2 1 1 3) 50))

# --- Day 11: Corporate Policy ---
(de b11-req1 (Lst) # original
   (let L Lst
      (loop
         (NIL (cddr L))
         (T
            (=
               (car L)
               (+ (cadr L) 1)
               (+ (caddr L) 2) )
            T )
         (++ L) ) ) )
(de b11-req2 (Lst)
   (nor
      (member 105 Lst)
      (member 108 Lst)
      (member 111 Lst) ) )
(de b11-req3 (Lst)
   (let D NIL
      (for ((I . L) Lst (cdr L) (cdr L))
         (and
            (= (car L) (cadr L))
            (<> (car L) (car D))
            (push 'D (car L)) ) )
      (and D (cdr D) (not (cddr D))) ) )
(de b11-1 (Str)
   (let Lst (mapcar char (flip (chop Str)))
      (until (and (b11-req1 Lst) (b11-req2 Lst) (b11-req3 Lst))
         (let C T
            (for (L Lst  (and L C)  (cdr L))
               (inc L)
               (if (>= 122 (car L))
                  (off C)
                  (set L 97) ) ) ) )
      (pack (mapcar char (flip Lst))) ) )
(test "abcdffaa" (b11-1 "abcdefgh"))
(test "ghjaabcc" (b11-1 "ghijklmn"))
(test "hepxxyzz" (b11-1 "hepxcrrq"))

# part 2
(test "heqaabcc" (b11-1 "hepxxzaa")) # manual step

# --- Day 12: JSAbacusFramework.io ---
(de b12-1 (F)
   (in F
      (let Lst (chop (line T) "_")
         (sum
            format
            (apply
               split
               (diff
                  Lst
                  '`(chop "1234567890-") )
               Lst ) ) ) ) )
(test 18 (b12-1 "data/12-test-1.txt"))
(test 119433 (b12-1 "data/12.txt"))

# part 2 - solution by @joebo
(de b12-noRed (X)
   (not 
      (match
         (list '@X ~(chop ":\"red\"") '@Y)
         X ) ) )
(de b12-parse (Input)
   (let (Input (list Input)  C)
      (recur NIL
         (make
            (while
               (and 
                  (setq C (pop Input))
                  (<> "}" C)
                  (<> "]" C) )
               (if (or (= C "{") (= C "["))
                  (link (recurse))
                  (link C) ) ) ) ) ) )
(de b12-filter (L)
   (recur (L)
      (make
         (for C L
            (link
               (if (not (atom C))
                  (if (b12-noRed C) (recurse C))
                  C ) ) ) ) ) )
(de b12-sumNum (Lst)
   (let Lst (fish 'atom Lst)
      (sum format (apply split (diff Lst (chop "1234567890-")) Lst)) ) )
(de b12-2 (F)
   (in F
      (b12-sumNum (b12-filter (b12-parse (line)))) ) )
(test 6 (b12-2 "data/12-test-2.txt"))
(test 4 (b12-2 "data/12-test-3.txt"))
(test 0 (b12-2 "data/12-test-4.txt"))
(test 6 (b12-2 "data/12-test-5.txt"))
(test 68466 (b12-2 "data/12.txt"))

# --- Day 13: Knights of the Dinner Table ---
(de b13-add (L)
   (and
      (cdr L)
      (inc
         'C 
         (car (rassoc (list (car L) (cadr L)) D)) ) ) )
(de b13-1 (F Part2)
   (let (D NIL  M 0  U)
      (in F
         (until (eof)
            (use (A B C)
               (setq A (read))
               (read)
               (and
                  (read)
                  (setq B
                     ((if (= "lose" @) - +) (read)) ) )
               (do 6
                  (read) )
               (char)
               (setq C (till "." T))
               (push 'D (list B A C)) )
            (line) ) )
      (setq U (uniq (mapcar cadr D)))
      (when Part2
         (for L U
            (push 'D (0 (list 'Mike L)))
            (push 'D (0 (list L 'Mike))) )
         (push 'U 'Mike) )
      (for P (permute U)
         (let (P (append P (cons (car P)))  C 0)
            (maplist b13-add P)
            (maplist b13-add (flip P))
            (and (> C M) (setq M C)) ) )
      M ) )
(test 330 (b13-1 "data/13-test-1.txt"))
(test 618 (b13-1 "data/13.txt"))
(test 601 (b13-1 "data/13.txt" T))

# --- Day 14: Reindeer Olympics ---
(setq *B14-T '((14 10 127) (16 11 162)))
(setq *B14-1
   (quote
      (22 8 165) (8 17 114) (18 6 103) (25 6 145)
      (11 12 125) (21 6 121) (18 3 50) (20 4 75) (7 20 119) ) )
(de b14-1 (Lst Secs)
   (maxi
      '((L) 
         (let
            (P (+ (cadr L) (caddr L))
               Q (/ Secs P)
               R (% Secs P) )
            (*
               (+
                  (* Q (cadr L))
                  (min R (cadr L)) )
               (car L) ) ) )
      Lst )
   @@ )
(test 1120 (b14-1 *B14-T 1000))
(test 2696 (b14-1 *B14-1 2503))
   
(de b14-2 (Lst Secs)
   (let
      (N -1 
         Tots (need (length Lst) 0)
         Maxs (need (length Lst) 0) )
      (while (> Secs (inc 'N))
         (maplist
            '((A B)
               (and
                  (>
                     (cadar A)
                     (% N (+ (cadar A) (caddar A))) )
                  (inc B (caar A)) ) )
            Lst
            Tots )
         (setq M (apply max Tots))
         (maplist
            '((A B)
               (and (= M (car A)) (inc B)) )
            Tots
            Maxs ) )
      (apply max Maxs) ) )
(test 689 (b14-2 *B14-T 1000))
(test 1084 (b14-2 *B14-1 2503))

# --- Day 15: Science for Hungry People ---
(setq *B15-T-1 '((-1 -2 6 3) (2 3 -2 -1)))
(setq *B15-T-2 '((-1 -2 6 3 8) (2 3 -2 -1 3)))
(setq *B15-1
   (quote 
      (4 -2 0 0) (0 5 -1 0)
      (-1 0 5 0) (0 0 -2 2) ) )
(setq *B15-2
   (quote 
      (4 -2 0 0 5) (0 5 -1 0 8)
      (-1 0 5 0 6) (0 0 -2 2 1) ) )

(de b15-partitions (N K)
   (if (> K 1)
      (mapcan
         '((X)
            (mapcar
               '((Y) (cons X Y))
               (b15-partitions (- N X) (dec K)) ) )
         (range 1 (- N (dec K))) )
      (cons (cons N)) ) )
(de b15-1 (Lst)
   (let Lst (apply mapcar Lst list)
      (maxi
         '((L)
            (apply
               *
               (mapcar
                  '((X)
                     (if (gt0 (sum * X L)) @ 0) )
                  Lst ) ) )
         (b15-partitions 100 (length (car Lst))) )
      @@ ) )
(test 62842880 (b15-1 *B15-T-1))
(test 18965440 (b15-1 *B15-1))

(de b15-2 (Lst)
   (let Lst (apply mapcar Lst list)
      (maxi
         '((L) (apply * L))
         (mapcan
            '((L)
               (let L (mapcar '((X) (sum * X L)) Lst)
                  (and
                     (= 500 (get L 5))
                     (cons (head 4 L)) ) ) )
               (b15-partitions 100 (length (car Lst))) ) )
      @@ ) )
(test 57600000 (b15-2 *B15-T-2))
(test 15862900 (b15-2 *B15-2))

# --- Day 16: Aunt Sue ---
(setq *B16-D
   (quote
      (children . 3) (cats . 7) (samoyeds . 2) (pomeranians . 3) 
      (akitas . 0) (vizslas . 0) (goldfish . 5) (trees . 3)
      (cars . 2) (perfumes . 1) ) )

(de b16-1 (F)
   (let Aunts
      (in F
         (make
            (until (eof)
               (let L
                  (filter
                     prog
                     (cdr (mapcar pack (split (line) "," ":" " "))) )
                  (link
                     (make
                        (link (format (++ L))) 
                        (do 3
                           (link (cons (++ L) (format (++ L)))) ) ) ) ) ) ) )
      (and
         (find
            '((A)
               (fully '((Z) (member Z *B16-D)) (cdr A)) )
            Aunts )
         (car @) ) ) )
(test 373 (b16-1 "data/16.txt"))

(de b16-2 (F)
   (let Aunts
      (in F
         (make
            (until (eof)
               (let L
                  (filter
                     prog
                     (cdr (mapcar pack (split (line) "," ":" " "))) )
                  (link
                     (make
                        (link (format (++ L)))
                        (do 3
                           (link (cons (++ L) (format (++ L)))) ) ) ) ) ) ) )
      (and
         (find
            '((A)
               (fully
                  '((Z)
                     (let X (cdr (assoc (car Z) *B16-D))
                        (case (car Z)
                           (("trees" "cats") (> (cdr Z) X))
                           (("pomeranians" "goldfish") (> X (cdr Z)))
                           (T (= (cdr Z) X)) ) ) )
                  (cdr A) ) )
            Aunts )
         (car @) ) ) )
(test 260 (b16-2 "data/16.txt"))

# --- Day 17: No Such Thing as Too Much --- 
(de b17-1 (Lst N)
   (let D (conc (cons 1) (need N 0))
      (for A Lst
         (for (B (inc N) (>= B A) (dec B))
            (inc
               (nth D B)
               (car (nth D (- B A))) ) ) )
      (last D) ) )
(test 4 (b17-1 (5 5 10 15 20) 25))
(test 
   654 
   (b17-1 
      (50 44 11 49 42 46 18 32 26 40 21 7 18 43 10 47 36 24 22 40) 
      150) )

# --- Day 18: Like a GIF For Your Yard ---
(de b18-1 (F Steps)
   (let
      (Lst (make (in F (until (eof) (link (line)))))
         Grid (grid (length (car Lst)) (length Lst)) )
      (mapc
         '((G L) 
            (mapc 
               '((This Val)
                  (and (= "#" Val) (=: Led T)) )
               G
               L ) )
         Grid
         Lst )
      (do Steps
         (let Lst
            (mapcar
               '((G)
                  (mapcar
                     '((This)
                        (let C
                           (cnt
                              '((D) (with (D This) (: Led)))
                              '(west east south north
                                 ((X) (south (west X)))
                                 ((X) (north (west X)))
                                 ((X) (south (east X)))
                                 ((X) (north (east X))) ) )
                           (if (: Led)
                              (or (= 2 C) (= 3 C))
                              (and (= 3 C)) ) ) )
                     G ) )
               Grid )
            (mapc
               '((G L)
                  (mapc '((This V) (=: Led V)) G L))
               Grid
               Lst ) ) )
      (sum
         '((G) (cnt '((This) (: Led)) G))
         Grid ) ) )
(test 4 (b18-1 "data/18-test-1.txt" 4))
(test 768 (b18-1 "data/18.txt" 100))

(de b18-2 (F Steps)
   (let
      (Lst (make (in F (until (eof) (link (line)))))
         Grid (grid (length (car Lst)) (length Lst))
         Crnrs
         (list 
            (caar Grid) 
            (last (car Grid))
            (car (last Grid))
            (last (last Grid)) ) )
      # zeroize Led prop 
      (mapc
         '((G)
            (mapc '((This) (=: Led NIL)) G) )
         Grid )
      (mapc
         '((G L) 
            (mapc 
               '((This Val)
                  (and (= "#" Val) (=: Led T)) )
               G
               L ) )
         Grid
         Lst )
      (do Steps
         (let Lst
            (mapcar
               '((G)
                  (mapcar
                     '((This)
                        (let C
                           (cnt
                              '((D) (with (D This) (: Led)))
                              '(west east south north
                                 ((X) (south (west X)))
                                 ((X) (north (west X)))
                                 ((X) (south (east X)))
                                 ((X) (north (east X))) ) )
                           (or 
                              (memq This Crnrs)
                              (if (: Led)
                                 (or (= 2 C) (= 3 C))
                                 (and (= 3 C)) ) ) ) )
                     G ) )
               Grid )
            (mapc
               '((G L)
                  (mapc '((This V) (=: Led V)) G L))
               Grid
               Lst ) ) )
      (sum
         '((G) (cnt '((This) (: Led)) G))
         Grid ) ) )
(test 17 (b18-2 "data/18-test-2.txt" 5))  
(test 781 (b18-2 "data/18.txt" 100))  

# --- Day 19: Medicine for Rudolph ---
(setq *D19-T
   (quote
      ("H" . "HO")
      ("H" . "OH")
      ("O" . "HH") ) )
(setq *D19-1
   (quote
      ("Al" . "ThF") ("Al" . "ThRnFAr") ("B" . "BCa") ("B" . "TiB") ("B" . "TiRnFAr")
      ("Ca" . "CaCa") ("Ca" . "PB") ("Ca" . "PRnFAr") ("Ca" . "SiRnFYFAr") ("Ca" . "SiRnMgAr")
      ("Ca" . "SiTh") ("F" . "CaF") ("F" . "PMg") ("F" . "SiAl") ("H" . "CRnAlAr") ("H" . "CRnFYFYFAr")
      ("H" . "CRnFYMgAr") ("H" . "CRnMgYFAr") ("H" . "HCa") ("H" . "NRnFYFAr") ("H" . "NRnMgAr")
      ("H" . "NTh") ("H" . "OB") ("H" . "ORnFAr") ("Mg" . "BF") ("Mg" . "TiMg") ("N" . "CRnFAr")
      ("N" . "HSi") ("O" . "CRnFYFAr") ("O" . "CRnMgAr") ("O" . "HP") ("O" . "NRnFAr") ("O" . "OTi")
      ("P" . "CaP") ("P" . "PTi") ("P" . "SiRnFAr") ("Si" . "CaSi") ("Th" . "ThCa") ("Ti" . "BP")
      ("Ti" . "TiTi") ) )
(de b19-helper1 (Lst)
   (let Len (length Lst)
      (make
         (for (N 1 (>= Len N))
            (link
               (mapcar 
                  pack
                  (if (<= `(char 'A) (char (get Lst (inc N))) `(char 'Z))
                     (list
                        (get Lst N)
                        (head (dec N) Lst)
                        (nth Lst (inc 'N)) )
                     (list
                        (head 2 (nth Lst N))
                        (head (dec N) Lst)
                        (nth Lst (inc 'N 2)) ) ) ) ) ) ) ) )
(de b19-1 (Lst D)
   (let Lst (chop Lst)
      (length
         (uniq
            (mapcan
               '((A)
                  (mapcar
                     '((C)
                        (pack (cadr A) (cdr C) (caddr A)) )
                     (filter
                        '((B) (= (car A) (car B)))
                        D ) ) )
               (b19-helper1 Lst) ) ) ) ) )
(test
   '(("H" NIL "OH") ("O" "H" "H") ("H" "HO" NIL))
   (b19-helper1 (chop "HOH")) )
(test
   '(("H" NIL "OHOHO") ("O" "H" "HOHO") ("H" "HO" "OHO") ("O" "HOH" "HO") ("H" "HOHO" "O") ("O" "HOHOH" NIL))
   (b19-helper1 (chop "HOHOHO")) )
(test
   '(("Mi" NIL "Ke") ("Ke" "Mi" NIL))
   (b19-helper1 (chop "MiKe")) )
(test
   '(("M" NIL "IKe") ("I" "M" "Ke") ("Ke" "MI" NIL))
   (b19-helper1 (chop "MIKe")) )
(test
   '(("M" NIL "KeI") ("Ke" "M" "I") ("I" "MKe" NIL))
   (b19-helper1 (chop "MKeI")) )

(test 4 (b19-1 "HOH" *D19-T))
(test 7 (b19-1 "HOHOHO" *D19-T))
(test 535 (b19-1 "CRnCaCaCaSiRnBPTiMgArSiRnSiRnMgArSiRnCaFArTiTiBSiThFYCaFArCaCaSiThCaPBSiThSiThCaCaPTiRnPBSiThRnFArArCaCaSiThCaSiThSiRnMgArCaPTiBPRnFArSiThCaSiRnFArBCaSiRnCaPRnFArPMgYCaFArCaPTiTiTiBPBSiThCaPTiBPBSiRnFArBPBSiRnCaFArBPRnSiRnFArRnSiRnBFArCaFArCaCaCaSiThSiThCaCaPBPTiTiRnFArCaPTiBSiAlArPBCaCaCaCaCaSiRnMgArCaSiThFArThCaSiThCaSiRnCaFYCaSiRnFYFArFArCaSiRnFYFArCaSiRnBPMgArSiThPRnFArCaSiRnFArTiRnSiRnFYFArCaSiRnBFArCaSiRnTiMgArSiThCaSiThCaFArPRnFArSiRnFArTiTiTiTiBCaCaSiRnCaCaFYFArSiThCaPTiBPTiBCaSiThSiRnMgArCaF" *D19-1))

# part2
(de b19-helper2 (Lst)
   (make
      (for (L Lst L)
         (link
            (pack
               (if (<= `(char 'A) (char (cadr L)) `(char 'Z))
                  (++ L)
                  (list (++ L) (++ L)) ) ) ) ) ) )
(test '("H" "O" "H") (b19-helper2 (chop "HOH")))
(test '("Mi" "K" "E") (b19-helper2 (chop "MiKE")))
(test '("Mi" "Ke") (b19-helper2 (chop "MiKe")))
(test '("M" "Ke") (b19-helper2 (chop "MKe")))

(de b19-2 (Lst)
   (let Lst (b19-helper2 (chop Lst))
      (dec
         (-
            (length Lst)
            (+ 
               (cnt '((L) (= (car L) "Rn")) Lst)
               (cnt '((L) (= (car L) "Ar")) Lst) )
            (*
               2 
               (cnt '((L) (= (car L) "Y")) Lst) ) ) ) ) )
(test 212 (b19-2 "CRnCaCaCaSiRnBPTiMgArSiRnSiRnMgArSiRnCaFArTiTiBSiThFYCaFArCaCaSiThCaPBSiThSiThCaCaPTiRnPBSiThRnFArArCaCaSiThCaSiThSiRnMgArCaPTiBPRnFArSiThCaSiRnFArBCaSiRnCaPRnFArPMgYCaFArCaPTiTiTiBPBSiThCaPTiBPBSiRnFArBPBSiRnCaFArBPRnSiRnFArRnSiRnBFArCaFArCaCaCaSiThSiThCaCaPBPTiTiRnFArCaPTiBSiAlArPBCaCaCaCaCaSiRnMgArCaSiThFArThCaSiThCaSiRnCaFYCaSiRnFYFArFArCaSiRnFYFArCaSiRnBPMgArSiThPRnFArCaSiRnFArTiRnSiRnFYFArCaSiRnBFArCaSiRnTiMgArSiThCaSiThCaFArPRnFArSiRnFArTiTiTiTiBCaCaSiRnCaCaFYFArSiThCaPTiBPTiBCaSiThSiRnMgArCaF"))

# --- Day 20: Infinite Elves and Infinite Houses ---
(de b20-sigma-1 (N)
   (let S 0
      (for A (/ N 2)
         (and (=0 (% N A)) (inc 'S A)) )
      (inc 'S N) ) )
(test 3599232 (b20-sigma-1 1234500))

(de b20-sigma-2 (N)
   (let S 0
      (for A (/ N 2)
         (and
            (=0 (% N A))
            (>= 50 (/ N A))
            (inc 'S A) ) )
      (inc 'S N) ) )
(test 3510095 (b20-sigma-2 1234500))

(de b20-1 (N)
   (let (Trg (/ N 10)  R 180)
      (while (> Trg (b20-sigma-1 R))
         (inc 'R 180) )
      R ) )
(test 776160 (b20-1 33100000))

(de b20-2 (N)
   (let (Trg (/ N 11)  R 180)
      (while (> Trg (b20-sigma-2 R))
         (inc 'R 180) )
      R ) )
(test 786240 (b20-2 33100000))


# --- Day 21: RPG Simulator 20XX ---

# --- Day 22: Wizard Simulator 20XX ---

# --- Day 23: Opening the Turing Lock ---
(de b23-1 (F a b)
   (default a 0  b 0)
   (let
      (I 1
         C
         (in F
            (make
               (until (eof)
                  (link (make (until (eol) (link (read)))))
                  (line) ) ) )
         Len (length C) )
      (while (and (>= Len I) (setq @@ (get C I)))
         (case (car @@)
            (inc (inc (cadr @@)) (inc 'I))
            (jio 
               (if (=1 (eval (cadr @@))) 
                  (inc 'I (caddr @@))
                  (inc 'I 1) ) )
            (jie
               (ifn (bit? 1 (eval (cadr @@)))
                  (inc 'I (caddr @@))
                  (inc 'I 1) ) )
            (tpl 
               (set (setq @ (cadr @@)) 
                  (* 3 (eval @)) )
               (inc 'I) )
            (hlf
               (set (setq @ (cadr @@)) 
                  (/ (eval @) 2) )
               (inc 'I) )
            (jmp (inc 'I (cadr @@))) ) )
      (cons a b) ) )
(test (2 . 0) (b23-1 "data/23-test-1.txt"))
(test (1 . 170) (b23-1 "data/23.txt"))

# part 2
(test (1 . 247) (b23-1 "data/23.txt" 1))

# --- Day 24: It Hangs in the Balance ---

# --- Day 25: Let It Snow ---
(de b25-1 (R C)
   (let
      (N 20151125
         I
         (inc
            (- 
               (/ 
                  (* (+ R (dec C)) (+ R C)) 
                  2 )
               R ) ) )
      (do (dec I)
         (setq N (% (* N 252533) 33554393)) )
      N ) )
(test 19980801 (b25-1 2947 3029))

(msg 'OK-AoC15)
