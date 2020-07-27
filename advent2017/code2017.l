`(== 64 64)
(load "@lib/simul.l")

# --- Day 1: Inverse Captcha ---
(de f1-1 (Lst)
   (let Lst (append Lst (cons (car Lst)))
      (sum
         prog
         (mapcon
            '((L)
               (and
                  (= (car L) (cadr L))
                  (cons (car L)) ) )
            Lst ) ) ) )
(test 3 (f1-1 (1 1 2 2)))
(test 4 (f1-1 (1 1 1 1)))
(test 0 (f1-1 (1 2 3 4)))
(test 9 (f1-1 (9 1 2 1 2 1 2 9)))

(in "data/1.txt"
   (test 1223 (f1-1 (mapcar format (chop (read))))) )

(de f1-2 (Lst)
   (let N (inc (/ (length Lst) 2))
      (sum
         prog
         (mapcon
            '((A B)
               (and
                  (= (car A) (get B N))
                  (cons (car A)) ) )
            Lst
            (apply circ Lst) ) ) ) )
(test 6  (f1-2 (1 2 1 2)))
(test 0  (f1-2 (1 2 2 1)))
(test 4  (f1-2 (1 2 3 4 2 5)))
(test 12 (f1-2 (1 2 3 1 2 3)))
(test 4  (f1-2 (1 2 1 3 1 4 1 5)))

(in "data/1.txt"
   (test 1284 (f1-2 (mapcar format (chop (read))))) )

# --- Day 2: Corruption Checksum ---
(de f2-1 (Lst)
   (sum
      '((L) (- (apply max L) (apply min L)))
      Lst ) )
(test
   18
   (f2-1 '((5 1 9 5) (7 5 3) (2 4 6 8))) )

(in "data/2.txt"
   (test
      53460
      (f2-1
         (make
            (do 16
               (link (make (do 16 (link (read))))) ) ) ) ) )

(de f2-2 (Lst)
   (sum
      prog
      (mapcan
         '((L)
            (mapcon
               '((Y)
                  (and
                     (find
                        '((N) (=0 (% (car Y) N)))
                        (cdr Y) )
                     (cons (/ (car Y) @)) ) )
               L ) )
         Lst ) ) )

(in "data/2.txt"
   (test
      282
      (f2-2
         (make
            (do 16
               (link (flip (sort (make (do 16 (link (read))))))) ) ) ) ) )

# --- Day 3: Spiral Memory ---
#
# (f3-1) Nothing to code.
# Solved by hands, hints:
# o) find last rightest bottom corner (** 515 2) = 265225
# o) so matrix 515x515
# o) find position of end point (center of matrix) (258, 258)
# o) find position in matrix of start point
#    (515, (- 265225 265149)) = (515, 439)
# o) calculate steps: (+ (- 515 258) (- 439 258)) = 438

(de f3-2 NIL
   (let
      (G (grid 9 9)
         This (get G 5 5)
         A 1
         Dir '(north west south east .) )
      (=: val A)
      (while (>= 265149 A)
         (setq This ((car Dir) This))
         (setq A
            (=: val
               (sum
                  '((D) (with (D This) (: val)))
                  '(west east south north
                     ((X) (south (west X)))
                     ((X) (north (west X)))
                     ((X) (south (east X)))
                     ((X) (north (east X))) ) ) ) )
         (or
            (with ((car Dir) This) (: val))
            (with ((cadr Dir) This) (: val))
            (pop 'Dir) ) )
      A ) )
(test 266330 (f3-2))

# --- Day 4: High-Entropy Passphrases ---
(de f4-1 (F)
   (let C 0
      (in F
         (until (eof)
            (let R NIL
               (and
                  (loop
                     (T (eol) T)
                     (T (num? (accu 'R (read) 1)) (nil (line))) )
                  (inc 'C)
                  (char) ) ) ) )
      C ) )
(test 451 (f4-1 "data/4.txt"))

(de f4-2 (F)
   (let C 0
      (in F
         (until (eof)
            (let R NIL
               (and
                  (loop
                     (T (eol) T)
                     (T (num? (accu 'R (sort (chop (read))) 1))
                        (nil (line)) ) )
                  (inc 'C)
                  (char) ) ) ) )
      C ) )
(test 223 (f4-2 "data/4.txt"))


# --- Day 5: A Maze of Twisty Trampolines, All Alike ---
(de f5-1 (L)
   (let (S 0  I 1  Len (length L))
      (while (>= Len I)
         (inc 'S)
         (inc
            (nth
               L
               (swap 'I (+ I (get L I))) ) ) )
      S ) )
(test 5 (f5-1 (0 3 0 1 -3)))

(in "data/5.txt"
   (test
      343364
      (f5-1
         (make
            (until (eof) (link (read))) ) ) ) )
(de f5-2 (L)
   (let (S 0  I 1  Len (length L))
      (while (>= Len I)
         (let @@ (get L I)
            (inc 'S)
            ((if (>= @@ 3) dec inc)
               (nth L (swap 'I (+ I @@))) ) ) )
      S ) )
(test 10 (f5-2 (0 3 0 1 -3)))

(in "data/5.txt"
   (test
      25071947
      (f5-2
         (make
            (until (eof) (link (read))) ) ) ) )

# --- Day 6: Memory Reallocation ---
(de f6-1 (Lst)
   (let (S 0  Len (length Lst)  R)
      (until (num? (accu 'R (copy Lst) 1))
         (let
            (Idx (index (apply max Lst) Lst)
               N (get Lst Idx) )
            (inc 'S)
            (set (nth Lst Idx) 0)
            (while (gt0 N)
               (dec 'N)
               (inc
                  (nth
                     Lst
                     (inc (% (swap 'Idx (inc Idx)) Len)) ) ) ) ) )
      S ) )
(test 5 (f6-1 (0 2 7 0)))
(test
   12841
   (f6-1 (4 10 4 1 8 4 9 14 5 1 14 15 0 15 3 5)) )

(de f6-2 (Lst)
   (let (S 0  Len (length Lst)  R)
      (until (= 3 (accu 'R (copy Lst) 1))
         (let
            (Idx (index (apply max Lst) Lst)
               N (get Lst Idx) )
            (inc 'S)
            (set (nth Lst Idx) 0)
            (while (gt0 N)
               (dec 'N)
               (inc
                  (nth
                     Lst
                     (inc (% (swap 'Idx (inc Idx)) Len)) ) ) ) ) )
      S ) )
(test
   8038
   (-
      (f6-2 (4 10 4 1 8 4 9 14 5 1 14 15 0 15 3 5))
      (f6-1 (4 10 4 1 8 4 9 14 5 1 14 15 0 15 3 5))) )

# --- Day 7: Recursive Circus ---
(de f7-1 (F)
   (let R NIL
      (in F
         (until (eof)
            (accu 'R (read) 1)
            (from "\)")
            (if (= "^J" (peek))
               (line)
               (from "> ")
               (mapc
                  '((W) (accu 'R (pack (clip W)) 1))
                  (split (line) ",") ) ) ) )
      R ) )
(test
   '(tknk . 1)
   (rassoc 1 (f7-1 "data/7-test.txt")) )
(test
   '(cqmvs . 1)
   (rassoc 1 (f7-1 "data/7.txt") ) )

(setq
   F7D
   (make
      (in "data/7.txt"
         (until (eof)
            (link
               (mapcar
                  '((L) (if (format L) @ (pack L)))
                  (filter
                     prog
                     (split (line) ">" " " "," ")" "(" "-"]
(de f7-2-sum (L)
   (cond
      ((not L) 0)
      ((atom L)
         (let A (assoc L F7D)
            (ifn (cddr A)
               (cadr A)
               (+
                  (cadr A)
                  (f7-2-sum (caddr A))
                  (f7-2-sum (cdddr A)) ) ) ) )
      (T (+ (f7-2-sum (car L)) (f7-2-sum (cdr L)))) ) )
(de f7-2 NIL
   (let (D NIL  R NIL  B 'cqmvs  S 0)
      (loop
         (mapc
            '((W) (accu 'D (cdr W) 1))
            (setq R
               (mapcar
                  '((W) (cons W (f7-2-sum W)))
                  (cddr (setq @@ (assoc B F7D))) ) ) )
         (NIL (cdr D)) # finish
         (setq
            D (by cdr sort D)
            S (- (caadr D) (caar D))
            # set new search tree
            B (car (rassoc (car (rassoc 1 D)) R)) )
         (off D) )
      (cons (head 2 @@) S) ) )
(test
   '(("vmttcwe" 2318) . -8)
   (f7-2) )

# --- Day 8: I Heard You Like Registers ---
(de f8-1-2 (F) # both parts
   (let (Dir NIL  M 0)
      (in F
         (until (eof)
            (use (D DC DC S SC SN)
               (setq
                  D (read)
                  DC (read)
                  DN (read) )
               (or
                  (assoc D Dir)
                  (push 'Dir (list D 0)) )
               (from "if")
               (setq S (read))
               (or
                  (assoc S Dir)
                  (push 'Dir (list S 0)) )
               (skip)
               (case (peek)
                  ("=" (setq SC "=") (read))
                  ("!" (setq SC "<>") (read))
                  (T (setq SC (read))) )
               (setq SN (read))
               (and
                  ((intern SC) (cadr (assoc S Dir)) SN)
                  (setq @@ ((intern DC) (cdr (assoc D Dir)) DN))
                  (> @@ M)
                  (setq M @@) )
               (line) ) ) )
      (cons (car (flip (by cadr sort Dir))) M) ) )
(test '((a 1) . 10) (f8-1-2 "data/8-test.txt"))
(test '((j 4066) . 4829) (f8-1-2 "data/8.txt"))

# --- Day 9: Stream Processing ---
(de f9-1-2 (F) # both parts
   (let (S 0  C 0  B 0  G NIL)
      (in F
         (until (eof)
            (case (char)
               ("{" (if G (inc 'C) (inc 'B)))
               ("}"
                  (if G
                     (inc 'C)
                     (inc 'S B)
                     (dec 'B) ) )
               ("<" (if G (inc 'C) (on G)))
               (">" (if G (off G) (inc 'C)))
               ("!" (and G (char)))
               (T (and G (inc 'C))) ) ) )
      (cons S C) ) )
(test (1 . 0) (f9-1-2 "data/9-test-1.txt"))
(test (6 . 0) (f9-1-2 "data/9-test-2.txt"))
(test (5 . 0) (f9-1-2 "data/9-test-3.txt"))
(test (16 . 0) (f9-1-2 "data/9-test-4.txt"))
(test (1 . 4) (f9-1-2 "data/9-test-5.txt"))
(test (9 . 8) (f9-1-2 "data/9-test-6.txt"))
(test (9 . 0) (f9-1-2 "data/9-test-7.txt"))
(test (3 . 17) (f9-1-2 "data/9-test-8.txt"))
(test (11898 . 5601) (f9-1-2 "data/9.txt"))

# --- Day 10: Knot Hash ---
(de f10-1 (N Lens)
   (let
      (C 1
         S 0
         Lst (apply circ (range 0 N))
         L (inc N) )
      (for N Lens
         (let Y C
            (inc 'C N)
            (inc 'C (swap 'S (inc S)))
            (and
               (> C L)
               (setq C (inc (% (dec C) L))) )
            (maplist
               '((S D) (set D (car S)))
               (flip (head N (nth Lst Y)))
               (nth Lst Y) ) ) )
      (* (car Lst) (cadr Lst)) ) )
(test 12 (f10-1 4 (3 4 1 5)))
(test
   38415
   (f10-1
      255
      (189 1 111 246 254 2 0 120 215 93 255 50 84 15 94 62) ) )

(de f10-2 (Lens)
   (let
      (C 1
         S 0
         Lst (apply circ (range 0 255))
         L 256
         Lens (append Lens (list 17 31 73 47 23)) )
      (do 64
         (for N Lens
            (let Y C
               (inc 'C N)
               (inc 'C (swap 'S (inc S)))
               (and
                  (> C L)
                  (setq C (inc (% (dec C) L))) )
               (maplist
                  '((S D) (set D (car S)))
                  (flip (head N (nth Lst Y)))
                  (nth Lst Y) ) ) ) )
      (lowc
         (pack
            (mapcar
               '((B) (pad 2 (hex B)))
               (make
                  (do 16
                     (link (apply x| (cut 16 'Lst))) ) ) ) ) ) ) )
(test
   "a2582a3a0e66e6e86e3812dcb672a272"
   (f10-2) )
(test
   "33efeb34ea91902bb2f59c9920caa6cd"
   (f10-2 (mapcar char (chop "AoC 2017"))) )
(test
   "3efbe78a8d82f29979031a4aa0b16a9d"
   (f10-2 (mapcar char (chop "1,2,3"))) )
(test
   "63960835bcdc130f0b66d7ff4f6a5a8e"
   (f10-2 (mapcar char (chop "1,2,4"))) )
(test
   "9de8846431eef262be78f590e39a4848"
   (f10-2
      (mapcar
         char
         (chop "189,1,111,246,254,2,0,120,215,93,255,50,84,15,94,62") ) ) )

# --- Day 11: Hex Ed ---
# https://www.redblobgames.com/grids/hexagons/
(de f11-1-2 (F)
   (let (B (list 0 0) M 0)
      (in F
         (until (eof)
            (case (till ",^J" T)
               ("nw" (dec B))
               ("n"  (dec (cdr B)))
               ("ne" (inc B) (dec (cdr B)))
               ("sw" (dec B) (inc (cdr B)))
               ("s"  (inc (cdr B)))
               ("se" (inc B)) )
            (and
               (> (setq @@ (apply max B)) M)
               (setq M @@) )
            (char) ) )
      (cons (apply max B) M) ) )
(test (743 . 1493) (f11-1-2 "data/11.txt"))

# --- Day 12: Digital Plumber ---
(setq F12D
   (quote (0 2) (1 1)
      (2 0 3 4) (3 2 4)
      (4 2 3 6) (5 6) (6 4 5) ) )

(de f12-kids (L D V)
   (cond
      ((not L))
      ((atom L)
         (unless (member L V)
            (let
               (V (append V (cons L))
                  B (cdr (assoc L D)) )
               (sort
                  (uniq
                     (conc
                        (cons L)
                        (f12-kids (car B) D V)
                        (f12-kids (cdr B) D V) ) ) ) ) ) )
      (T
         (conc
            (f12-kids (car L) D V)
            (f12-kids (cdr L) D V) ) ) ) )
(test (f12-kids 0 F12D) (f12-kids 3 F12D))

(de f12-0 (L D V)
   (cond
      ((not L))
      ((atom L)
         (unless (member L V)
            (let
               (V (append V (cons L))
                  B (cdr (assoc L D)) )
               (or
                  (find =0 B)
                  (f12-0 (car B) D V)
                  (f12-0 (cdr B) D V) ) ) ) )
      (T
         (or
            (f12-0 (car L) D V)
            (f12-0 (cdr L) D V) ) ) ) )
(test 0   (f12-0 0 F12D))
(test NIL (f12-0 1 F12D))
(test 0   (f12-0 2 F12D))
(test 0   (f12-0 3 F12D))
(test 0   (f12-0 4 F12D))
(test 0   (f12-0 5 F12D))
(test 0   (f12-0 6 F12D))

(de f12-1-2 (F N)
   (let
      (C 1
         G 1
         GS NIL
         D
         (make
            (in F
               (until (eof)
                  (link
                     (make
                        (link (read))
                        (from ">")
                        (until (eol)
                           (link (read)) ) ) ) ) ) ) )
      (for X N
         (if (f12-0 X D)
            (inc 'C)
            (and
               (lst? (accu 'GS (f12-kids X D) 1))
               (inc 'G) ) ) )
      (cons C G) ) )
(test (6 . 2) (f12-1-2 "data/12-test.txt" 6))
(test (239 . 215) (f12-1-2 "data/12.txt" 1999))

# --- Day 13: Packet Scanners ---
(de f13-1-2 (F) # stolen
   (let
      (I 1
         D
         (make
            (in F
               (until (eof)
                  (link
                     (make
                        (link (format (till ":" T)))
                        (char)
                        (link (setq @ (format (line T))))
                        (link (- (* 2 @) 2)) ) ) ) ) ) )
      (cons
         (sum
            '((L)
               (and
                  (=0 (% (car L) (caddr L)))
                  (* (car L) (cadr L)) ) )
            D )
         (until
            (fully
               '((L)
                  (n0 (% (+ I (car L)) (caddr L))) )
               D )
            (inc 'I) ) ) ) )
(test (24 . 10) (f13-1-2 "data/13-test.txt"))
(test (1588 . 3865118) (f13-1-2 "data/13.txt"))

# --- Day 14: Disk Defragmentation ---
(de f14-hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de f14-1 (Str)
   (let S 0
      (for (I 0 (>= 127 I) (inc I))
         (let Str
            (mapcan
               '((N) (mapcar format (chop (bin N))))
               (f14-hex2L
                  (f10-2 (mapcar char (chop (pack Str "-" I)))) ) )
            (inc 'S (cnt =1 Str)) ) ) ) )
(test 8108 (f14-1 "flqrgnkx"))
(test 8230 (f14-1 "hfdlxzhv"))

(de f14-2 (Str)
   (let
      (Lst
         (make
            (for (I 0 (>= 127 I) (inc I))
               (link
                  (mapcan
                     '((N) (mapcar format (chop (pad 8 (bin N)))))
                     (f14-hex2L
                        (f10-2 (mapcar char (chop (pack Str "-" I)))) ) ) ) ) )
         Grid (grid 128 128)
         C 0 )
      (mapc
         '((G L)
            (mapc
               '((This Val) (and (=1 Val) (=: V T)))
               G
               L ) )
         Grid
         Lst )
      (for Col Grid
         (for This Col
            (when (=T (: V))
               (inc 'C)
               (recur (This)
                  (when (and This (=T (: V)))
                     (=: V 0)
                     (recurse (west This))
                     (recurse (east This))
                     (recurse (south This))
                     (recurse (north This)) ) ) ) ) )
      C ) )
(test 1242 (f14-2 "flqrgnkx"))
(test 1103 (f14-2 "hfdlxzhv"))

# --- Day 15: Dueling Generators ---
(de f15-1 (A B)
   (let C 0
      (do 40000000
         (and
            (=
               (&
                  (swap 'A (% (* A 16807) 2147483647))
                  `(hex "FFFF") )
               (&
                  (swap 'B (% (* B 48271) 2147483647))
                  `(hex "FFFF") ) )
            (inc 'C) ) )
      C ) )
(test 588 (f15-1 65 8921))
(test 631 (f15-1 873 583))

(de f15-2 (A B)
   (let C 0
      (do 5000000
         (until (=0 (% (setq A (% (* A 16807) 2147483647)) 4)))
         (until (=0 (% (setq B (% (* B 48271) 2147483647)) 8)))
         (and
            (= (& A `(hex "FFFF")) (& B `(hex "FFFF")))
            (inc 'C) ) )
      C ) )
(test 309 (f15-2 65 8921))
(test 279 (f15-2 873 583))

# --- Day 16: Permutation Promenade ---
(de f16-1 (F)
   (let L '(a b c d e f g h i j k l m n o p)
      (in F
         (until (eof)
            (case (char)
               ("s" (do (read) (rot L)))
               ("x"
                  (swap
                     (nth
                        L
                        (setq @
                           (prog1 (inc (format (till "/" T))) (char)) ) )
                     (swap (nth L (inc (read))) (get L @)) ) )
               ("p"
                  (swap
                     (nth
                        L
                        (setq @ (index (prog1 (char) (char)) L)) )
                     (swap
                        (nth L (index (char) L))
                        (get L @) ) ) ) )
            (char) ) )
      (intern (pack L)) ) )
(test 'iabmedjhclofgknp (f16-1 "data/16.txt"))

(de f16-2 (F)
   (let
      (L '(a b c d e f g h i j k l m n o p)
         Dir
         (make
            (in F
               (until (eof)
                  (case (char)
                     ("s" (link (make (link 0 (read)))))
                     ("x"
                        (link
                           (make
                              (link
                                 1
                                 (prog1 (inc (format (till "/" T))) (char))
                                 (inc (read)) ) ) ) )
                     ("p"
                        (link
                           (make (link 2 (prog1 (char) (char)) (char))) ) ) ) ) ) ) )
      (do 1000 # not 1B times, XXX !!!
         (for D Dir
            (case (car D)
               (0 (do (cadr D) (rot L)))
               (1
                  (swap
                     (nth L (cadr D))
                     (swap
                        (nth L (caddr D))
                        (get L (cadr D)) ) ) )
               (2
                  (swap
                     (nth L (setq @ (index (cadr D) L)))
                     (swap
                        (nth L (index (caddr D) L))
                        (get L @) ) ) ) ) ) )
      (intern (pack L)) ) )
(test 'oildcmfeajhbpngk (f16-2 "data/16.txt"))

# --- Day 17: Spinlock ---
(de f17-1 (N)
   (let (C 1  L (list 0))
      (for X 2017
         (setq
            C (inc (% (dec (+ C N)) X))
            L (insert (inc 'C) L X) ) )
      (get L (inc C)) ) )
(test 638 (f17-1 3))
(test 2000 (f17-1 354))

(de f17-2 (N)
   (let (C 1  Z)
      (for X 50000000
         (setq C (inc (% (dec (+ C N)) X)))
         (and
            (= 2 (inc 'C))
            (setq Z X) ) )
      Z ) )
(test 10242889 (f17-2 354))

# --- Day 18: Duet ---
(de f18-1 (F)
   (let
      (P
         (make
            (in F
               (until (eof)
                  (link (make (until (eol) (link (read)))))
                  (char) ) ) )
         PL (length P)
         I 1
         R NIL
         S 0 )
      (while
         (and
            (> PL I)
            (f18-exec (get P I)) ) )
      S ) )
(de f18-init (Lst)
   (for L Lst
      (or
         (num? L)
         (assoc L R)
         (push 'R (list L 0)) ) ) )
(de f18-eval (A)
   (if (num? A) @ (cadr (assoc A R))) )
(de f18-exec (L)
   (f18-init (cdr L))
   (prog1
      (case (car L)
         ("set"
            (set (cdr (assoc (cadr L) R))
               (f18-eval (caddr L)) ) )
         ("add"
            (inc
               (cdr (assoc (cadr L) R))
               (f18-eval (caddr L)) ) )
         ("mul"
            (set (cdr (assoc (cadr L) R))
               (*
                  (cadr (assoc (cadr L) R))
                  (f18-eval (caddr L)) ) ) )
         ("mod"
            (set (cdr (assoc (cadr L) R))
               (%
                  (cadr (assoc (cadr L) R))
                  (f18-eval (caddr L)) ) ) )
         ("snd" (set 'S (f18-eval (cadr L))))
         ("rcv" (or (gt0 (f18-eval (cadr L)))))
         ("jgz"
            (if (gt0 (f18-eval (cadr L)))
               (inc 'I (caddr L))
               (inc 'I) ) ) )
      (or (= "jgz" (car L)) (inc 'I)) ) )
(test 4 (f18-1 "data/18-test.txt"))
(test 4601 (f18-1 "data/18.txt"))

# part 2
(de f18-generic (L)
   (case (car L)
      ("set"
         (set
            (cdr (assoc (cadr L) R))
            (f18-eval (caddr L)) ) )
      ("add"
         (inc
            (cdr (assoc (cadr L) R))
            (f18-eval (caddr L)) ) )
      ("mul"
         (set (cdr (assoc (cadr L) R))
            (*
               (cadr (assoc (cadr L) R))
               (f18-eval (caddr L)) ) ) )
      ("mod"
         (set (cdr (assoc (cadr L) R))
            (%
               (cadr (assoc (cadr L) R))
               (f18-eval (caddr L)) ) ) )
      ("jgz"
         (if (gt0 (f18-eval (cadr L)))
            (inc 'I (f18-eval (caddr L)))
            (inc 'I) ) ) ) )
(de f18-exec-child (L)
   (f18-init (cdr L))
   (prog1
      (case (car L)
         ("snd"
            (yield (list (car L) (f18-eval (cadr L)))) )
         ("rcv"
            (set (cdr (assoc (cadr L) R)) (yield L)) )
         (T (f18-generic L)) )
      (or (= "jgz" (car L)) (inc 'I)) ) )
(de f18-exec-parent (L)
   (f18-init (cdr L))
   (prog1
      (case (car L)
         ("snd"
            (fifo 'CB (f18-eval (cadr L)))
            (inc 'C) )
         ("rcv"
            (if (cdr PB) # NOP
               (set (cdr (assoc (cadr L) R))
                  (fifo 'PB) )
               (dec 'I) ) )
         (T (f18-generic L)) )
      (or (= "jgz" (car L)) (inc 'I)) ) )
(de f18-child (Prg)
   (co 'child
      (let (PL (length Prg)  Prg Prg  I 1 R)
         (yield 'ready)
         (while (and (> PL I) (f18-exec-child (get Prg I)))
            (yield 'next) )
         NIL ) ) )
(de f18-2 (F) # rewrite me without coroutines
   (let
      (Prg
         (make
            (in F
               (until (eof)
                  (link (make (until (eol) (link (read)))))
                  (char) ) ) )
         PL (length Prg)
         CB NIL
         PB NIL
         R '((p 1))
         I 1
         C 0 )
      (f18-child Prg) # init child
      (while (and (> PL I) (f18-exec-parent (get Prg I)))
         (when (setq @@ (f18-child))
            (case (car @@)
               ("snd"
                  (fifo 'PB (cadr @@))
                  (yield T 'child) )
               ("rcv" (yield (fifo 'CB) 'child)) ) ) )
      (while (setq @@ (f18-child))
         (case (car @@)
            ("snd"
               (fifo 'PB (cadr @@))
               (yield T 'child) )
            ("rcv" (yield (fifo 'CB) 'child)) ) )
      C ) )
(test 6858 (f18-2 "data/18.txt"))

# --- Day 19: A Series of Tubes ---
(de f19-cross (D)
   (if (member D (car Cross))
      (cadr Cross)
      (car Cross) ) )
(de f19-1-2 (F)
   (let
      (Lst (make (in F (until (eof) (link (line)))))
         Grid (grid (length Lst) (length (car Lst)))
         Dir 'east
         Cross '((north south) (west east))
         R NIL
         Steps 0 )
      (mapc
         '((G L)
            (mapc '((This Val) (=: C Val)) G L) )
         Grid
         Lst )
      (with
         (find
            '((This) (= "|" (: C)))
            (car Grid) )
         (until (= " " (: C))
            (inc 'Steps)
            (case (char (: C))
               (43
                  (setq Dir
                     (find
                        '((D)
                           (with (D This) (<> " " (: C))) )
                        (f19-cross Dir) ) ) )
               (`(range (char "A") (char "Z"))
                  (queue 'R (: C)) ) )
            (setq This (Dir This)) )
         (cons (pack R) Steps) ) ) )
(test
   '("ABCDEF" . 38)
   (f19-1-2 "data/19-test.txt") )
(test
   '("LOHMDQATP" . 16492)
   (f19-1-2 "data/19.txt") )

# --- Day 20: Particle Swarm ---
(de f20-1-sum (Lst)
   (sum '((L) (sum abs L)) Lst) )
(de f20-1-add ("A" B)
   (inc "A" (car B))
   (inc (cdr "A") (cadr B))
   (inc (cddr "A") (caddr B)) )
(de f20-1-tick (Lst)
   (for L Lst
      (and
         (lst? L) # for part2
         (f20-1-add (caddr L) (cadddr L))
         (f20-1-add (cadr L) (caddr L)) ) ) )
(de f20-1 (F)
   (let
      (I -1
         Lst
         (make
            (in F
               (until (eof)
                  (link
                     (make
                        (link (inc 'I))
                        (do 3
                           (link
                              (make
                                 (from "<")
                                 (do 2
                                    (link (read)) )
                                 (char)
                                 (link (format (till ">" T))) ) ) ) ) )
                  (line) ) ) ) )
      (do 512 # long term
         (f20-1-tick Lst) )
      (car (mini f20-1-sum Lst)) ) )
(test 0 (f20-1 "data/20-test.txt"))
(test 457 (f20-1 "data/20.txt"))

# part 2
(de f20-2-accuL (V K N)
   (if (assoc K (val V))
      (push (cdr @) N)
      (push V (list K (list N))) ) )
(de f20-2-zero (Lst I)
   (for N I
      (set (nth Lst N) 0) ) )
(de f20-2-collapse (Lst)
   (let R NIL
      (for (I . L) Lst
         (and (lst? L) (f20-2-accuL 'R (cadr L) I)) )
      (for L R
         (and (cdadr L) (f20-2-zero Lst (cadr L))) ) ) )
(de f20-2 (F)
   (let
      (I -1
         Lst
         (make
            (in F
               (until (eof)
                  (link
                     (make
                        (link (inc 'I))
                        (do 3
                           (link
                              (make
                                 (from "<")
                                 (do 2
                                    (link (read)) )
                                 (char)
                                 (link (format (till ">" T))) ) ) ) ) )
                  (line) ) ) ) )
      (do 128 # long term
         (f20-1-tick Lst)
         (f20-2-collapse Lst) )
      (cnt lst? Lst) ) )
(test 1 (f20-2 "data/20-test-2.txt"))
(test 448 (f20-2 "data/20.txt"))

# --- Day 21: Fractal Art ---

# --- Day 22: Sporifica Virus ---
(de f22-left (D)
   (cadr
      (assoc
         D
         '(
            ((0 1) (-1 0))
            ((1 0) (0 1))
            ((0 -1) (1 0))
            ((-1 0) (0 -1)) ) ) ) )
(de f22-right (D)
   (cadr
      (assoc
         D
         '(((-1 0) (0 1))
            ((0 1) (1 0))
            ((1 0) (0 -1))
            ((0 -1) (-1 0)) ) ) ) )
(de f22-add ("Dst" Src)
   (inc "Dst" (car Src))
   (inc (cdr "Dst") (cadr Src)) )
(de f22-1 (F)
   (let
      (Lst (make (in F (until (eof) (link (line)))))
         D NIL
         C 0
         XY
         (list
            (inc (/ (length (car Lst)) 2))
            (inc (/ (length Lst) 2)) )
         Dir (list -1 0) )
      (for (I . L) Lst
         (for (J . B) L
            (and
               (= "#" B)
               (idx 'D (list I J) T) ) ) )
      (do 10000
         (f22-add
            XY
            (if (idx 'D XY)
               (prog
                  (idx 'D (copy XY) NIL)
                  (setq Dir (f22-right Dir)) )
               (inc 'C)
               (idx 'D (copy XY) T)
               (setq Dir (f22-left Dir)) ) ) )
      C ) )
(test 5348 (f22-1 "data/22.txt"))

# Legend:
# 0 - clean
# 1 - weakened
# 2 - infected
# 3 - Flagged
(de f22-2 (F)
   (let
      (Lst (make (in F (until (eof) (link (line)))))
         D NIL
         C 0
         XY
         (list
            (inc (/ (length (car Lst)) 2))
            (inc (/ (length Lst) 2)) )
         Dir (list -1 0) )
      (for (I . L) Lst
         (for (J . B) L
            (and
               (= "#" B)
               (idx
                  'D
                  (list (list I J) 2)
                  T ) ) ) )
      (do 10000000
         (let I (lup D XY)
            (case (cadr I)
               (1 (set (cdr I) 2) (inc 'C))
               (2
                  (set (cdr I) 3)
                  (setq Dir (f22-right Dir)) )
               (3
                  (idx 'D (list (copy XY) 3) NIL)
                  (setq Dir (f22-left Dir) Dir (f22-left Dir)) )
               (T (idx 'D (list (copy XY) 1) T)
                  (setq Dir (f22-left Dir)) ) )
            (f22-add XY Dir) ) )
      C ) )
(test 2512225 (f22-2 "data/22.txt"))

# --- Day 23: Coprocessor Conflagration ---
(de f23-1 (F)
   (let
      (P
         (make
            (in F
               (until (eof)
                  (link (make (until (eol) (link (read)))))
                  (char) ) ) )
         PL (length P)
         I 1
         R NIL
         M 0)
         (while (> PL I)
            (f23-exec (get P I)) )
         M ) )
(de f23-exec (L)
   (f18-init (cdr L))
   (case (car L)
      ("set"
         (set (cdr (assoc (cadr L) R))
            (f18-eval (caddr L)) ) )
      ("sub"
         (dec
            (cdr (assoc (cadr L) R))
            (f18-eval (caddr L)) ) )
      ("mul"
         (inc 'M)
         (set (cdr (assoc (cadr L) R))
            (*
               (cadr (assoc (cadr L) R))
               (f18-eval (caddr L)) ) ) )
      ("jnz"
         (if (n0 (f18-eval (cadr L)))
            (inc 'I (caddr L))
            (inc 'I) ) ) )
   (or (= "jnz" (car L)) (inc 'I)) )
(test 8281 (f23-1 "data/23.txt"))

(de f23-2-prime? (N)
   (and
      (bit? 1 N)
      (let S (sqrt N)
         (for (D 3  T  (+ D 2))
            (T (> D S) N)
            (T (=0 (% N D)) NIL) ) ) ) )
(de f23-2 (A B)
   (cnt '((N) (not (f23-2-prime? N))) (range A B 17)) )
(test 911 (f23-2 109300 126300))

# --- Day 24: Electromagnetic Moat ---
(de f24-1 (Lst I)
   (default I 0)
   (let S 0
      (for L Lst
         (let (A (car L)  B (cadr L))
            (when (member I L)
               (let
                  (Lst (filter '((Y) (<> Y L)) Lst)
                     BA 0
                     BB 0 )
                  (cond
                     ((= I A)
                        (setq BA (+ A B (f24-1 Lst B))) )
                     ((= I B)
                        (setq BB (+ A B (f24-1 Lst A))) ) )
                     (setq S (max S BA BB)) ) ) ) )
      S ) )
(de f24-file (F)
   (make
      (in F
         (until (eof)
            (link
               (make
                  (link (format (till "/" T)))
                  (char)
                  (link (read)) ) )
            (line) ) ) ) )
(test 31 (f24-1 (f24-file "data/24-test.txt")))
(test 1695 (f24-1 (f24-file "data/24.txt")))

(de f24-2 (Lst I)
   (default I 0)
   (let S (list 0 0)
      (for L Lst
         (let (A (car L)  B (cadr L))
            (when (member I L)
               (let
                  (Lst (filter '((Y) (<> Y L)) Lst)
                     BA (list 0 0)
                     BB (list 0 0) )
                  (cond
                     ((= I A)
                        (set
                           '@ (f24-2 Lst B)
                           BA (inc (car @))
                           (cdr BA) (+ (cadr @) A B) ) )
                     ((= I B)
                        (set
                           '@ (f24-2 Lst A)
                           BB (inc (car @))
                           (cdr BB) (+ (cadr @) A B) ) ) )
                     (setq S (max S BA BB)) ) ) ) )
      S ) )
(test (4 19) (f24-2 (f24-file "data/24-test.txt")))
(test (36 1673) (f24-2 (f24-file "data/24.txt")))

# --- Day 25: The Halting Problem ---
(de f25-right NIL
   (if (cddr L)
      (setq L @)
      (con D (cons 0 L NIL))
      (con (cdr L) (cdr D))
      (setq L (cdr D)) ) )
(de f25-left NIL
   (if (cadr L)
      (setq L @)
      (set D (cons 0 NIL L))
      (set (cdr L) (car D))
      (setq L (car D)) ) )
(de f25-test-1 (NIL)
   (let
      (D '((0 NIL) 0 NIL)
         L (car D)
         C 0 )
      (do 6
         (state '(A)
            (A
               'B
               (if (=0 (car L))
                  (prog (set L 1) (f25-right))
                  (set L 0)
                  (f25-left) ) )
            (B
               'A
               (if (=0 (car L))
                  (prog (set L 1) (f25-left))
                  (set L 1)
                  (f25-right) ) ) ) )
      (for (L (car D) L (cddr L))
         (and (=1 (car L)) (inc 'C)) )
      C ) )
(test 3 (f25-test-1))

(de f25-1 (NIL)
   (let (D '((0 NIL) 0 NIL)  L (car D)  C 0)
      (do 12134527
         (state '(A)
            (A (if (=0 (car L)) 'B 'C)
               (case @
                  (B (set L 1) (f25-right))
                  (T (set L 0) (f25-left)) ) )
            (B (if (=0 (car L)) 'A 'C)
               (case @
                  (A (set L 1) (f25-left))
                  (T (f25-right)) ) )
            (C (if (=0 (car L)) 'A 'D)
               (case @
                  (A (set L 1) (f25-right))
                  (T (set L 0) (f25-left)) ) )
            (D (if (=0 (car L)) 'E 'C)
               (case @
                  (E (set L 1) (f25-left))
                  (T (f25-left)) ) )
            (E (if (=0 (car L)) 'F 'A)
               (case @
                  (F (set L 1) (f25-right))
                  (T (f25-right)) ) )
            (F (if (=0 (car L)) 'A 'E)
               (case @
                  (A (set L 1) (f25-right))
                  (T (f25-right)) ) ) ) )
      (for (L (car D) L (cddr L))
         (and (=1 (car L)) (inc 'C)) )
      C ) )
(test 5593 (f25-1))

(msg 'OK-AoC17)

