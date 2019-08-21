`(== 64 64)
(load "@lib/simul.l")
(seed (in "/dev/urandom" (rd 8)))
#(gc 128)

#{

# --- Day 1: Chronal Calibration ---
(setq *A1
   (make
      (in "data/1.txt"
         (while (read)
            (link @) ) ) ) )
# part 1
(test 582 (sum prog *A1))

# part 2
(de a1uniq ("R" N)
   (and
      (not (member N (val "R")))
      (push "R" N) ) )
(de a1-2 (Lst)
   (let (Lst (apply circ Lst)  N 0  R (list N))
      (loop
         (NIL (a1uniq 'R (inc 'N (++ Lst)))
            N ) ) ) )
(test 0 (a1-2 (1 -1)))
(test 10 (a1-2 (3 3 4 -2 -4)))
(test 5 (a1-2 (-6 3 8 5 -6)))
(test 14 (a1-2 (7 7 -2 -7 -4)))
(test 488 (a1-2 *A1))

# --- Day 2: Inventory Management System ---
(de a2cons (Word)
   (let (R (list 0 0)  D)
      (for C Word
         (accu 'D C 1) )
      (and (rassoc 2 D) (inc R))
      (and (rassoc 3 D) (inc (cdr R)))
      R ) )
(test (list 1 1) (a2cons (chop "bababc")))
(de a2list (F)
   (make
      (in F
         (while (line)
            (link (a2cons @)) ) ) ) )
(de a2-1 (F)
   (let L (a2list F)
      (* (sum car L) (sum cadr L)) ) )
(test 12 (a2-1 "data/2-test.txt"))
(test 7688 (a2-1 "data/2.txt"))

# part2
(de a2char (F)
   (make
      (in F
         (while (line)
            (link (mapcar char @)) ) ) ) )
(de a2-2 (F)
   (let Lst (a2char F)
      (for L (subsets 2 Lst)
         (T
            (=1
               (cnt n0 (mapcar - (car L) (cadr L))) )
            (pack (mapcar char (sect (car L) (cadr L)))) ) ) ) )
(test
   "fgij" 
   (a2-2 "data/2-test-2.txt") )
(test
   "lsrivmotzbdxpkxnaqmuwcchj"
   (a2-2 "data/2.txt") )

# --- Day 3: No Matter How You Slice It ---
(de a3-data (F)
   (make
      (in F
         (until (eof)
            (link
               (make
                  (let N NIL
                     (from "#")
                     (setq N (read))
                     (from "@ ")
                     (link (inc (read)))
                     (char)
                     (link (inc (format (till ":"))))
                     (char)
                     (link 
                        (format (till "x"))
                        (prog (char) (read))
                        N ) ) ) )
            (line) ) ) ) )
(de a3-1 (F N)
   (let (Grid (grid N N)  Data (a3-data F))
      (for Col Grid
         (for This Col
            (=: A3-1 0) ) )
      (for D Data
         (with (get Grid (car D) (cadr D))
            (do (caddr D)
               (use (This)
                  (do (cadddr D)
                     (=: A3-1 (if (=0 (: A3-1)) 1 T))
                     (setq This (north This)) ) )
               (setq This (east This)) ) ) )
      (cons
         (sum
            '((Col)
               (cnt '((This) (=T (: A3-1))) Col) )
            Grid )
         (last
            (find
               '((D)
                  (let Over? 0
                     (with (get Grid (car D) (cadr D))
                        (do (caddr D)
                           (use (This)
                              (do (cadddr D)
                                 (setq Over? (x| Over? (=1 (: A3-1))))
                                 (setq This (north This)) ) )
                           (setq This (east This)) ) )
                     Over? ) )
               Data ) ) ) ) )
# Both parts
(test (cons 4 3) (a3-1 "data/3-test.txt" 8))
(test (cons 110389 552) (a3-1 "data/3.txt" 1000))

# --- Day 4: Repose Record ---
#{
# make test file unsorted
# save to 4-test-unsorted.txt"
(setq Lst
   (shuffle
      (make
         (in "data/4-test-sorted.txt"
            (while (line T)
               (link @) ) ) ) ) )
(for L Lst
   (prinl L) )
}#

(de a4-line-T (F)
   (make
      (in F
         (while (line T)
            (link @) ) ) ) )
(de a4-accuL (V K A B)
   (if (assoc K (val V))
      (conc (cdr @) (cons (range A B)))
      (push V (list K (range A B))) ) )
(de a4-accuN (V K N)
   (if (assoc K (val V))
      (accu (cdr @) N 1)
      (push V (list K (list (cons N 1)))) ) )
(de a4-1 (F)
   (let
      (Lst 
         (mapcar
            '((L)
               (head 
                  4 
                  (cddr (split (cdr (chop L)) " " "]" ":")) ) )
            (sort (a4-line-T F)) )
         G NIL
         F NIL
         W NIL
         R NIL
         Z NIL )
      (for L Lst
         (if (= "G" (nth L 3 1 1))
            (set 'G (format (nth L 4 2)))
            (ifn F
               (set 'F (format (car L)))
               (set 'W (dec (format (car L))))
               (a4-accuL 'R G F W)
               (off F W) ) ) )
      (setq R
         (car
            (flip
               (by
                  '((L) (sum length (cdr L)))
                  sort
                  R ) ) ) )
      (mapc
         '((Lst)
            (mapc '((L) (accu 'Z L 1)) Lst) )
         (cdr R) )
      (* 
         (car R)
         (caar (flip (by cdr sort Z))) ) ) )
(test 240 (a4-1 "data/4-test-unsorted.txt"))
(test 3212 (a4-1 "data/4.txt"))

(de a4-2 (F)
   (let
      (Lst
         (mapcar
            '((L)
               (head
                  4
                  (cddr (split (cdr (chop L)) " " "]" ":")) ) )
            (sort (a4-line-T F)) )
         G NIL
         F NIL
         W NIL
         R NIL
         Z NIL )
      (for L Lst
         (if (= "G" (nth L 3 1 1))
            (set 'G (format (nth L 4 2)))
            (ifn F
               (set 'F (format (car L)))
               (set 'W (dec (format (car L))))
               (a4-accuL 'R G F W)
               (off F W) ) ) )
      (mapc
         '((A) 
            (mapc
               '((B)
                  (mapc
                     '((C) (a4-accuN 'Z (car A) C)) 
                     B ) )
               (cdr A) ) )
         R )
      (setq Z
         (maxi
            cddr
            (mapcar
               '((L)
                  (cons (car L) (maxi cdr (cadr L))) )
               Z ) ) )
      (* (car Z) (cadr Z)) ) )
(test 4455 (a4-2 "data/4-test-unsorted.txt"))  
(test 4966 (a4-2 "data/4.txt"))  

# --- Day 5: Alchemical Reduction ---
(de dec0 ("N")
   (or
      (=0 (val "N"))
      (dec "N") ) )
(de a5-1 (Lst)
   (let F T
      (while F
         (off F)
         (setq Lst
            (make
               (for (L Lst L)
                  (T (= 32 (abs (- (car L) (cadr L))))
                     (++ L)
                     (++ L)
                     (chain L)
                     (on F) )
                  (link (++ L)) ) ) ) )
      (length Lst) ) )
(test 10 (a5-1 (mapcar char (chop "dabAcCaCBAcCcaDA"))))
(setq *A5-D (in "data/5.txt" (mapcar char (line))))
(test 10384 (a5-1 *A5-D))

# Should be faster:
# o) keep head, garanties no pairs in 1:head
# o) copy 1:head immediately to new list.
# o) since list keep collapse at start 1:head range
#    is low so the speed the same as a5-1.
# In practise the same bench as a5-1 -> 8secs.
# huh.
(de a5-1-faster (Lst)
   (let (F T  N 0)
      (while F
         (off F)
         (setq Lst
            (make
               (chain (head N Lst))
               (for (L (nth Lst (inc N)) L)
                  (T (= 32 (abs (- (car L) (cadr L))))
                     (++ L)
                     (++ L)
                     (dec0 'N)
                     (dec0 'N)
                     (chain L)
                     (on F) )
                  (inc 'N)
                  (link (++ L)) ) ) ) )
      (length Lst) ) )

(de a5-2 (Lst A B)
   (mini
      '((C1)
         (let
            (C2 (+ C1 32)
               Lst
               (filter
                  '((N) (and (<> N C1) (<> N C2))) 
                  Lst ) )
            (a5-1 Lst) ) )
      (range (char A) (char B)) )
   @@ )
(test 4 (a5-2 (mapcar char (chop "dabAcCaCBAcCcaDA")) 'A 'D) )
# 26*8secs
#(test 5412 (a5-2 *A5-D 'A 'Z)) 

# --- Day 6: Chronal Coordinates ---
(de a6-data (F)
   (make
      (in F
         (until (eof)
            (link
               (make
                  (link T 0 (read))
                  (char)
                  (link (read)) ) ) ) ) ) )
(de a6-data-2 (F)
   (make
      (in F
         (until (eof)
            (link
               (make
                  (link (read))
                  (char)
                  (link (read)) ) ) ) ) ) )
(de a6-1 (F)
   (let 
      (Lst (a6-data F)
         Max (prog (maxi caddr Lst) @@)
         May (prog (maxi cadddr Lst) @@) )
      (for (X 0 (> Max X) (inc X))
         (for (Y 0 (> May Y) (inc Y))
            (let L
               (sort
                  (mapcar
                     '((P)
                        (conc
                           (cons
                              (+ 
                                 (abs (- (caddr P) X))
                                 (abs (- (cadddr P) Y)) ) )
                           P ) )
                     Lst ) )
               (when (<> (caar L) (caadr L))
                  (inc (cddar L)) 
                  (when
                     (or
                        (=0 X)
                        (=0 Y)
                        (= X Max)
                        (= Y May) )
                     (set (cdar L)) ) ) ) ) )
      (cadr
         (maxi
            '((L) (and (=T (car L)) (cadr L)))
            Lst ) ) ) )
(test 17 (a6-1 "data/6-test.txt"))
(test 3660 (a6-1 "data/6.txt"))

(de a6-2 (F Lim)
   (let
      (Lst (a6-data-2 F)
         Max (prog (maxi car Lst) @@)
         May (prog (maxi cadr Lst) @@)
         S 0 )
      (for (X 0 (> Max X) (inc X))
         (for (Y 0 (> May Y) (inc Y))
            (inc 
               'S
               (if
                  (> 
                     Lim
                     (sum
                        '((P)
                           (+
                              (abs (- (car P) X))
                              (abs (- (cadr P) Y)) ) )
                        Lst ) )
                  1
                  0 ) ) ) )
      S ) )
(test 16 (a6-2 "data/6-test.txt" 32))
(test 35928 (a6-2 "data/6.txt" 10000))

# --- Day 7: The Sum of Its Parts ---
(de a7-accu ("V" K I)
   (if (assoc K (val "V"))
      (conc @ (cons I))
      (push "V" (list K I)) ) )
(de a7-data (F "A" "D")
   (in F
      (until (eof)
         (use (L2 L8)
            (read)
            (setq L2 (read))
            (do 5
               (read) )
            (setq L8 (read))
            (line)
            (a7-accu "A" L2 L8)
            (a7-accu "D" L8 L2) ) ) ) )
(de a7-data2 (F "A")
   (in F
      (until (eof)
         (use (L2 L8)
            (read)
            (setq L2 (prog (skip) (char)))
            (do 5
               (read) )
            (setq L8 (prog (skip) (char)))
            (line)
            (a7-accu "A" L2 L8) ) ) ) )
(de a7-1 (F)
   (use (A D N R)
      (a7-data F 'A 'D)
      (setq N
         (sort (diff (mapcar car A) (mapcar car D))) )
      (while N
         (let I (pop 'N)
            (push 'R I)
            (for C (cdr (assoc I A))
               (and
                  (fully
                     '((Z) (member Z R))
                     (cdr (assoc C D)) )
                  (not (member C R))
                  (push 'N C)
                  (setq N (sort N)) ) ) ) )
      (pack (reverse R)) ) )
(test "CABDFE" (a7-1 "data/7-test.txt"))
(test "CFGHAEMNBPRDISVWQUZJYTKLOX" (a7-1 "data/7.txt"))

(de a7-time (M O Tm)
   (+ (- (char M) 64) O Tm) )
(de a7-2 (F MW O)
   (let
      (W 0
         Tm 0
         Cmpl NIL
         CmplD NIL
         Blc NIL  
         Unblc NIL
         Input NIL
         Step NIL
         Will 0 )
      (a7-data2 F 'Input)
      (setq 
         Blc (mapcan '((L) (copy (cdr L))) Input)
         Unblc
         (mapcan
            '((L)
               (and 
                  (not (member (car L) Blc))
                  (cons (car L)) ) )
            Input ) )
      (while (or Blc Unblc)
         (when (setq @@ (assoc Tm CmplD))
            (for I (cdr (assoc (cadr @@) Input))
               (and (member I Blc) (setq Blc (delete I Blc)) )
               (and (not (member I Blc)) (push 'Unblc I) ) ) 
            (dec 'W)
            (push 'Cmpl (cadr @@)) )
         (do (length Unblc)
            (when (and (> MW W) Unblc)
               (inc 'W)
               (setq
                  Step (apply min Unblc)
                  Will (a7-time Step O Tm) )
               (push 'CmplD (list Will Step))
               (setq Unblc (delete Step Unblc) ) ) )
         (inc 'Tm) )
   Will ) )
(test 15 (a7-2 "data/7-test.txt" 2 0))
(test 828 'fin (a7-2 "data/7.txt" 5 60))

# --- Day 8: Memory Maneuver ---
(de a8-data (F)
   (make
      (in F
         (while (read)
            (link @) ) ) ) )
(de a8-int NIL
   (get Lst (inc 'I)) )
(de a8-tree (S)
   (default S 0)
   (let (C (a8-int)  M (a8-int))
      (do C
         (setq S (a8-tree S)) )
      (do M
         (inc 'S (a8-int)) )
      S ) )
(de a8-1 (F)
   (let (Lst (a8-data F)  I 0)
      (a8-tree) ) )
(test 138 (a8-1 "data/8-test.txt"))
(test 38567 (a8-1 "data/8.txt"))

# --- Day 9: Marble Mania ---
(de a9-shift (L)
   (let L (copy L)
      (conc (cdr L) (cons (car L))) ) )
(de a9-shift-11 NIL
   (made
      (conc (cdr (made)) (cons (car (made)))) ) )
(de a9-1 (P M)
   (let (L (list 0)  I 16  D)
      (for N M
         (if (=0 (% N 23))
            (prog
               (accu
                  'D 
                  (% N P)
                  (+ (get L I) N) )
               (inc 'I 21)
               (setq 
                  L (conc (tail 7 L) (head -8 L))
                  L (a9-shift L) ) )
            (setq L (a9-shift L))
            (conc L (cons N)) ) ) 
      (cdr (maxi cdr D)) ) )
# much faster reimplementation,
# 4-10 times faster.
(de a9-11 (P M)
   (let (I 15  D)
      (make
         (link 0)
         (for N M
            (a9-shift-11)
            (if (gt0 (% N 23))
               (link N) 
               (accu
                  'D
                  (% N P)
                  (+ (get (made) I) N) )
               (inc 'I 21)
               (made
                  (conc
                     (tail 8 (made)) (head -9 (made)) ) )
               (a9-shift-11) ) ) )
      (cdr (maxi cdr D)) ) )
(test 32     (a9-1 9 25))
(test 8317   (a9-1 10 1618))
(test 146373 (a9-1 13 7999))
(test 2764   (a9-1 17 1104))
(test 54718  (a9-1 21 6111))
(test 37305  (a9-1 30 5807))
(test (a9-1 9 25) (a9-11 9 25))
(test (a9-1 10 1618) (a9-11 10 1618))
(test (a9-1 13 7999) (a9-11 13 7999))
(test (a9-1 17 1104) (a9-11 17 1104))
(test (a9-1 21 6111) (a9-11 21 6111))
(test (a9-1 30 5807) (a9-11 30 5807))
(test 418237 (a9-11 423 71944))
# part 2, to infinity and beyond, long run
#(test 3505711612 (a9-11 423 7194400))

# --- Day 10: The Stars Align ---
(de a10-data (F)
   (make
      (in F
         (until (eof)
            (link (extract format (split (line) "," ">" "<"))) ) ) ) )
(de a10-tick ("Lst")
   (mapc
      '((L)
         (map
            '((A B) (inc B (car A)))
            (cddr L)
            L ) )
      (val "Lst") ) )
(de a10-copy (Lst)
   (mapcar copy Lst) )
(de a10-minmax (Lst)
   (let (MaxX NIL  MaxY NIL  MinX T  MinY T)
      (mapc
         '((L)
            (setq
               MaxX (max MaxX (car L))
               MaxY (max MaxY (cadr L))
               MinX (min MinX (car L))
               MinY (min MinY (cadr L)) ) )
         Lst )
      (list MinX MaxX MinY MaxY) ) )
(de a10-dimn (Lst)
   (let ((MinX MaxX MinY MaxY) (a10-minmax Lst))
      (+
         (abs (- MaxX MinX))
         (abs (- MaxY MinY)) ) ) )
(de a10-list (X Y)
   (make
      (do X
         (link
            (need Y ".") ) ) ) )
(de a10 (F)
   (let
      (Lst (a10-data F)
         D (a10-dimn Lst)
         Ticks 0
         Last T
         Save NIL )
      (while (> Last D)
         (setq 
            Last D
            Save (a10-copy Lst))
         (a10-tick 'Lst)
         (setq D (a10-dimn Lst))
         (inc 'Ticks)
         #(println Ticks Last D)
      ) # while
      (let
         ((MinX MaxX MinY MaxY) (a10-minmax Save)
            B
            (a10-list
               (inc (- MaxX MinX))
               (inc (- MaxY MinY)) ) )
         (mapc 
            '((L)
               (let
                  (X (inc (- (car L) MinX))
                     Y (inc (- (cadr L) MinY)) )
                  (set (nth B X Y) "#") ) )
            Save )
         #{ 
         # yes, rotate matrix to left 90 and print
         (for L (apply mapcar B list)
            (prinl L) )
         }#
         (dec Ticks) ) ) )
(test 3 (a10 "data/10-test.txt"))
(test 10946 (a10 "data/10.txt"))

# --- Day 11: Chronal Charge ---
(de a11-digit (N)
   (if (> 100 N)
      0
      (format (car (tail 3 (chop N)))) ) )
(de a11-power (X Y)
   (let X (+ 10 X)
      (-
         (a11-digit (* X (+ S (* Y X)))) 
         5 ) ) )
(de a11-grid NIL
   (make
      (do 300
         (link (need 300)) ) ) )
(de a11-get (X Y)
   (if (get G X Y)
      @
      (set (nth G X Y) (a11-power X Y)) ) )
(de a11-box (A B N)
   (let Sum 0
      (for (X A (> (+ A N) X) (inc X))
         (for (Y B (> (+ B N) Y) (inc Y))
            (inc 'Sum (a11-get X Y)) ) )
      Sum ) ) 
(de a11-1 (S)
   (let (G (a11-grid)  Max)
      (for X 300
         (for Y 300
            (a11-get X Y) ) )
      (for X 298
         (for Y 298
            (and
               (> (setq @@ (a11-box X Y 3)) (cddr Max))
               (setq Max (cons X Y @@)) ) ) )
      Max ) )
(test (33 45 . 29) (a11-1 18))
(test (21 61 . 30) (a11-1 42))
(test (243 68 . 28) (a11-1 8444))

# part2
(de a11-get-2 (X Y)
   (if (or (=0 X) (=0 Y))
      0
      (get G X Y) ) )
(de a11-set-2 (X Y N)
   (set
      (nth G X Y)
      (-
         (+ 
            N
            (a11-get-2 X (dec Y))
            (a11-get-2 (dec X) Y) )
         (a11-get-2 (dec X) (dec Y)) ) ) )
(de a11-box-2 (X Y Z)
   (- 
      (+
         # D
         (a11-get-2 (+ X (dec Z)) (+ Y (dec Z)))
         # A
         (a11-get-2 (dec X) (dec Y)) )
      # B
      (a11-get-2 (dec X) (+ Y (dec Z)))
      # C
      (a11-get-2 (+ X (dec Z)) (dec Y)) ) )
(de a11-minmax (X Y)
   (inc (min (- 300 X) (- 300 Y))) )
(de a11-2 (S)
   (let (G (a11-grid)  Max)
      (for X 300
         (for Y 300
            (a11-set-2 X Y (a11-power X Y)) ) )
      (for X 300
         (for Y 300
            (for Z (a11-minmax X Y)
               (and
                  (> (setq @@ (a11-box-2 X Y Z)) (cdddr Max))
                  (setq Max (cons X Y Z @@)) ) ) ) )
      Max ) )
(test (90 269 16 . 113) (a11-2 18))
(test (232 251 12 . 119) (a11-2 42))
(test (236 252 12 . 96) (a11-2 8444))

# --- Day 12: Subterranean Sustainability ---
(de a12-state (F)
   (in F (from "state: ") (line)) )
(de a12-rules (F)
   (make
      (in F
         (line T)
         (line T)
         (until (eof)
            (link
               (make
                  (chain (till " "))
                  (yoke (prog (from "=> ") (line T))) ) ) ) ) ) )
(de a12-sum (Lst)
   (let (D (/ (- (length Lst) 100) 2)  S 0)
      (for (I . L) Lst
         (and
            (= "#" L)
            (inc 'S (dec (- I D))) ) )
      S ) )
(de a12-1 (F)
   (let
      (L (a12-state F)
         R (a12-rules F)
         L
         (make
            (chain L)
            (do 20
               (do 3
                  (yoke ".") )
               (made (conc (made) (need 3 ".")))
               (made
                  (mapcon
                     '((L) 
                        (when
                           (and
                              (cddddr L)
                              (car (rassoc (head 5 L) R)) )
                           (cons @) ) )
                     (made) ) ) ) ) )
      (a12-sum L) ) )
(test 3217 (a12-1 "data/12.txt"))

# part 2, after 200 iterations pattern stabilized
(de a12-2 (F)
   (let
      (L (a12-state F)
         R (a12-rules F)
         D NIL
         P (a12-sum L)
         L
         (make
            (chain L)
            (do 200
               (do 3
                  (yoke ".") )
               (made (conc (made) (need 3 ".")))
               (made
                  (mapcon
                     '((L)
                        (when
                           (and
                              (cddddr L)
                              (car (rassoc (head 5 L) R)) )
                           (cons @) ) )
                     (made) ) )
               (push 'D (- (setq @@ (a12-sum (made))) P))
               (setq P @@) ) ) )
      # first 100 will be 80
      #(test 80 (/ (sum prog (head 100 D)) 100))
      (+ (* (- 50000000000 200) (car D)) (a12-sum L)) ) )
(test 4000000000866 (a12-2 "data/12.txt"))

# --- Day 13: Mine Cart Madness ---
(de a13-cart (X Y D)
   (push 'Carts 
      (list 
         (inc 'N)
         X
         Y
         D
         (circ 'L 'S 'R) ) ) )
(de a13-data (F)
   (let (C 1  R 1  N 0)
      (make
         (in F
            (until (eof)
               (link
                  (make
                     (until (eol)
                        (link
                           (case (char)
                              (">" (a13-cart R C 'R) '-)
                              ("<" (a13-cart R C 'L) '-)
                              ("v" (a13-cart R C 'D) '|)
                              ("\^" (a13-cart R C 'U) '|)
                              (T @) ) )
                        (inc 'C) )
                     (one C)
                     (line) ) )
               (inc 'R) ) ) ) ) )
(de a13-incR (S)
   (inc (cdr S)) )
(de a13-decR (S)
   (dec (cdr S)) )
(de a13-incC (S)
   (inc (cddr S)) )
(de a13-decC (S)
   (dec (cddr S)) )
(de a13-dir (S D)
   (set (cdddr S) D) )
(de a13-sect (S)
   (pop (cddddr S)) )
(de a13-horiz (Car)
   (if (= 'L (cadddr Car))
      (a13-decC Car)
      (a13-incC Car) ) )
(de a13-verti (Car)
   (if (= 'U (cadddr Car))
      (a13-decR Car)
      (a13-incR Car) ) )
(de a13-AD (Car)
   (case (cadddr Car)
      ("U" (a13-incC Car) (a13-dir Car 'R))
      ("L" (a13-incR Car) (a13-dir Car 'D))
      ("R" (a13-decR Car) (a13-dir Car 'U))
      ("D" (a13-decC Car) (a13-dir Car 'L)) ) )
(de a13-BC (Car)
   (case (cadddr Car)
      ("U" (a13-decC Car) (a13-dir Car 'L))
      ("R" (a13-incR Car) (a13-dir Car 'D))
      ("L" (a13-decR Car) (a13-dir Car 'U))
      ("D" (a13-incC Car) (a13-dir Car 'R)) ) )
# intersection
(de a13-plus (Car)
   (case (a13-sect Car)
      ("L"
         (case (cadddr Car)
            ("U" (a13-decC Car) (a13-dir Car 'L))
            ("D" (a13-incC Car) (a13-dir Car 'R))
            ("L" (a13-incR Car) (a13-dir Car 'D))
            ("R" (a13-decR Car) (a13-dir Car 'U)) ) )
      ("S"
         (case (cadddr Car)
            ("U" (a13-decR Car))
            ("D" (a13-incR Car))
            ("L" (a13-decC Car))
            ("R" (a13-incC Car)) ) )
      ("R"
         (case (cadddr Car)
            ("U" (a13-incC Car) (a13-dir Car 'R))
            ("D" (a13-decC Car) (a13-dir Car 'L))
            ("L" (a13-decR Car) (a13-dir Car 'U))
            ("R" (a13-incR Car) (a13-dir Car 'D)) ) ) ) )
(de a13-rest (Car)
   (filter
      '((C)
         (and (car Car) (<> (car Car) (car C))) )
      Carts ) )
(de a13-find (Car)
   (find
      '((C)
         (and
            (= (cadr C) (cadr Car))
            (= (caddr C) (caddr Car)) ) )
      (a13-rest Car) ) )
(de a13-1 (F)
   (let
      (Carts NIL
         Lst (a13-data F)
         Carts (reverse Carts)
         Coll 
         (loop
            (T
               (for Car Carts
                  (case (get Lst (cadr Car) (caddr Car))
                     ("-" (a13-horiz Car))
                     ("|" (a13-verti Car))
                     # corners: AB
                     #          CD
                     ("/"  (a13-AD Car))
                     ("\\" (a13-BC Car))
                     ("+"  (a13-plus Car)) )
                  (T (a13-find Car) @) )
               @ ) ) )
      (cons (dec (caddr Coll)) (dec (cadr Coll))) ) )
(test (7 . 3) (a13-1 "data/13-test.txt"))
(test (94 . 78) (a13-1 "data/13.txt"))

(de a13-2 (F)
   (let
      (Carts NIL
         Lst (a13-data F)
         Carts
         (by
            '((L) (cons (cadr L) (caddr L)))
            sort
            Carts))
      (loop
         (for Car Carts
            (case (get Lst (cadr Car) (caddr Car))
               ("-" (a13-horiz Car))
               ("|" (a13-verti Car))
               ("/" (a13-AD Car))
               ("\\" (a13-BC Car))
               ("+" (a13-plus Car)) )
            # disable collated
            (let? F (a13-find Car)
               (set Car)
               (set F) ) )
         # remove disabled
         (setq Carts
            (by
               '((L) (cons (cadr L) (caddr L)))
               sort
               (filter car Carts) ) )
         # last one ?
         (NIL (cdr Carts)) ) 
      (cons (dec (caddar Carts)) (dec (cadar Carts))) ) )
(test (6 . 4) (a13-2 "data/13-test-2.txt")) 
(test (26 . 85) (a13-2 "data/13.txt")) 

# --- Day 14: Chocolate Charts ---
(de a14-1 (N)
   (let
      (Len 2
         P1 0
         P2 1
         Lst
         (make
            (link 3 7)
            (do (+ N 10)
               (let S
                  (+
                     (get (made) (inc P1))
                     (get (made) (inc P2)) )
                  (when (>= S 10)
                     (link (/ S 10))
                     (inc 'Len)
                     (setq S (% S 10)) )
                  (link S)
                  (inc 'Len)
                  (setq 
                     P1
                     (%
                        (+ P1 1 (get (made) (inc P1)))
                        Len )
                     P2
                     (%
                        (+ P2 1 (get (made) (inc P2)))
                        Len ) ) ) ) ) )
   (pack (head 10 (nth Lst (inc N)))) ) )
(test "0124515891" (a14-1 5))
(test "9251071085" (a14-1 18))
(test "5941429882" (a14-1 2018))
# ~200secs.
#(test "3410710325" (a14-1 330121))

# --- Day 15: Beverage Bandits ---
(de a15-read (F)
   (make (in F (while (line) (link @)))) )
(de a15-grid-set (Grid Lst)
   (mapc
      '((G L)
         (mapc
            '((This Val)
               (case Val
                  ("#"
                     (with (: 0 1 1) (con (: 0 1)))    # W
                     (with (: 0 1 -1) (set (: 0 1)))   # E
                     (with (: 0 -1 1) (con (: 0 -1)))  # S
                     (with (: 0 -1 -1) (set (: 0 -1))) # N
                     (set This) )
                  (("E" "G")
                     (=: piece @)
                     (=: points 200) ) ) )
            G
            L ) )
         Grid
         (apply mapcar (reverse Lst) list) ) )
(de a15-grid-remove (Grid)
   (for G Grid
      (for This G
         (removeprops This) ) ) )
(de a15-grid-display (Grid)
   (for G (flip (apply mapcar Grid list))
      (for This G
         (prin
            (cond
               ((not (val This)) "#")
               ((: piece) (car @))
               (T ".") ) ) )
      (a15-prin-stat G)
      (prinl) ) )
(de a15-prin-stat (Lst)
   (for This Lst
      (when (: piece)
         (prin (: points) " ") ) ) )
(de removeprops (This)
   (=: points)
   (=: piece) )
(de move (This Goal)
   (put Goal 'points (: points))
   (put Goal 'piece  (: piece))
   (removeprops This) )
(de attack (This)
   (dec (:: points) 3)
   (when (le0 (: points))
      (removeprops This) ) )
(de select-attack (This)
   (let (I (: piece)  A (a15-enemy I))
      (caar
         (by
            cdr
            sort
            (mapcan
               '((Dir N)
                  (with (Dir This)
                     (and
                        (= (: piece) A)
                        (cons (list This (: points) N)) ) ) )
               '(north west east south)
               (1 2 3 4) ) ) ) ) )
# stollen code from rosetta, fat&slow
# and I cant implement better
(de bfs (This Goal)
   (let (Path NIL  Best NIL)
      (recur (This Path)
         (when (and This (not (: mark)) (not (: piece)))
            (push 'Path This)
            (if (== Goal This)
               (unless (and Best (>= (length Path) (length Best)))
                  (setq Best Path) )
               (=: mark T)
               (recurse (north This) Path)
               (recurse (west This) Path)
               (recurse (east This) Path)
               (recurse (south This) Path)
               (=: mark NIL) ) ) )
      Best ) )
(de a15-enemy (U)
   (if (= U "E") "G" "E") )
# skip move if near enemy
(de intersect (Lst Enem)
   (sect
      (mapcar car Lst)
      Enem ) )
(de one-type-piece? (Grid)
   (let R NIL
      (for G Grid
         (for This G
            (and (: piece) (accu 'R @ 1)) ) )
      (cdr R) ) )
# '((c3 2) (d2 3)) (c5 f3 g2)
(de select-move (My Adjs)
   (caar
      (by
         '((L) (reverse (cdr L))) # LOL
         sort
         (mapcan
            '((M)
               (let L
                  (mapcan
                     '((A)
                        (and (bfs (car M) A) (cons (length @))) )
                     Adjs )
                  (when L
                     (cons (append M (cons (apply min L)))) ) ) )
            My ) ) ) )
# '((b4 . "E") (c2 . "G"))
(de new-round (Grid)
   (make
      (for G (flip (apply mapcar Grid list))
         (for This G
            (and (: piece) (link (cons This @))) ) ) ) )
(de adjacentMy (This)
   (mapcan
      '((Dir N)
         (with (Dir This)
            (and (val This) (list (list This N))) ) )
      '(north west east south)
      '(1 2 3 4) ) )
(de adjacent (This)
   (mapcan
      '((Dir)
         (with (Dir This) (and (val This) (cons This))) )
      '(north west east south) ) )
(de enemies (X Grid)
   (let A (a15-enemy X)
      (make
         (for G (flip (apply mapcar Grid list))
            (for This G
               (and (= (: piece) A) (link This) ) ) ) ) ) )
(de enemies-adj (Lst)
   (mapcan adjacent Lst) )
(de a15-1 (F)
   (let
      (Lst (a15-read F)
         Grid (grid (length (car Lst)) (length Lst))
         Rounds 0 )
      (a15-grid-set Grid Lst) 
      (catch 'exit
         (loop
            (for L (new-round Grid) # '((a2 . "G") (c3 . "E"))
               (NIL (one-type-piece? Grid) (throw 'exit))
               (when (with (car L) (: piece))      # unit still alive?
                  (let (My (adjacentMy (car L))  Enem (enemies (cdr L) Grid)  NextMove)
                     # no enemies near, moving
                     (unless (intersect My Enem)
                        (let Adjs (enemies-adj Enem)
                           (setq NextMove (select-move My Adjs))
                           (when NextMove
                              (move (car L) NextMove)
                              # if moved, update position for attack next
                              (set
                                 L NextMove
                                 'My (adjacentMy NextMove) ) ) ) )
                     # somebody found, attack one
                     (when (intersect My Enem)
                        (attack (select-attack (car L))) ) ) ) )
            (inc 'Rounds) ) )
      (prog1
         (*
            Rounds
            (sum
               '((G)
                  (sum '((This) (: points)) G))
               Grid ) )
         (a15-grid-remove Grid) ) ) )
(test 27730 (a15-1 "data/15-test-6.txt"))
(test 36334 (a15-1 "data/15-test-7.txt"))
(test 39514 (a15-1 "data/15-test-8.txt"))
(test 27755 (a15-1 "data/15-test-9.txt"))
(test 28944 (a15-1 "data/15-test-10.txt"))
(test 18740 (a15-1 "data/15-test-11.txt"))

--- Day 16: Chronal Classification ---
(setq
   Funcs
   '(mulr muli addi addr seti setr
      banr bani borr bori gtir gtri
      gtrr eqir eqri eqrr ) )
(de a16-link4 NIL
   (make
      (do 4
         (link (read))) ) )
(de a16-read-1 (F)
   (make
      (in F
         (until (eof)
            (link
               (make
                  (link 0)
                  (from "[")
                  (link (a16-link4))
                  (line)
                  (link (a16-link4))
                  (from "[")
                  (link (a16-link4))
                  (line) ) ) ) ) ) )
(de regA NIL
   (get Lst 2 (inc (get Lst 3 2))) )
(de valA NIL
   (get Lst 3 2) )
(de regB NIL
   (get Lst 2 (inc (get Lst 3 3))) )   
(de valB NIL
   (get Lst 3 3) ) 
(de regC NIL
   (nth Reg (inc (get Lst 3 4))) )
(de setC (X)
   (let Reg (copy (get Lst 2))
      (set (regC)
         (cond ((=T X) 1) ((not X) 0) (T X)) )
      (=inc) ) )
(de =inc NIL
   (and (= Reg (get Lst 4)) (inc Lst)) )
(de mulr (Lst)
   (setC (* (regA) (regB))) )
(de muli (Lst)
   (setC (* (regA) (valB))) )
(de addi (Lst)
   (setC (+ (regA) (valB))) )
(de addr (Lst)
   (setC (+ (regA) (regB))) )
(de seti (Lst)
   (setC (valA)) )  
(de setr (Lst)
   (setC (regA)) )
(de banr (Lst)
   (setC (& (regA) (regB))) )
(de bani (Lst)
   (setC (& (regA) (valB))) )
(de borr (Lst)
   (setC (| (regA) (regB))) )
(de bori (Lst)
   (setC (| (regA) (valB))) )
(de gtir (Lst)
   (setC (> (valA) (regB))) )
(de gtri (Lst)
   (setC (> (regA) (valB))) )
(de gtrr (Lst)
   (setC (> (regA) (regB))) )
(de eqir (Lst)
   (setC (= (valA) (regB))) )
(de eqri (Lst)
   (setC (= (regA) (valB))) )
(de eqrr (Lst)
   (setC (= (regA) (regB))) )
(de a16-1 (F)
   (let Runs (a16-read-1 F)
      (mapc
         '((A)
            (mapc
               '((C) (C A))
               Funcs ) )
         Runs )
      (cnt '((L) (>= (car L) 3)) Runs) ) )
## XXX
(test 1 (a16-1 "data/16-test-1.txt"))
(test 547 (a16-1 "data/16-part1.txt"))
(test 10 (a16-1 "data/16-part1-1.txt"))

# part2
(setq Undefs  '(valA valB regA regB regC setC))
(setq RunCode '(valA1 valB1 regA1 regB1 regC1 setC1))
(for U Undefs (undef U)) # recreate world
(de a16-read-code (C)
   (in C
      (make
         (until (eof)
            (link
               (a16-link4) ) ) ) ) )
(de regA NIL
   (get Lst 2 (inc (get Lst 1 2))) )
(de regA1 NIL
   (get Reg (inc (get Lst 2))) )
(de valA NIL
   (get Lst 1 2) )
(de valA1 NIL
   (get Lst 2) )
(de regB NIL
   (get Lst 2 (inc (get Lst 1 3))) )
(de regB1 NIL
   (get Reg (inc (get Lst 3))) )
(de valB NIL
   (get Lst 1 3) )
(de valB1 NIL
   (get Lst 3) )
(de regC NIL
   (nth Reg (inc (get Lst 1 4))) )
(de regC1 NIL
   (nth Reg (inc (get Lst 4))) )
(de setC (X)
   (let Reg (copy (get Lst 2))
      (set (regC)
         (cond ((=T X) 1) ((not X) 0) (T X)) )
      (= Reg (get Lst 3)) ) )
(de setC1 (X)
   (set (regC)
      (cond ((=T X) 1) ((not X) 0) (T X)) ) )
(test T (mulr '((9 2 1 2) (3 2 1 1) (3 2 2 1))))
(test T (addi '((9 2 1 2) (3 2 1 1) (3 2 2 1))))
(test T (seti '((9 2 1 2) (3 2 1 1) (3 2 2 1))))
(de a16-read-2 (F)
   (make
      (in F
         (until (eof)
            (link
               (make
                  (from "[")
                  (link (a16-link4))
                  (line)
                  (yoke (a16-link4))
                  (from "[")
                  (link (a16-link4))
                  (line) ) ) ) ) ) )
(de makeD NIL
   (make
      (for N (range 0 15)
         (link (list N 'NIL)) ) ) )
(de a16-2 (F C)
   (let
      (Runs (a16-read-2 F)
         Code (a16-read-code C)
         Dict (makeD)
         PC NIL ) 
      (for R Runs
         (push (cdr (assoc (caar R) Dict)) R) )
      (do 16
         (let 
            Pick
            (pick
               '((F)
                  (when F
                     (let R NIL
                        (mapc
                           '((D)
                              (and
                                 D
                                 (fully '((L) (F L)) (cadr D))
                                 (push 'R (car D)) ) )
                           Dict )
                        (unless (cdr R) (cons (car R) F)) ) ) )
               Funcs )
            (push 'PC Pick)
            (set
               (member (cdr Pick) Funcs) NIL
               (nth Dict (inc (car Pick))) NIL ) ) )
      # I have to recreate VM world third time
      # "Code" will run on "PC" and "Reg" need new handle
      (for U Undefs
         (undef U) )
      (mapc def Undefs RunCode)
      (let Reg (need 4 0)
         (for C Code
            ((cdr (assoc (car C) PC)) C) )
         (car Reg) ) ) )
(test 582 (a16-2 "data/16-part1.txt" "data/16-part2.txt"))
         
# --- Day 17: Reservoir Research ---

# --- Day 18: Settlers of The North Pole ---
(de a18-read (F)
   (make (in F (while (line) (link @)))) )
(de a18-set (Grid Lst)
   (mapc
      '((G L)
         (mapc
            '((This Val)
               (=:
                  unit
                  (case Val
                     ("." 0)
                     ("|" 1)
                     ("#" T) ) ) ) 
            G
            L ) )
      Grid
      (apply mapcar (reverse Lst) list) ) )
(de a18-disp (Grid)
   (prinl)
   (for G (flip (apply mapcar Grid list))
      (for This G
         (prin
            (case (: unit)
               (0 ".")
               (1 "|")
               (T "#") ) ) )
      (prinl) ) )
(de a18-1 (F N)
   (let
      (Lst (a18-read F)
         Grid (grid (length (car Lst)) (length Lst))
         C (need 2 0) )
      (a18-set Grid Lst)
      (do N
         (for G Grid
            (for This G
               (let R NIL
                  (mapc
                     '((Dir)
                        (accu 'R (get (Dir This) 'unit) 1) )
                     (quote
                        west east south north
                        ((X) (south (west X)))
                        ((X) (north (west X)))
                        ((X) (south (east X)))
                        ((X) (north (east X))) ) )
                  (=: next
                     (case (: unit)
                        (0
                           (if (>= (cdr (assoc 1 R)) 3) 1 0) )
                        (1
                           (if (>= (cdr (assoc T R)) 3) T 1) )
                        (T
                           (if
                              (and
                                 (>= (cdr (assoc 1 R)) 1)
                                 (>= (cdr (assoc T R)) 1) )
                              T
                              0 ) ) ) ) ) ) )  
         (for G Grid
            (for This G
               (=: unit (: next)) ) ) )
      (for G Grid
         (for This G
            (if2 (=T (: unit)) (=1 (: unit))
               NIL
               (inc C)
               (inc (cdr C)) ) ) )
      (apply * C) ) )
(test 1147 (a18-1 "data/18-test.txt" 10))
(test 584714 (a18-1 "data/18.txt" 10))
# to infinity and beyond
#(a18-1 "data/18.txt" 1000000000))

}#

# --- Day 19: Go With The Flow ---            



(msg 'OK-AoC18)
(bye)
