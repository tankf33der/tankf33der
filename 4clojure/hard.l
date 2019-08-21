# 53 Longest Increasing Sub-Seq
(de f53 (Lst)
   (maxi 
      length
      (filter
         '((I) (and (car I) (cdr I)))
         (maplist
            '((L)
               (make
                  (link (car L))
                  (for I (cdr L)
                     (NIL (= 1 (- I (last (made)))))
                     (link I) ) ) )
            Lst ) ) ) )
(test
   (0 1 2 3)
   (f53 (1 0 1 2 3 0 4 5)) )
(test
   (5 6)
   (f53 (5 6 1 3 2 7)) )
(test
   (3 4 5)
   (f53 (2 3 3 4 5)) )
(test
   NIL
   (f53 (7 6 5 4)) )

#73 Analyze a Tic-Tac-Toe Board
(de f73 (Lst)
   (pick
      '((L)
         (and
            (or 
               (apply = L 'x)
               (apply = L 'o) )
            (car L) ) ) 
      (list
         (car Lst)
         (cadr Lst)
         (caddr Lst)
         (mapcar car Lst)
         (mapcar cadr Lst)
         (mapcar caddr Lst)
         (mapcar get Lst (1 2 3))
         (mapcar get Lst (3 2 1)) ) ) )
(test
   NIL      
   (f73 '((e e e)
          (e e e)
          (e e e) ) ) )
(test
   'x
   (f73 '((x e o)
          (x e e)
          (x e o) ) ) )
(test
   'o
   (f73 '((e x e)
          (o o o)
          (x e x) ) ) )
(test
   NIL
   (f73 '((x e o)
          (x x e)
          (o x o) ) ) )
(test
   'x
   (f73 '((x e e)
          (o x e)
          (o e x) ) ) )
(test
   'o
   (f73 '((x e o)
          (x o e)
          (o e x) ) ) )
(test
   NIL
   (f73 '((x o x)
          (x o x)
          (o x o) ) ) )

#92 Read Roman numerals
(de f92 (Rom)
   (let L (replace (chop Rom) 'M 1000 'D 500 'C 100 'L 50 'X 10 'V 5 'I 1)
      (sum '((A B) (if (>= A B) A (- A))) L (cdr L)) ) )
(test
   14
   (f92 "XIV") )
(test
   827
   (f92 "DCCCXXVII") )
(test
   3999
   (f92 "MMMCMXCIX") )
(test
   48
   (f92 "XLVIII") )

#79 Triangle Minimal Path
# reduce from task 64 (elementary.l)
(de f79 (Lst)
   (car
      (reduce
         '((X Y)
            (mapcar
               +
               (maplist
                  '((L)
                     (and (cdr L) (min (car L) (cadr L))) )
                  X )
               Y ) )
         (reverse Lst) ) ) )
(test
   7
   (f79
      '((1)
      (2 4)
      (5 1 4)
      (2 3 4 5) ) ) )
(test
   20
   (f79
      '((3)
      (2 4)
      (1 9 3)
      (9 9 2 4)
      (4 6 6 7 8)
      (5 7 3 5 1 4) ) ) )

#84 Transitive Closure
(de f84 (Lst)
   (make
      (for I Lst
         (link I)
         (when (assoc (cdr I) Lst)
            (link
               (cons (car I) (cdr @)) ) ) ) ) ) 
(test
   '((8 . 4) (8 . 2) (9 . 3) (4 . 2) (27 . 9) (27 . 3)) 
   (f84 '((8 . 4) (9 . 3) (4 . 2) (27 . 9))) )

#91 Graph Connectivity
(de f91 (Lst)
   (let (X (caar Lst)  R)
      (not
         (diff 
            (uniq (fish atom Lst))
            (recur (X)
               (cond
                  ((not X))
                  ((lst? X)
                     (recurse (car X))
                     (recurse (cdr X)) )
                  (T (push 'R X)
                     (when 
                        (extract
                           '((I)
                              (let Y
                                 (cond
                                    ((= (car I) X) (cadr I))
                                    ((= (cadr I) X) (car I)) )
                                 (unless (member Y R) Y) ) )
                              Lst ) 
                        (recurse @) ) ) )
               R ) ) ) ) )
(test
   T
   (f91 '((a a))) )
(test
   T
   (f91 '((a b))) )
(test
   NIL
   (f91 '((1 2) (2 3) (3 1) (4 5) (5 6) (6 4))) )
(test
   T
   (f91 '((1 2) (2 3) (3 1) (4 5) (5 6) (6 4) (3 4))) )
(test
   NIL
   (f91 '((:a :b) (:b :c) (:c :d) (:x :y) (:d :a) (:b :e))) )
(test
   T
   (f91 '((:a :b) (:b :c) (:c :d) (:x :y) (:d :a) (:b :e) (:x :a))) )

#82 Word Chains
(de antidup @
# remove fatal duplicates
# input: two lists
# output:
# ((("s" "i" "o" "t") . 4) (("p" "o" "t") . 3))
# longest always first
   (let R
      (mapcar
         '((L)
            (let Y NIL
               (for I L
                  (accu 'Y I 1) )
               (setq Y
                  (make
                     (for I Y
                        (chain (need (% (cdr I) 2) (car I))) ) ) )
               (cons Y (length Y)) ) )
         (rest) )
      (when (<= (cdar R) (cdadr R))
         (xchg R (cdr R)) )
      R ) )
(de f82 (Lst)
   (let (L Lst  P NIL)
      (sym? 
         (recur (L)
            (if (cdr L)
               (do (length L)
                  (T (= 'chain (recurse (cdr L))) 'chain)
                  (rot L) )
               (for (L1 Lst (cdr L1) (cdr L1))
                  (setq P
                     (antidup (chop (car L1)) (chop (cadr L1))) )
                  (NIL
                     (and
                        (>= 1 (- (cdar P) (cdadr P)))
                        (= 
                           1
                           (cnt
                              '((I) (not (member I (caadr P))))
                              (caar P) ) ) ) )
                  'chain ) ) ) ) ) )
(test
   T
   (f82 '(hat coat dog cat oat cot hot hog)) )
(test
   NIL
   (f82 '(cot hot bat fat)) )
(test
   NIL
   (f82 '(to top stop tops toss)) )
(test
   T
   (f82 '(spout do pot pout spot dot)) )
(test
   T
   (f82 '(share hares shares hare are)) )
(test
   NIL
   (f82 '(share hares hare are)) )

#94 Game of Life
(de f94 (Lst)
   (let 
      (Lst (mapcar chop Lst) 
         Grid (grid (length (car Lst)) (length Lst)) )
      (mapc
         '((G L)
            (mapc '((This) (=: life NIL)) G)
            (mapc
               '((This Val)
                  (when (= 'X Val) (=: life T)) )
               G 
               L ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (for Col Grid
         (for This Col
            (let N
               (cnt
                  '((Dir) (get (Dir This) 'life))
                  (quote
                     west east south north
                     ((X) (south (west X)))
                     ((X) (north (west X)))
                     ((X) (south (east X)))
                     ((X) (north (east X))) ) )
               (=: next
                  (if (: life)
                     (>= 3 N 2)
                     (= N 3) ) ) ) ) )
         (for Col Grid
            (for This Col
               (=: life (: next)) ) )
      (mapcar
         '((L)
            (pack 
               (mapcar
                  '((This) (if (: life) 'X " ") )
                  L ) ) )
         (reverse (apply mapcar Grid list)) ) ) )
(test
   '("      "
     " XX   " 
     " X    " 
     "    X " 
     "   XX " 
     "      " )
   (f94 
      '("      "
        " XX   "
        " XX   "
        "   XX "
        "   XX "
        "      " ) ) )
(test
   '("     " 
     "  X  "
     "  X  "
     "  X  "
     "     " )
  (f94
      '("     "
        "     "
        " XXX "
        "     "
        "     " ) ) )
(test
   '("      " 
     "   X  "
     " X  X "
     " X  X "
     "  X   "
     "      " )
   (f94
      '("      "
        "      "
        "  XXX "
        " XXX  "
        "      "
        "      " ) ) ) 

#106 Number Maze
(de f106 (X Y)
   (let (R (list X)  C 1)
      (until (member Y R) 
         (setq R 
            (mapcan
               '((I)
                  (cons
                     (* 2 I)
                     (+ 2 I)
                     (unless (bit? 1 I) (cons (/ I 2))) ) )
               R ) )
         (inc 'C) )
      C ) )
(test
   1
   (f106 1 1) )
(test
   3
   (f106 3 12) )
(test
   3
   (f106 12 3) )
(test
   3
   (f106 5 9) )
(test
   9
   (f106 9 2) )
(test
   5
   (f106 9 12) )

#101 Levenshtein Distance
(de f101 (A B)
   (default
      A (need (length B)) 
      B (need (length A)) )
   (let D
      (cons
         (range 0 (length A))
         (mapcar
            '((I) (cons I (copy A)))
            (range 1 (length B)) ) )
      (map
         '((B Y)
            (map
               '((A X P)
                  (set (cdr P)
                     (if (= (car A) (car B))
                        (car X)
                        (inc (min (cadr X) (car P) (car X))) ) ) )
               A
               (car Y)
               (cadr Y) ) )
         B
         D ) ) )
(test
   3
   (f101 (chop "kitten") (chop "sitting")) )
(test
   (f101 (chop "clojure") (chop "closure"))
   (f101 (chop "closure") (chop "clojure")) )
(test
   10
   (f101 (chop "ttttattttctg") (chop "tcaaccctaccat")) )
(test
   (f101 (chop "123") (chop ""))
   (f101 (chop "") (chop "abc")) )

#89 Graph Tour
# Eulerian path
(de accul (Var Key Flag)
   (if (assoc Key (val Var))
      (con @ (list (inc (cdr @)) (caddr @)))
      (push Var (list Key 1 0)) )
   (and
      Flag
      (assoc Key (val Var))
      (con @ (list (cadr @) (inc (caddr @)))) ) )
(de f89 (Lst)
   (use R
      (for L Lst
         (if (= (car L) (cadr L))
            (accul 'R (car L))
            (accul 'R (car L) T)
            (accul 'R (cadr L) T) ) )
      (bool
         (and
            (=0 
               (cnt '((L) (= 0 (caddr L))) R))
            (let X (cnt '((L) (bit? 1 (cadr L))) R)
               (or (=0 X) (= 2 X)) ) ) ) ) )
(test
   T
   (f89 '((:a :b))) )
(test
   NIL
   (f89 '((:a :a) (:b :b))) )
(test
   NIL
   (f89 '((:a :b) (:a :b) (:a :c) (:c :a)
      (:a :d) (:b :d) (:c :d) ) ) )
(test
   T
   (f89 '((1 2) (2 3) (3 4) (4 1))) )
(test
   T
   (f89 '((:a :b) (:a :c) (:c :b) (:a :e)
      (:b :e) (:a :d) (:b :d) (:c :e) 
      (:d :e) (:c :f) (:d :f) ) ) )
(test
   NIL
   (f89 '((1 2) (2 3) (2 4) (2 5))) )

#119 Win at Tic-Tac-Toe
(de f119 (Lst)
   (let (Grid (grid 3 3))
      (mapc
         '((G L S)
            (mapc 
               '((This Val C) 
                  (=: V Val) 
                  (=: P (list C S)) )
               G 
               L
               (2 1 0) ) )
         Grid
         (apply mapcar (reverse Lst) list)
         (0 1 2) )
      (extract
         '((L)
            (use (R E)
               (for This L
                  (if (= 'e (: V))
                     (push 'E (: P))
                     (accu 'R (: V) 1) ) )
               (and
                  (and (car R) (not (cdr R)))
                  (and (car E) (not (cdr E)))
                  (car E) ) ) )
         (quote
            (a1 b1 c1)
            (a2 b2 c2)
            (a3 b3 c3)
            (a1 a2 a3)
            (b1 b2 b3)
            (c1 c2 c3)
            (a1 b2 c3)
            (c1 b2 a3) ) ) ) )
(test
   '((2 2) (0 1) (0 2))
   (f119
      '((o e e)
        (o x o)
        (x x e) ) ) )
(test
   '((1 2) (2 0) (2 2))
   (f119
      '((x o o)
        (x x e) 
        (e o e) ) ) )
(test
   '((0 1) (2 0) (2 2))
   (f119
      '((x e x)
        (o x o)
        (e o e) ) ) )
 (test
   NIL
   (f119
      '((x x o)
        (e e e)
        (e e e) ) ) )
 (test
   '((1 1) (2 2))
   (f119
      '((x x o)
        (o e o)
        (x e e) ) ) )
 
#117 For Science!
(de f117 (Lst)
   (let
      (Lst (mapcar chop Lst)
      Grid (grid (length (car Lst)) (length Lst))
      M NIL  C NIL  F NIL)
      (mapc
         '((G L)
            (mapc
               '((This Val)
                  (cond
                     ((= 'M Val) (setq M This))
                     ((= 'C Val) (setq C This))
                     # reimplement for humans
                     ((= "#" Val)
                        (with (: 0 1 1) (con (: 0 1)))    # W
                        (with (: 0 1 -1) (set (: 0 1)))   # E
                        (with (: 0 -1 1) (con (: 0 -1)))  # S
                        (with (: 0 -1 -1) (set (: 0 -1))) # N
                        (set This) ) ) )
               G 
               L ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (with M 
         (recur (This)
            (when (and This (not (: visit)))
               (if (= C This)
                  (on F)
                  (=: visit T)
                  (recurse (west This))
                  (recurse (east This))
                  (recurse (south This))
                  (recurse (north This))
                  (=: visit NIL) ) ) ) )
      F ) )
(test
   T
   (f117 
      '("M   C") ) )
(test
   NIL 
   (f117 
      '("M # C") ) )
(test
   T
   (f117
      '("#######"
        "#  #  #"
        "#     #"
        "#M # C#"
        "#######" ) ) )
(test
   NIL
   (f117
      '("########"
        "#M  #  #"
        "#   #  #"
        "# # #  #"
        "#   #  #"
        "#  #   #"
        "#  # # #"
        "#  #   #"
        "#  #  C#"
        "########" ) ) )
(test
   NIL
   (f117
      '("M     "
        "      "
        "      "
        "      "
        "    ##"
        "    #C" ) ) ) 
(test
   T
   (f117
      '("C######"
        " #     "
        " #   # "
        " #   #M"
        "     # " ) ) )
(test
   T
   (f117
      '("C######"
        " #     "
        " #   # "
        " #   #M"
        "     # " ) ) )

#111 Crossword puzzle
(de f111 (Str Lst)
   (setq Str (chop Str))
   (pick
      '((Pat)
         (and
            (= (length Str) (length Pat))
            (fully
               '((S P) (or (= "_" P) (= S P)))
               Str
               Pat ) ) )
      (mapcan
         '((L) (split L "#"))
         (conc
            (setq Lst (mapcar chop Lst))
            (apply mapcar (mapcar chop Lst) list) ) ) ) )
(test 
   T
   (f111 "the" '("_#__e")) )
(test 
   NIL
   (f111
      "the"
      '("c___"
        "d_#e"
        "ry__" ) ) )
(test 
   T
   (f111
      "joy"
      '("c___"
        "d_#e"
        "ry__" ) ) )
(test
   NIL
   (f111 
      "joy" 
      '("conj"
        "__y_"
        "r__#" ) ) )
(test
   T
   (f111 
      "clojure" 
      '("___#joy"
        "__o____"
        "__f_#__" ) ) )

#130 Tree reparenting
(de f130 (N Lst)
   (let 
      (R (car (fish '((X) (member N X)) Lst))
         A 
         (delete 
            R 
            (car (fish '((X) (member R X)) Lst)) )
         B 
         (filter
            '((X) 
               (not (fish '((X) (= X N)) X)) ) 
            Lst ) )
      (append
         R
         (and A B (cons (conc A (cons B)))) ) ) )
(test
  '(d (b (c) (e) (a (f (g) (h)))))
   (f130 'd '(a (b (c) (d) (e)) (f (g) (h)))) )
(test
   '(c (d) (e) (b (f (g) (h)) (a (i (j (k) (l)) (m (n) (o))))))
   (f130 'c '(a (b (c (d) (e)) (f (g) (h))) (i (j (k) (l)) (m (n) (o))))) )
(test
   '(n)
   (f130 'n '(n)) )
(test
   '(a (b (c)))
   (f130 'a '(c (b (a)))) )

#124 Analyze Reversi
(de f124 (Lst N)
   (let (Grid (grid 4 4)  M NIL)
      (mapc
         '((G L S)
            (mapc
               '((This Val C) 
                  (and
                     (=: V Val)
                     (=: P (list C S)) 
                     (= N Val)
                     (push 'M This) ) )
               G 
               L
               (3 2 1 0) ) )
         Grid
         (apply mapcar (reverse Lst) list)
         (0 1 2 3) )
      (make
         (for S M 
            (for D 
               (quote
                  west east south north
                  ((X) (south (west X)))
                  ((X) (north (west X)))
                  ((X) (south (east X)))
                  ((X) (north (east X))) )
               (with S
                  (let P NIL
                     (loop
                        (setq This (D This))
                        (T (or (= N (: V)) (not (: V))))
                        (T (= 'e (: V))
                           (and P (link (cons (: P) P))) )
                        (and
                           (<> N (: V))
                           (<> 'e (: V))
                           (push 'P (: P)) ) ) ) ) ) ) ) ) )
(test
   '(((2 0) (2 1)) ((0 2) (1 2)) ((1 3) (1 2)) ((3 1) (2 1)))
   (f124
      (quote
         (e e e e)
         (e w b e)
         (e b w e)
         (e e e e) ) 'w ) )
(test
   '(((1 0) (1 1)) ((3 2) (2 2)) ((3 0) (2 1)))
   (f124
      (quote
         (e e e e)
         (e w b e)
         (w w w e)
         (e e e e) ) 'b ) )
(test
   '(((1 3) (1 2)) ((3 3) (2 2)) ((2 3) (2 2)) ((0 3) (1 2)))
   (f124
      (quote
         (e e e e)
         (e w b e)
         (w w b e)
         (e e b e) ) 'w ) )
(test
   '(((1 3) (1 2)) ((2 3) (2 2) (2 1)) ((0 3) (1 2) (2 1)))
   (f124
      (quote
         (e e w e)
         (b b w e)
         (b w w e)
         (b w w w) ) 'b ) )

#178 Best Hand
# easy.l #128 Recognize Playing Cards
# works after 3.1.9.10
(de f178 (Lst)
   (let (Lst (mapcar chop Lst)  S NIL  R NIL  Seq NIL)
      (for I Lst
         (accu 'S (car I) 1)
         (accu 'R (cdr (assoc (cadr I) *Rank)) 1) )
      (setq Seq
         (make
            (for (L (by car sort R) (cdr L) (cdr L))
               (link (- (caar L) (caadr L))) ) ) )
      (cond
         ((and
            (= 5 (cdar S))
            (or
               (= (-1 -1 -1 -1) Seq)
               (= (-1 -1 -1 -9) Seq) ) )
            'straight-flush )
         ((rassoc 4 R) 'four-of-a-kind)
         ((and (rassoc 2 R) (rassoc 3 R)) 'full-house)
         ((= 5 (cdar S)) 'flush)
         ((or
            (= (-1 -1 -1 -1) Seq)
            (= (-1 -1 -1 -9) Seq) )
            'straight )
         ((rassoc 3 R) 'three-of-a-kind)
         ((= 
            2 
            (cnt '((L) (= 2 (cdr L))) R) )
            'two-pair )
         ((rassoc 2 R) 'pair)
         (T 'high-card) ) ) )
(test
   'high-card
   (f178 '("HA" "D2" "H3" "C9" "DJ")) )
(test
   'pair
   (f178 '("HA" "HQ" "SJ" "DA" "HT")) )
(test
   'two-pair
   (f178 '("HA" "DA" "HQ" "SQ" "HT")) )
(test
   'three-of-a-kind
   (f178 '("HA" "DA" "CA" "HJ" "HT")) )
(test
   'straight
   (f178 '("HA" "DK" "HQ" "HJ" "HT")) )
(test
   'straight
   (f178 '("HA" "H2" "S3" "D4" "C5")) )
(test
   'flush
   (f178 '("HA" "HK" "H2" "H4" "HT")) )
(test
   'full-house
   (f178 '("HA" "DA" "CA" "HJ" "DJ")) )
(test
   'four-of-a-kind
   (f178 '("HA" "DA" "CA" "SA" "DJ")) )
(test
   'straight-flush
   (f178 '("HA" "HK" "HQ" "HJ" "HT")) )

#138 Squares Squared
(de pow (N)
   (let I 1
      (while (> N (* I I))
         (inc 'I) )
      I ) )
(de f138 (N M)
   (let 
      (A
         (mapcan
            chop
            (make
               (while (<= N M)
                  (link (prog1 N (setq N (* N N)))) ) ) )
         N (length A)
         M (pow N)
         N (+ M (dec M))
         Grid (grid N N)
         Dir 
            (circ 
               '((X) (south (east X)))
               '((X) (south (west X)))
               '((X) (north (west X)))
               '((X) (north (east X))) ) )
      (mapc # init all to NILs
         '((G)
            (mapc '((This) (=: "V" NIL)) G) )
         Grid )
      (with #find required center
         (intern
            (pack
               (char (+ 96 M)) 
               (if (bit? 1 M) M (inc M)) ) )
         (do (** M 2)
            (=: "V" (if (pop 'A) @ "*"))
            (or 
               (get ((car Dir) This) "V")
               (setq This ((car Dir) This)) )
            (with ((cadr Dir) This)
               (or (: "V") (pop 'Dir)) ) ) )
      (mapcar
         '((L)
            (pack 
               (mapcar
                  '((This) (if (: "V") @ " ") )
                  L ) ) )
         (reverse (apply mapcar Grid list)) ) ) )
(test
   '("2")
   (f138 2 2) )
(test
   (quote
      " 2 "
      "* 4"
      " * " )
   (f138 2 4) )
(test
   (quote
      " 3 "
      "1 9"
      " 8 " )
   (f138 3 81) )
(test
   (quote
      "  6  "
      " 5 * " 
      "2 2 *" 
      " 6 4 " 
      "  1  " )
   (f138 2 256) )
(test
   (quote
      "   0   "
      "  1 0  "
      " 0 1 0 "
      "* 0 0 0"
      " * 1 * "
      "  * *  "
      "   *   " )
   (f138 10 10000) )

#164 Language of a DFA

#127 Love Triangle
(de countT (S E D)
   (let C 0
      (with S
         (loop
            (NIL (: one))
            (inc 'C)
            (T (== This E) C)
            (setq This (D This)) ) ) ) )
(de f127 (Lst)
   (let
      (Lst (mapcar bin Lst) 
         Max (prog (maxi length Lst) @@)
         Lst (mapcar '((X) (chop (pad Max X))) Lst) 
         Grid (grid Max (length Lst))
         Jobs NIL )
      (mapc
         '((G L)
            (mapc
               '((This Val)
                  (cond
                     ((= "1" Val) 
                        (=: one T)
                        (push 'Jobs This) )
                     (T (=: one NIL)) ) )
               G
               L ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (maxi
         prog
         (make
            (for J Jobs
               (chain
                  (extract
                     '((D)
                        (let (S J  E J  C 1)
                           (while
                              (inc
                                 'C
                                 (countT
                                    (setq S ((car D) S))
                                    (setq E ((caadar D) E))
                                    (cdr D) ) ) )
                           (and (< 1 C) C) ) )
                     (quote
                        (((X) (south (west X))) . east)
                        (((X) (south (east X))) . west)
                        (((X) (east (south X))) . north)
                        (((X) (east (north X))) . south)
                        (((X) (north (west X))) . east)
                        (((X) (north (east X))) . west)
                        (((X) (west (north X))) . south)
                        (((X) (west (south X))) . north) ) ) 
                  (extract
                     '((D)
                        (let (S J  E J  C 1)
                           (while
                              (inc
                                 'C
                                 (countT
                                    (setq S ((car D) S))
                                    (setq E ((cadr D) E))
                                    (cddr D) ) ) )
                           (and (< 1 C) C) ) )
                     (quote
                        (((X) (south (west X)))
                           ((X) (south (east X))) . east)
                        (((X) (east (south X)))
                           ((X) (east (north X))) . north)
                        (((X) (north (west X)))
                           ((X) (north (east X))) . east)
                        (((X) (west (south X)))
                           ((X) (west (north X))) . north) ) ) ) ) ) ) ) )
(test
   10
   (f127 (15 15 15 15 15)) )
(test
   15
   (f127 (1 3 7  15 31)) )
(test
   3
   (f127 (3 3)) )
(test
   4
   (f127 (7 3)) )
(test
   6
   (f127 (17 22 6 14 22)) )
(test
   9
   (f127 (18 7 14 14 6 3)) )
(test
   NIL
   (f127 (21 10 21 10)) )
(test
   NIL
   (f127 (0 31 0 31 0)) )

#140 Veitch, Please!
# Implementation of:
#    IT0345 - Boolean, simplification, Veitch diagrams
#    U.S. Army intelligence center; Jan, 1997
# Supports two, three and four variables. Real Veitch.
(de sects (Lst)
   (let A (sect (car Lst) (cadr Lst))
      (for N (cddr Lst)
         (setq A (sect A N)) )
      A ) )
(de f140 (Lst)
   (let
      (Grid NIL
         P NIL
         M NIL
         V
         (mapcar intern (mapcar uppc (car Lst)))
         Len (length V) )
      (case Len
         (2
            (setq Grid (grid Len Len))
            (setq P 
               (list
                  (list (car V) (quote a1 a2))
                  (list (intern (lowc (car V))) (quote b1 b2))
                  (list (cadr V) (quote a2 b2))
                  (list (intern (lowc (cadr V))) (quote a1 b1)) ) )
            (queue 'V (intern (lowc (car V))))
            (queue 'V (intern (lowc (cadr V)))) )
         (3
            (setq Grid (grid 4 2))
            (setq P 
               (list
                  (list (car V) (quote a1 a2 b1 b2))
                  (list
                     (intern (lowc (car V))) 
                     (quote c1 c2 d1 d2) )
                  (list (cadr V) (quote a2 b2 c2 d2))
                  (list 
                     (intern (lowc (cadr V)))
                     (quote a1 b1 c1 d1) )
                  (list (caddr V) (quote b1 b2 c1 c2))
                  (list
                     (intern (lowc (caddr V)))
                     (quote a1 a2 d1 d2) ) ) )
            (queue 'V (intern (lowc (car V))))
            (queue 'V (intern (lowc (cadr V))))
            (queue 'V (intern (lowc (caddr V)))) )
         (4
            (setq Grid (grid Len Len))
            (setq P
               (list
                  (list
                     (car V)
                     (quote a1 a2 a3 a4 b1 b2 b3 b4) )
                  (list
                     (intern (lowc (car V)))
                     (quote c1 c2 c3 c4 d1 d2 d3 d4) ) 
                  (list
                     (cadr V)
                     (quote a3 b3 c3 d3 a4 b4 c4 d4) ) 
                  (list
                     (intern (lowc (cadr V)))
                     (quote a1 b1 c1 d1 a2 b2 c2 d2) ) 
                  (list
                     (caddr V)
                     (quote b1 b2 b3 b4 c1 c2 c3 c4) ) 
                  (list
                     (intern (lowc (caddr V)))
                     (quote a1 a2 a3 a4 d1 d2 d3 d4) )
                  (list
                     (cadddr V)
                     (quote a2 b2 c2 d2 a3 b3 c3 d3) )
                  (list
                     (intern (lowc (cadddr V)))
                     (quote a1 b1 c1 d1 a4 b4 c4 d4) ) ) )
            (queue 'V (intern (lowc (car V))))
            (queue 'V (intern (lowc (cadr V))))
            (queue 'V (intern (lowc (caddr V))))
            (queue 'V (intern (lowc (cadddr V)))) )
         (T (quit "Variable numbers doesnt support")) )
      # zeroize 
      (mapc
         '((G)
            (mapc 
               '((This) 
                  (=: visit NIL) (=: V NIL)) 
               G ) )
         Grid )
      (for (N 2 (>= Len N) (inc N))
         (for I (subsets N V)
            (and
               (sects
                  (mapcar '((J) (cadr (assoc J P))) I) )
               (queue 'P (list I @)) ) ) )
      (for I Lst
         (and
            (sects
               (mapcar '((J) (cadr (assoc J P))) I) )
            (with (car @) (=: V T)) ) )
      # core engine
      (make
         (for (J P J (cdr J))
            (and
               (setq M 
                  (maxi
                     '((Lst)
                        (cnt
                           '((This) (not (: visit)))
                           (cadr Lst) ) )
                     (filter
                        '((Lst)
                           (fully '((This) (: V)) (cadr Lst)) )
                        J ) ) )
               (gt0 @@)
               (link (car M))
               (mapc '((This) (=: visit T)) (cadr M)) ) ) ) ) )
(test
   '(B)
   (f140 '((A B) (a B))) ) 
(test
   '(A B)
   (f140 '((a B) (A b) (A B))) )
(test
   '(a b)
   (f140 '((a b) (a B) (A b))) )
(test
   '(a B)
   (f140 '((a b) (a B) (A B))) )
(test
   '((A B) (a b))
   (f140 '((a b) (A B))) )
(test
   '((A b) (B a))
   (f140 '((a B) (A b))) )
(test
   '(C)
   (f140 '((a b C) (a B C) (A b C) (A B C))) )
(test
   '(a)
   (f140 '((a b c) (a b C) (a B C) (a B c))) )
(test
   '((B c) (C b))
   (f140 '((a b C) (A b C) (a B c) (A B c))) )
(test
   '(A B C)
   (f140 '((a b C) (a B C) (a B c) 
      (A b c) (A b C) (A B C) (A B c) ) ) )
(test
   '(c (B a))
   (f140 '((a b c) (A b c) (a B C) (a B c) (A B c))) )
(test
   '(a)
   (f140 '((a b c) (a B c) (a b C) (a B C))) )
(test
   '((A C) (B C) (C D))
   (f140 '((a b C D) (a B C D) (a B C d) (A B C D)
      (A B C d) (A b C D) (A b C d) ) ) )
(test
   '((A B C))
   (f140 '((A B C D) (A B C d))) )
(test
   '((A C) (a c))
   (f140 '((a b c d) (a B c d) (a b c D) (a B c D)
      (A B C d) (A B C D) (A b C d) (A b C D) ) ) )
(test
   '((A B C d) (A B D c) (A C D b) (B C D a) (B a c d) (D a b c))
   (f140 '((a B c d) (A B c D) (A b C D) (a b c D)
      (a B C D) (A B C d) ) ) )
(test
   '((B c) (a c))
   (f140 '((a b c d) (a B c d) (A B c d) (a b c D)
      (a B c D) (A B c D) ) ) )
(test
   '((B d) (D b))
   (f140 '((a B c d) (A B c d) (a b c D) (a b C D)
      (A b c D) (A b C D) (a B C d) (A B C d) ) ) )
(test
   '((B D) (b d))
   (f140 '((a b c d) (A b c d) (a B c D) (A B c D)
      (a B C D) (A B C D) (a b C d) (A b C d) ) ) )
(test
   '((A b) (A c) (B C d))
   (f140 '((a B C d) (A b c d) (A b c D) (A b C d)
      (A b C D) (A B c d) (A B c D) (A B C d) ) ) )

#152 Latin Square Slicing
(de permrep (N Lst)
   (if (=0 N)
      (cons NIL)
      (mapcan
         '((X)
            (mapcar '((Y) (cons Y X)) Lst) )
         (permrep (dec N) Lst) ) ) )
(de aligns (Lst)
   (let 
      (Len (and (maxi length Lst) @@)
         L (mapcar '((L) (- Len (length L))) Lst)
         M (apply max L)
         Z
         (make
            (for (I . X) L
               (and (=0 X) (link I)) ) )
         S
         (make
            (for (I . X) L
               (and (gt0 X) (link (list I X)))) ) )
      (mapcar
         '((I J)
            (mapcar + I J) )
         (filter
            '((L)
               (and
                  (fully
                     '((I)
                        (=0 (car (nth L I))) )
                     Z )
                  (fully
                     '((I)
                        (<= (car (nth L (car I))) (cadr I)) )
                     S ) ) )
            (permrep (length L) (range 0 M)) )
         (circ (mapcar length Lst)) ) ) )
(de squares (Grid)
   (let 
      (R NIL
         C 0
         D '((X) (south (east X))) )
      (mapc 
         '((This)
            (let (C 0  S This)
               (while
                  (and
                     (setq This (D This))
                     (inc 'C)
                     (push 'R (list S C)) ) ) ) )
         (fish atom Grid) )
      (for L R
         (let (R NIL  P (car L))
            (with (car L)
               (do (inc (cadr L))
                  (push 'R)
                  (push R (: D))
                  (do (cadr L)
                     (setq This (east This))
                     (push R (: D)) )
                  (setq P (setq This (south P))) ) )
            (queue 'L R) ) )
      (filter
         '((L)
            (fully 
               '((I) (not (flg? I)))
               (fish atom (caddr L)) ) )
         R ) ) )

(de f152 (Lst)
   (let
      (Res NIL  A NIL
         M (and (maxi length Lst) @@)
         Rows (length Lst)
         Cols (and (maxi length Lst) @@)
         Grid (grid Cols Rows) )
      (for L (aligns Lst)
         (mapc
            '((G L)
               (mapc
                  '((This Val)
                     (=: D NIL)
                     (=: D Val) )
                  G
                  L ) )
            Grid
            (apply 
               mapcar 
               (reverse 
                  (mapcar 
                     '((I J) 
                        (need (- M) (need J (copy I))) )
                     Lst
                     L ) )
               list ) ) 
         (for L (squares Grid)
            (let (R NIL  P (car L))
               (with (car L)
                  (do (inc (cadr L))
                     (push 'R)
                     (push R (: D))
                     (do (cadr L)
                        (setq This (east This))
                        (push R (: D)) )
                     (setq P (setq This (south P))) ) )
               (with (car L)
                  (setq P This)
                  (do (inc (cadr L))
                     (push 'R)
                     (push R (: D))
                     (do (cadr L)
                        (setq This (south This))
                        (push R (: D)) )
                     (setq P (setq This (east P))) ) )
               (and
                  (apply
                     =
                     (setq
                        R
                        (mapcar
                           '((L)
                              (sort L) )
                           R ) ) )
                  (push1 'Res (caddr L)) ) ) ) )
      (for L Res
         (accu 'A (length (car L)) 1) )
      (flip (by car sort A)) ) )
(test
   NIL
   (f152
      (quote
         (A B C D)
         (A C D B)
         (B A D C)
         (D C A B) ) ) )
(test
   '((6 . 1))
   (f152
      (quote
         (A B C D E F)
         (B C D E F A)
         (C D E F A B)
         (D E F A B C)
         (E F A B C D)
         (F A B C D E) ) ) )
(test
   '((4 . 1) (2 . 4))
   (f152
      (quote
         (A B C D)
         (B A D C)
         (D C B A)
         (C D A B) ) ) )
(test
   '((3 . 3))
   (f152
      (quote
         (B D A C B)
         (D A B C A)
         (A B C A B)
         (B C A B C)
         (A D B C A) ) ) )
(test
   NIL
   (f152
      (quote
         (2 4 6 3)
         (3 4 6 2)
         (6 2 4) ) ) )
(test
   '((2 . 2))
   (f152
      (quote
         (1)
         (1 2 1 2)
         (2 1 2 1)
         (1 2 1 2) ) ) )
(test
   '((3 . 1) (2 . 2))
   (f152
      (quote
         (3 1 2)
         (1 2 3 1 3 4)
         (2 3 1 3) ) ) )
(test
   '((4 . 1) (3 . 1) (2 . 7))
   (f152
      (quote
         (8 6 7 3 2 5 1 4)
         (6 8 3 7)
         (7 3 8 6)
         (3 7 6 8 1 4 5 2)
         (1 8 5 2 4)
         (8 1 2 4 5) ) ) )

#113 Making Data Dance
(when `(== 64 64)
   (symbols '4clojure 'pico)
   (local str1 seq Prg Lst)

   (de str1 Prg
      (run Prg) )
   (de seq Prg
      (run Prg) )
   (de f113 @
      (let Lst (rest)
         (casq (car (up 2))
            (str1 (glue ", " (sort Lst)))
            (seq (uniq Lst))
            (T Lst) ) ) )
   (test "1, 2, 3"
      (str1 (f113 2 1 3)) )
   (test (2 1 3)
      (seq (f113 2 1 3)) )
   (test (2 1 3)
      (seq (f113 2 1 3 3 1 2)) )
   (test (1)
      (seq (apply f113 (need 5 1))) )
   (test "1, 1, 1, 1, 1"
      (str1 (apply f113 (need 5 1))) )
   (test NIL
      (seq (f113)) )
   (test ""
      (str1 (f113)) ) )
