(load "@lib/simul.l")
(load "@lib/rsa.l")

# Accumulate
(de acmlt (Lst F)
   (make
      (for L Lst
         (link (F L)) ) ) )
(test
   (1 4 9)
   (acmlt (1 2 3) '((N) (** N 2))) )
(test
   '((a1 a2 a3) (b1 b2 b3) (c1 c2 c3))
   (acmlt
      '(a b c)
      '((A)
         (mapcar
            '((X) (intern (pack A X)))
            (1 2 3) ) ) ) )
(test
   "eht kciuq nworb xof cte"
   (glue
      " "
      (acmlt
         (split (chop "the quick brown fox etc") " ")
         '((A)
            (pack (flip A)) ) ) ) )

# Acronym
(de acrnm (Lst)
   (let Lst (split (chop Lst) " " "," ":" "-")
      (uppc
         (pack
            (mapcan
               '((L)
                  (cons 
                     (car L)
                     (or
                        (fully upp? (cdr L))
                        (filter upp? (cdr L)) ) ) )
               Lst ) ) ) ) )
(test
   "PNG"
   (acrnm "Portable Network Graphics") )
(test
   "ROR"
   (acrnm "Ruby on Rails") )
(test
   "HTML"
   (acrnm "HyperText Markup Language") )
(test
   "FIFO"
   (acrnm "First In, First Out") )
(test
   "PHP"
   (acrnm "PHP: Hypertext Preprocessor") )
(test
   "GIMP"
   (acrnm "GNU Image Manipulation Program") )
(test
   "CMOS"
   (acrnm "Complementary metal-oxide semiconductor") )

# All your base
(de allbase (IB IN OB)
   (let 
      (X -1
         Z 
         (sum 
            '((N) (* N (** IB (inc 'X)))) 
            (reverse IN) )
         V NIL
         RR NIL )
      (one IB)
      (while (gt0 Z)
         (setq IB (* IB OB)  V (% Z IB))
         (push 'RR (/ V (/ IB OB)))
         (dec 'Z V) )
      RR ) )
(test
   (4 2)
   (allbase 2 (1 0 1 0 1 0) 10) )      
(test
   (5)
   (allbase 2 (1 0 1) 10) )
(test
   (1)
   (allbase 2 (1) 10) )
(test
   (1 0 1)
   (allbase 10 (5) 2) )
(test
   (1 1 2 0)
   (allbase 16 (2 10) 3) )
(test
   (2 10)
   (allbase 3 (1 1 2 0) 16) )
(test
   (6 10 45)
   (allbase 97 (3 46 60) 73) )

# Allergies
(setq *ALLRGS
   (quote
      eggs peanuts shellfish strawberries 
      tomatoes chocolate pollen cats ) )
(de allrg (N)
   (extract
      '((A B) (and (= "1" A) B))
      (head 8 (flip (chop (bin N))))
      *ALLRGS ) )
(test
   '(eggs shellfish)
   (allrg 5) )
(test
   '(eggs peanuts)
   (allrg 3) )
(test
   '(strawberries tomatoes chocolate pollen cats)
   (allrg 248) )
(test
   '(eggs peanuts shellfish strawberries tomatoes chocolate pollen cats)
   (allrg 255) )
(test
   '(eggs shellfish strawberries tomatoes chocolate pollen cats)
   (allrg 509) )

# Alphametics
(de comb (M Lst)
   (cond
      ((=0 M) '(NIL))
      ((not Lst))
      (T
         (conc
            (mapcar
               '((Y) (cons (car Lst) Y))
               (comb (dec M) (cdr Lst)) )
            (comb M (cdr Lst)) ) ) ) )
(de alpha (Lst)
   (let
      (Lst (reverse Lst)
         U (uniq (mapcan chop Lst))
         UL (length U)
         L 
         (mapcar 
            '((L)
               (mapcar
                  '((C) (cons C (index C U))) 
                  (chop L) ) )
            Lst ) )
      (pick
         '((Z)
            (pick
               '((I)
                  (unless
                     (pick 
                        '((C) (=0 (get I (cdar C))))
                         L )
                     (let S
                        (mapcar
                           '((A) 
                              (format 
                                 (mapcar '((C) (get I (cdr C))) A) ) ) 
                           L )
                        (and
                           (= (car S) (apply + (cdr S)))
                           (flip S) ) ) ) )
               (permute Z) ) )
         (comb UL (range 0 9)) ) ) )
(test (72 48 120) (alpha '(hi lo mid)))
(test (9567 1085 10652) (alpha '(send more money)))
(test (41652 9 687762 729423) (alpha '(solve a little teaser)))
(test (80462 9 49352 129823) (alpha '(solve a large teaser)))

# Anagram
(de angrm-sort (L)
   (sort (mapcar char (chop (lowc L)))) )
(de angrm (Wrd Lst)
   (let
      (Wrd (lowc Wrd)
         Lst
         (filter 
            '((L) (not (= (lowc L) Wrd))) 
            Lst )
         Wrd (angrm-sort Wrd) )
      (filter '((L) (= (angrm-sort L) Wrd)) Lst) ) )
(test
   NIL
   (angrm
      'diaper
      '(hello world zombies pants) ) )
(test
   NIL
   (angrm
      'galea
      '(eagle) ) )
(test
   '(inlets)
   (angrm
      'listen
      '(enlists google inlets banana) ) )
(test
   '(tan)
   (angrm
      'ant
      '(tan stand at) ) )         
(test
   '(stream maters)
   (angrm
      'master
      '(stream pigeon maters) ) )
(test
   NIL
   (angrm
      'good
      '(dog goody) ) )
(test
   NIL
   (angrm
      'mass
      '(last) ) )
(test
   '(cron)
   (angrm
      'corn
      '(corn dark Corn rank CORN cron park) ) )
(test
   '(gallery regally largely)
   (angrm
      'allergy
      '(gallery ballerina regally clergy largely leading) ) )
(test
   '(Carthorse)
   (angrm
      'Orchestra
      '(cashregister Carthorse radishes) ) )
(test
   '(carthorse)
   (angrm
      'Orchestra
      '(cashregister carthorse radishes) ) )
(test
   '(Carthorse)
   (angrm
      'orchestra
      '(cashregister Carthorse radishes) ) )
(test
   NIL
   (angrm
      'go
      '(go Go GO) ) )
(test
   NIL
   (angrm
      'tapper
      '(patter) ) )
(test
   NIL
   (angrm
      'banana
      '(Banana) ) )
(test
   NIL
   (angrm
      'BANANA
      '(Banana) ) )

# Atbash cipher
(setq
   *ATBASE
   (quote
      (a . z) (b . y) (c . x) (d . w) (e . v) (f . u) (g . t)
      (h . s) (i . r) (j . q) (k . p) (l . o) (m . n) (n . m)
      (o . l) (p . k) (q . j) (r . i) (s . h) (t . g) (u . f)
      (v . e) (w . d) (x . c) (y . b) (z . a) ) )
(de atbash (Str)
   (let (Str (chop (lowc Str))  "N" (cons (+ 0) 5)) # (+ 0) is workaround
      (pack
         (mapcon
            '((A)
               (or
                  (= " " (car A))
                  (cons
                     (cdr (assoc (car A) *ATBASE))
                     (cons (at "N" (and (cdr A) " "))) ) ) )
            Str ) ) ) )
(test
   "gvhg"
   (atbash "test") )
(test
   "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
   (atbash "The quick brown fox jumps over the lazy dog") )
(test
   "nrmwy oldrm tob"
   (atbash "mindblowingly") )
(test # decrypt
   "test"
   (atbash "gvhg") )

# Bank account

# Beer song 
# - http://rosettacode.org/wiki/99_Bottles_of_Beer/Lisp#PicoLisp

# Binary search tree

# Binary search
# - http://rosettacode.org/wiki/Binary_search#PicoLisp

# Binary
# - see "All your base"
 
# Bob

# Bowling
# - modified task
# - tests and counting rules from Internet and Wikipedia
# - without validations
(de sumcurr (L)
   (let S 0
      (if (atom L)
         (inc 'S 10)
         (for N L
            (case N
               ("X" (inc 'S 10))
               ("/"
                  (inc
                     'S
                     (- (if (> S 10) 20 10) S) ) )
               (T (inc 'S N)) ) ) )
      S ) )
(de sumone (L)
   (if (atom L) 
      10 
      (if (num? (car L)) @ 10) ) )
(de sumtwo (L)
   (let S 0
      (if (atom (car L))
         (inc 'S (+ 10 (sumone (cadr L))))
         (inc 'S (sumcurr (head 2 (car L)))) ) ) )
(de bowling (Lst)
   (let S 0
      (for ((I . L) Lst L (cdr L))
         (inc 'S (setq @@ (sumcurr (car L))))
         (if (= "X" (car L))
            (inc 'S (sumtwo (cdr L))) 
            (and 
               (= @@ 10)
               (inc 'S (sumone (cadr L))) ) ) )
   S ) ) 
(test
   82
   (bowling 
      (quote
         (9 0) (3 5) (6 1) (3 6) (8 1)
         (5 3) (2 5) (8 0) (7 1) (8 1) ) ) )
(test
   131
   (bowling
      (quote
         (9 0) (3 /) (6 1) (3 /) (8 1)
         (5 /) (0 /) (8 0) (7 /) (8 / 8) ) ) )
(test
   193
   (bowling
      (quote
         X (3 /) (6 1) X X
         X (2 /) (9 0) (7 /) (X X X) ) ) )
(test
   97
   (bowling
      (quote
         (2 3) (4 /) (7 /) (3 2) (2 2)
         (5 4) (2 5) (5 4) (3 5) (X 8 /) ) ) )
(test
   150
   (bowling
      (quote
         (5 2) (5 4) X X (8 0)
         (2 6) (8 /) (1 0) X (X X X) ) ) )
(test
   38
   (bowling
      (quote
         (3 3) (1 2) (2 1) (0 0) (2 2)
         (3 3) (3 3) (2 1) (1 0) (3 3) ) ) )

(test 10 (sumone 'X))
(test 4 (sumone (4 3)))
(test 4 (sumone (4 /)))
(test 10 (sumcurr 'X))
(test 9 (sumcurr '(4 5)))
(test 10 (sumcurr '(4 /)))
(test 20 (sumcurr '(X 4 /)))
(test 20 (sumtwo '(X X)))
(test 13 (sumtwo '(X (3 3))))
(test 6 (sumtwo '((3 3))))
(test 10 (sumtwo '((4 /))))
(test 14 (sumtwo '((X 4 4))))
(test 14 (sumtwo '((X 4 /))))
(test 28 (bowling '(X (3 6))))
(test 57 (bowling '(X X (9 0))))
(test 78 (bowling '(X X X (0 9))))
(test 46 (bowling '(X X (4 2))))
(test 15 (bowling '((7 2) (4 2))))
(test 20 (bowling '((7 3) (4 2))))

# Bracket push
# - http://rosettacode.org/wiki/Balanced_brackets#PicoLisp

# Change 
(de change (X Coins)
# without validation
   (let
      (MC (need (inc X) 0)
         CU (need (inc X) 0) )
      (for Y X
         (let (CC Y  NC 1)
            (for (J Coins (and J (>= Y (car J))) (cdr J))
               (let Z (inc (get MC (inc (- Y (car J)))))
                  (and
                     (> CC Z)
                     (setq
                        CC Z
                        NC (car J) ) ) ) )
            (set 
               (nth MC (inc Y)) CC
               (nth CU (inc Y)) NC ) ) )
      (inc 'X) # !
      (make
         (while (> X 1)
            (and (link (get CU X)) (dec 'X @)) ) ) ) )
(test
   (25)
   (change 25 (1 5 10 25 100)) )
(test
   (5 10)
   (change 15 (1 5 10 25 100)) )
(test
   (4 4 15)
   (change 23 (1 4 15 20 50)) )
(test
   (21 21 21)
   (change 63 (1 5 10 21 25)) )
(test
   (2 2 5 20 20 50 100 100 100 100 100 100 100 100 100)
   (change 999 (1 2 5 10 20 50 100)) )
(test
   NIL
   (change 0 (1 5 10 21 25)) )

# Circular buffer
# - without validations
# - one function
# Legend:
# - (cb 'C 7) - create only
# - (cb 'C 7 2) - create and write
# - (cb 'C) - fetch 
# - (cb 'C 2 3) - write
#
(de _cbinc (L N)
   (and
      (inc L)
      (> @ N)
      (set L 1) ) )
(de cb ("V" . @)
   (if (not (rest))
      (prog1
         (swap (nth (val "V") 2 (caar (val "V"))))
         (_cbinc (car (val "V")) (cddar (val "V"))) )
      (when (not (val "V"))
         (set "V"
            (list
               (cons 1 1 (car (rest)))
               (need (car (rest))) ) )
         (next) )
      (for I (rest)
         (set (nth (val "V") 2 (cadar (val "V")))
            I )
         (_cbinc (cdar (val "V")) (cddar (val "V"))) ) ) )
(let C NIL
   (cb 'C 3 1 2 3)
   (cb 'C 11 12 13)
   (test
      '((1 1 . 3) (11 12 13))
      C )
   (off C)
   (cb 'C 5)
   (cb 'C 1 2 3 'a 'b)
   (do 3
      (cb 'C) )
   (cb 'C 777 888)
   (test
      '((4 3 . 5) (777 888 NIL a b))
      C ) ) 
 
# Clock
(de _clock (H M)
   (let C (% (+ (* H 60) M) 1440)
      (and (lt0 C) (inc 'C 1440))
      C ) )
(de clock (H M)
   (let C (_clock H M)
      (pack
         (pad 2 (/ C 60))
         ":"
         (pad 2 (% C 60)) ) ) )
(de clockadd (H M A)
   (clock 0 (+ A (_clock H M))) )
(de clockeq (H1 M1 H2 M2)
   (= (_clock H1 M1) (_clock H2 M2)) )

(test "08:00" (clock 8 0))
(test "11:09" (clock 11 9))
(test "00:00" (clock 24 0))
(test "01:00" (clock 25 0))
(test "04:00" (clock 100 0))
(test "02:00" (clock 1 60))
(test "02:40" (clock 0 160))
(test "04:43" (clock 0 1723))
(test "03:40" (clock 25 160))
(test "11:01" (clock 201 3001))
(test "00:00" (clock 72 8640))
(test "23:15" (clock -1 15))
(test "23:00" (clock -25 0))
(test "05:00" (clock -91 0))
(test "00:20" (clock 1 -40))
(test "22:20" (clock 1 -160))
(test "16:40" (clock 1 -4820))
(test "20:20" (clock -25 -160))
(test "22:10" (clock -121 -5810))
(test "10:03" (clockadd 10 0 3))
(test "06:41" (clockadd 6 41 0))
(test "01:25" (clockadd 0 45 40))
(test "11:01" (clockadd 10 0 61))
(test "03:25" (clockadd 0 45 160))
(test "00:01" (clockadd 23 59 2))
(test "06:32" (clockadd 5 32 1500))
(test "11:21" (clockadd 1 1 3500))
(test "10:00" (clockadd 10 3 -3))
(test "09:33" (clockadd 10 3 -30))
(test "08:53" (clockadd 10 3 -70))
(test "23:59" (clockadd 0 3 -4))
(test "21:20" (clockadd 0 0 -160))
(test "03:35" (clockadd 6 15 -160))
(test "04:32" (clockadd 5 32 -1500))
(test "00:20" (clockadd 2 20 -3000))
(test T (clockeq 15 37 15 37))
(test NIL (clockeq 15 36 15 37))
(test NIL (clockeq 14 37 15 37))
(test T (clockeq 10 37 34 37))
(test T (clockeq 3 11 99 11))
(test T (clockeq 22 40 -2 40))
(test T (clockeq 17 3 -31 3))
(test T (clockeq 13 49 -83 49))
(test T (clockeq 0 1 0 1441))
(test T (clockeq 2 2 2 4322))
(test T (clockeq 2 40 3 -20))
(test T (clockeq 4 10 5 -1490))
(test T (clockeq 6 15 6 -4305))
(test T (clockeq 7 32 -12 -268))
(test T (clockeq 18 7 -54 -11513))

# Connect
(de _cnctjobs (G) # I like it that way
   (let (S (last (car G))  E (car (last G)))
      (mapcar
         '((J)
            (let (DS (cadr J)  DE (caddr J))
               (make
                  (link (car J))
                  (for Y '((S . DS) (E . DE))
                     (with (val (car Y))
                        (link
                           (make
                              (while This
                                 (and (= (: N) (car J)) (link This))
                                 (setq This ((val (cdr Y)) This)) ) ) ) ) ) ) ) )
         (list
            (quote
               X
               ((X) (south (east X)))
               ((X) (north (west X))) )
            (quote
               O
               ((X) (east (east X)))
               ((X) (west (west X))) ) ) ) ) )
(de cnct (Lst)
   (let 
      (Lst (mapcar chop Lst)
         Grid (grid (length (car Lst)) (length Lst)) )
      (mapc
         '((G)
            (mapc 
               '((This) (=: visit NIL) (=: V NIL)) 
               G ) )
         Grid )
      (mapc
         '((G L)
            (mapc 
               '((This Val) 
                  (ifn (= "#" Val)
                     (=: N (intern Val))
                     (with (: 0 1 1) (con (: 0 1)))    # Cut off west
                     (with (: 0 1 -1) (set (: 0 1)))   # east
                     (with (: 0 -1 1) (con (: 0 -1)))  # south
                     (with (: 0 -1 -1) (set (: 0 -1))) # north
                     (set This) ) )
               G 
               L ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      #{
      (disp # show grid
         Grid
         0 
         '((This) 
            (align
               3
               (pack
                  " "
                  (if (sp? (: N)) "!" (: N))
                  " " ) ) ) )
      }#
      (extract
         '((J)
            (let (H (car J)  S (cadr J)  F (caddr J))
               (and
                  (find
                     '((Y)
                        (with Y
                           (recur (This)
                              (when
                                 (and
                                    This
                                    (= H (: N))
                                    (not (: visit)) )
                                 (if (memq This F)
                                    T
                                    (=: visit T)
                                    (or
                                       (recurse (east (east This)))
                                       (recurse (west (west This)))
                                       (recurse
                                          ('((D) 
                                                (or (south (west D)) (west (south D))) ) 
                                             This ) )
                                       (recurse
                                          ('((D)
                                                (or (north (west D)) (west (north D))) ) 
                                             This ) )
                                       (recurse
                                          ('((D) 
                                                (or (south (east D)) (east (south D))) ) 
                                             This ) )
                                       (recurse
                                          ('((D) 
                                                (or (north (east D)) (east (north D))) )
                                             This ) )
                                       (=: visit NIL) ) ) ) ) ) )
                     S )
                  H ) ) )
         (_cnctjobs Grid) ) ) )
(test
   NIL
   (cnct
      (quote
         "O O O X###"
         "#X . . X##"
         "##X . . X#"
         "###X O O O" ) ) )
(test
   NIL
   (cnct
      (quote
         "X O . .###"
         "#O X X X##"
         "##O X O .#"
         "###. O X ." ) ) )
(test
   NIL
   (cnct
      (quote
         "X . . .####"
         "#. X O .###"
         "##O . X O##"
         "###. O . X#"
         "####. . O ." ) ) )
(test
   '(X)
   (cnct
      (quote
         ". O . .####"
         "#O X X X###"
         "##O X O .##"
         "###X X O X#"
         "####. O X ." ) ) )
(test
   '(O)
   (cnct
      (quote
         ". O . .####"
         "#O X X X###"
         "##O O O .##"
         "###X X O X#"
         "####. O X ." ) ) )
(test
   '(X)
   (cnct
      (quote
         ". X X . .####"
         "#X . X . X###"
         "##. X . X .##"
         "###. X X . .#"
         "####O O O O O" ) ) )
(test
   '(X)
   (cnct
      (quote
         "O X X X X X X X X########"
         "#O X O O O O O O O#######"
         "##O X O X X X X X O######"
         "###O X O X O O O X O#####"
         "####O X O X X X O X O####"
         "#####O X O O O X O X O###"
         "######O X X X X X O X O##"
         "#######O O O O O O O X O#"
         "########X X X X X X X X O" ) ) )
(test # from interner
   '(X)
   (cnct
      (quote
         ". . . . . . O X . . .##########"
         "#O X X X X X O . . . X#########"
         "##X O O O X O . . . X O########"
         "###. . O X O X . . O X O#######"
         "####. X O X O X . . X . .######"
         "#####. O . X O O . X O O .#####"
         "######. . O X X . O X . . .####"
         "#######. O X O X X X O . . .###"
         "########. O X X O O . . . . .##"
         "#########. O . . . . . . . . .#"
         "##########. . . . . . . . . . ." ) ) )

# Counter 

# Crypto square
(de sqrt-ceil (N)
   (let X (sqrt N)
      (if (= (* X X) N)
         X
         (inc X) ) ) )
(de csquare (Str)
   (let 
      (Str 
         (extract
            '((C)
               (let C (char C)
                  (cond
                     ((<= `(char "a") C `(char "z")) (char C))
                     ((<= `(char "A") C `(char "Z"))
                        (char (- (+ C `(char "a")) `(char "A"))) ) ) ) )
            (chop Str) )
         Col (sqrt-ceil (length Str))
         S (make (while (cut Col 'Str) (link @))) )
      (pack (apply mapcar S list)) ) )
(test
   "imtgdvsfearwermayoogoanouuiontnnlvtwttddesaohghnsseoau"
   (csquare "If man was meant to stay on the ground, god would have given us roots.") )

# Custom set

# Diamond
(de diam_inner (N)
   (let (C 65  X 1)
      (make
         (link (cons C)) 
         (do N
            (link (cons (inc 'C) X))
            (inc 'X 2) )
         (dec 'X 4)
         (do (dec N)
            (link (cons (dec 'C) X))
            (dec 'X 2) )
         (link (cons (dec C))) ) ) )
(de diam_outter (N)
   (let X N
      (make
         (while (ge0 N)
            (link N)
            (dec 'N) )
         (one N)
         (while (>= X N)
            (link N)
            (inc 'N) ) ) ) )
(de dots (N)
   (do N
      (prin ".") ) )
(de diamond (Char)
   (let C (- (char Char) `(char "A")) 
      (mapc
         '((O I)
            (let C (intern (char (car I)))
               (dots O)
               (if (not (cdr I))
                  (prin C)
                  (prin C)
                  (dots (cdr I))
                  (prin C) )
               (dots O)
               (prinl) ) )
         (diam_outter C)
         (diam_inner C) ) ) )
(de diamond- (Char) # Version from Alex
   (let N (- (char Char) `(char "@"))
      (for I
         (conc
            (range 1 N)
            (and (gt0 (dec N)) (range @ 1)) )
         (let C (char (+ I `(char "@")))
            (dots (- N I))
            (prin C)
            (unless (=1 I)
               (dots (dec (* 2 (dec I))))
               (prin C) )
            (dots (- N I))
            (prinl) ) ) ) )
# without tests
#(diamond "C")
#(diamond "E")

# Difference of squares
(de sqsum (L)
   (** (apply + (range 1 L)) 2) )
(de sumsq (L)
   (sum '((N) (** N 2)) (range 1 L)) )
(de diffsq (L)
   (- (sqsum L) (sumsq L)) ) 
(test 225 (sqsum 5))
(test 25502500 (sqsum 100))
(test 55 (sumsq 5))
(test 385 (sumsq 10))
(test 170 (diffsq 5))
(test 25164150 (diffsq 100))

# Diffie-Hellman
# **Mod in rsa.l
(let 
   (G 5
      P 23
      a 6
      b 15
      A 8 
      B 19
      S 2 )
   (test A (**Mod G a P))
   (test B (**Mod G b P))
   (test T (= S (**Mod B a P) (**Mod A b P))) )
(let
   (G 2
      P 120227323036150778550155526710966921740030662694578947298423549235265759593711587341037426347114541533006628856300552706996143592240453345642869233562886752930249953227657883929905072620233073626594386072962776144691433658814261874113232461749035425712805067202910389407991986070558964461330091797026762932543
      a 2483479393625932939911081304356888505153797135447327501792696199190469015215177630758617902200417377685436170904594686456961202706692908603181062371925882
      b 2844781412204994442318407311225094972145734524405396643776897397213753006320038489136125386628158458985993855256435991539471119984824315001920818146213707
      A 61678527952040072870650459515263381829276973613536768603757411844364870063542867267562473479559495488666666075954962808183899153816735665915711203506512273020452201347157636376673401507919350061176254359195853198488037548453138203184227637743455602143709294958655050125543282173194319172862277477755496416784
      B 75205441154357919442925546169208711235485855904969178206313309299205868312399046149367516336607966149689640419216591714331722664409474612463910928128055994157922930443733535659848264364106037925315974095321112757711756912144137705613776063541350548911512715512539186192176020596861210448363099541947258202188
      S 70900735223964890815905879227737819348808518698920446491346508980461201746567735331455825644429877946556431095820785835497384849778344216981228226252639932672153547963980483673419756271345828771971984887453014488572245819864454136618980914729839523581263886740821363010486083940557620831348661126601106717071 )
   (test A (**Mod G a P))
   (test B (**Mod G b P))
   (test T (= S (**Mod B a P) (**Mod A b P))) )

# Dominoes
(de domino (Lst)
# https://en.wikipedia.org/wiki/Eulerian_path
   (let R NIL
      (for L Lst
         (accu
            'R
            (car L) 
            (if (= (car L) (cdr L)) 2 1) )
         (accu 'R (cdr L) 1) )
      (unless (find '((L) (bit? 1 (cdr L))) R)
         (make
            (setq @@ (cdr (link (pop 'Lst))))
            (until
               (for (L Lst L (cdr L))
                  (T (= @@ (caar L))
                     (link (car L))
                     (setq @@ (cdar L))
                     (set L) )
                  (T (= @@ (cdar L))
                     (link (cons (cdar L) (caar L))) 
                     (setq @@ (caar L))
                     (set L) )
                  T ) ) ) ) ) )
(test
   NIL
   (domino '((1 . 2))) )
(test
   '((1 . 2) (2 . 3) (3 . 1))
   (domino '((1 . 2) (3 . 1) (2 . 3))) )
(test
   '((1 . 2) (2 . 3) (3 . 1))
   (domino '((1 . 2) (1 . 3) (2 . 3))) )
(test
   NIL
   (domino '((1 . 2) (4 . 1) (2 . 3))) )
(test
   NIL
   (domino '((1 . 2) (2 . 3) (3 . 1) (4 . 4))) )
(test
   '((1 . 2) (2 . 1) (1 . 3) (3 . 5) (5 . 6) (6 . 1))
   (domino '((1 . 2) (5 . 3) (3 . 1) (1 . 2) (2 . 4) (1 . 6) (2 . 3) (3 . 4) (5 . 6))) )
(test
   '((1 . 2) (2 . 3) (3 . 1))
   (domino '((1 . 2) (2 . 3) (1 . 3))) )
(test
   '((1 . 4) (4 . 1))
   (domino '((1 . 4) (1 . 4))) )
(test
   '((2 . 4) (4 . 11) (11 . 3) (3 . 2))
   (domino '((2 . 4) (3 . 2) (3 . 11) (11 . 4))) )
(test
   NIL
   (domino '((1 . 1) (2 . 2))) )
(test
   NIL
   (domino '((1 . 2) (2 . 3) (3 . 4))) )

# Dot DSL
# Error Handling
# ETL
# Flatten array
# Food chain
# Forth
(setq *CODE
   (quote
      (+ (push 'S (+ (++ S) (++ S))))
      (- (let @@ (++ S)
            (push 'S (- (++ S) @@)) ) )
      (* (push 'S (* (++ S) (++ S))))
      (drop (++ S))
      (swap (xchg S (cdr S)))
      (dup (push 'S (car S)))
      (over (push 'S (cadr S)))
      (:
         (push 'U
            (list
               (fword)
               (make
                  (until (= ";" (setq @@ (fword)))
                     (link @@) ) ) ) ) ) ) )
(de fword ()
   (and
      (loop
         (T (eof))
         (T
            (lst?
               (case (peek)
                  ("(" (till ")") (char))
                  ("\\" (line T))
                  (" " (skip))
                  ("^J" (char))
                  (T (setq @@ (till " ^J"))) ) )
            @@ ) )
      (setq @@ @)
      ((if (fully format @@) format intern) (pack @@)) ) )
(de feval (A)
   (cond
      ((not A))
      ((num? A) (push 'S A))
      ((setq @@ (assoc A *CODE)) (run (cdr @@)))
      ((setq @@ (assoc A U)) (feval (cdr @@)))
      (T (feval (car A)) (feval (cdr A))) ) ) 
(de frun (F)
   (let (S NIL U)
      (in F (while (setq @@ (fword)) (feval @@)))
      S ) )

(test (922) (frun "demo0.f"))
(test (20) (frun "demo1.f"))

(msg 'ok)
(bye)

