#4.1
(de f4-1 (L) # destructive tiger
   (for (I L (cdr I) (cddr I))
      (xchg I (cdr I)) )
   L )
(test
   '(1 A 1 A)
   (f4-1 '(A 1 A 1)) )
(test
   '(1 A 1 A A)
   (f4-1 '(A 1 A 1 A)) )

#4.2
(de f4-2 (L B D)
   (cons L (- D B)) )
(test
   '(Bismarck . 83)
   (f4-2 'Bismarck 1815 1898) )

#4.3
(de f4-3 (L)
   (mapcar
      '((L) (cons (car L) (- (caddr L) (cadr L))))
      L ) )
(test
   '((Lincoln . 56) (Bismarck . 83))
   (f4-3
      (quote
         (Lincoln  1809 1865)
         (Bismarck 1815 1898) ) ) )

#4.4
(de f4-4 (L)
   (by
      '((N)
         (cond
            ((= 1 N) 2)
            ((= 2 N) 1)
            (T 0) ) )
      sort
      L ) )
(test
   (0 0 2 2 1 1)
   (f4-4 (1 0 2 1 2 0)) )

#4.5
(de f4-5 (L)
   (mapcar '((I) (apply min I)) L) )
(test
   (6 5 0)
   (f4-5 '((34 73 9 6) (5) (67 8 4 0))) )

#4.6
(de bubbleSort (Lst) # rosetta
   (use Chg
      (loop
         (off Chg)
         (for (L Lst (cdr L) (cdr L))
            (when (> (car L) (cadr L))
               (xchg L (cdr L))
               (on Chg) ) )
         (NIL Chg Lst) ) ) )
(test
   (1 2 4 4 5)
   (bubbleSort (5 4 2 4 1)) )

#4.7
(de f4-7 (L)
   (make
      (for (X . I) L
         (or (=0 (% X 3)) (link I)) ) ) )
(test
   (1 2 4 5)
   (f4-7 (range 1 6)) )

#4.8
(de f4-8 (L)
   (let R NIL
      (for I L
         (accu 'R I 1) )
      (mapcan
         '((L) (need (cdr L) (car L)))
         (flip (by cdr sort R)) ) ) )
(test
   (1 1 2)
   (f4-8 (1 2 1)) )
(test
   '(a a a a A A A 1 1 B)
   (f4-8 '(a A 1 1 A A B a a a)) )

#4.9
(de f4-9 (L)
   (head -3 L) )
(test
   (1 2)
   (f4-9 (1 2 3 4 5)) )

#4.10
(de f4-10 (L)
   (reverse L) )
(test
   (3 2 1)
   (f4-10 (1 2 3)) )

#4.11
(de f4-11 (L)
   (maxi
      '((L) (length (fish atom L)))
      L ) )
(test
   '(c (d))
   (f4-11 '(a (b) (c (d)))) )

#4.12
(de f4-12 (L)
   (make
      (while (cut 3 'L)
         (link @) ) ) )
(test
   '((1 2 3) (4 5 6))
   (f4-12 (range 1 6)) )
(test
   '((1 2 3) (4 5))
   (f4-12 (range 1 5)) )

#4.13
(de f4-13 (L)
   (uniq (mapcar cadr L)) )
(test
   '(acer samsung intel)
   (f4-13
      (quote
         (terminal acer 15 4500)
         (terminal samsung 17 7000)
         (motherboard intel 238 2500)
         (processor intel 2.5 3000) ) ) )

#4.14
(de f4-14 (L)
   (cond
      ((not L))
      ((atom (car L))
         (cons
            (format (pack (car L) (car L)))
            (f4-14 (cdr L)) ) )
      (T (cons (f4-14 (car L)) (f4-14 (cdr L)))) ) )
(test
   '(22 (33 55 (77 88 (22 66))))
   (f4-14 '(2 (3 5 (7 8 (2 6))))) )

#4.15
(de f4-15 (L)
   (let (C 0  V '(a e i o u))
      (cons
         (filter
            '((I)
               (or (member I V) (nil (inc 'C))) )
            (fish atom L) )
         C ) ) )
(test
   '((a e u) . 1)
   (f4-15 '((a c e) u)) )

#4.16
(de f4-16 (L)
   (mapcar sort (by sym? group L)) )
(test
   '((a b c) (1 2))
   (f4-16 '(a 2 1 c b)) )

#4.17
(de f4-17 (L)
   (let W
      (quote
         (1 . "one") (2 . "two") (3 . "three") (4 . "four") (5 . "five")
         (6 . "six") (7 . "seven") (8 . "eight") (9 . "nine"))
      (mapcar
         '((N) (cdr (assoc N W)))
         L ) ) )
(test
   '("one" "two" "three")
   (f4-17 (1 2 3)) )

#4.18
(de f4-18 (L)
   (let (H (head 2 L)  E (tail 2 L))
      (and
         (num? (cadr H))
         (num? (car E))
         (cons (cadr H) (car E)) ) ) )
(test
   (1 . 2)
   (f4-18 '(a 1 b 2 c)) )
(test
   NIL
   (f4-18 '(a 1 b 2)) )

#4.19
(de f4-19 (L)
   (find
      '((I) (and (pair I) (pair (car @))))
      L ) )
(test
   '((a) (b))
   (f4-19 '(c ((a) (b)))) )
(test
   NIL
   (f4-19 '(c (a) (b))) )

#4.20
(de f4-20 (L)
   (let D '((product . *))
      (mapcar
         '((I) (or (cdr (assoc I D)) I))
         L ) ) )
(test
   '(* X Y)
   (f4-20 '(product X Y)) )

#4.21
(de f4-21 (L) # prototype
   (list
      (get L 1)
      (get L 2)
      (get L 6)
      (list
         'inc
         (lit (get L 8))
         (get L 2) ) ) )
(test
   '(for i 10 (inc 'k i))
   (f4-21 '(for i = 1 to 10 do k := k + i)) )

#4.22
(de roman (N) # rosetta
   (pack
      (make
         (mapc
            '((C D)
               (while (>= N D)
                  (dec 'N D)
                  (link C) ) )
            '(M CM D CD C XC L XL X IX V IV I)
            (1000 900 500 400 100 90 50 40 10 9 5 4 1) ) ) ) )
(de f4-22 (L)
   (mapcar roman L) )
(test
   '("CXXIII" "CDLVI" "DCCLXXXIX")
   (f4-22 (123 456 789)) )

#4.23
(de f4-23 (L)
   (reverse L) )
(test
   '((d) c (b) a)
   (f4-23 '(a(b)c(d))) )

#4.24
(de f4-24 (L)
   (mapcon reverse L) )
(test
   (6 5 4 3 2 1 6 5 4 3 2 6 5 4 3 6 5 4 6 5 6)
   (f4-24 (range 1 6)) )

#4.25
(de f4-25 (L)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L) L (mapcar recurse (flip L))) ) )
      L ) )
(test
   '(1 (4 (3 2)) 5 6)
   (f4-25 '(1 ((2 3) 4) 5 6)) )

#4.26
(de f4-26 (L)
   (by
      '((I)
         (cond
            ((num? I) 1)
            ((pair I) T)
            (T)) )
      group
      L ) )
(test
   '((a d) (1 2) ((b c)))
   (f4-26 '(a 1 (b c) 2 d)) )

#4.27
(de consecDups (Lst) # N99
   (make
      (let Last NIL
         (for X Lst
            (if (= X (car Last))
               (conc Last (cons X))
               (link (setq Last (cons X))) ) ) ) ) )
(de f4-27 (L)
   (extract
      '((I) (and (not (cdr I)) (car I)))
      (consecDups L) ) )
(test
   '(a c)
   (f4-27 '(a b b c b b b c c c d d)) )

#4.28 - destructive
(de setN (L I P)
   (set (nth L I)
      (** (car (nth L I)) P) ) )
(de f4-28 (L)
   (let P (if (bit? 1 (car L)) 3 2)
      (for I 3
         (setN L I P) )
      L ) )
(test
   (16 25 36 7 8 9)
   (f4-28 (4 5 6 7 8 9)) )
(test
   (1 8 27 4 5 6)
   (f4-28 (1 2 3 4 5 6)) )

#4.29
(de f4-29 (L)
   (let D
      (quote
         (a z) (b y) (c x) (d w) (e v) (f u) (g t) (h s) (i r) (j q)
         (k p) (l o) (m n) (n m) (o l) (p k) (q j) (r i) (s h) (t g)
         (u f) (v e) (w d) (x c) (y b) (z a) )
      (mapcar
         '((I) (cadr (assoc I D)))
         L ) ) )
(test
   '(v c c v t l v c h i t r)
   (f4-29 '(e x x e g o e x s r g i)) )

#4.30
(de f4-30 (L)
   (make
      (for (I L I (cdr I))
         (or
            (member (car I) (cdr I))
            (link (car I)) ) ) ) )
(let L '((a b) c d (a b) c e)
   (test
      NIL
      (diff (uniq L) (f4-30 L)) ) )

#4.31
(de f4-31 (L)
   (mapcar
      '((N)
         (or (ge0 N) (intern (pack '* N))) )
      L ) )
(test
   '(*-1 0 1)
   (f4-31 (-1 0 1)) )

#4.32
(de f4-32 (Str)
   (let R NIL
      (for I (str Str)
         (accu 'R I 1) )
      (extract
         '((L)
            (and (< 1 (cdr L)) (car L)) )
         R ) ) )
(test
   '(c aa)
   (f4-32 "aa c aa bbb c c") )

#4.33
(de f4-33 (L)
   (mapcar '((L) (apply + L)) L) )
(test
   (33 35)
   (f4-33 '((11 22) (33 2))) )

#4.34 - ignored

#4.35
(de f4-35 (L . @)
   (filter
      '((I)
         (not
            (find
               '((L) (member I L))
               (rest) ) ) )
      L ) )
(test
   '(a)
   (f4-35 '(a b c) '(b) '(c)) )

#4.36
(de f4-36 (L X Y)
   (filter
      '((N) (= 0 (% N X) (% N Y)))
      L ) )
(test
   (6 12)
   (f4-36 (range 1 12) 2 3) )

#4.37
(de f4-37 (L)
   (let S (1 2 3 2 .)
      (make
         (while (cut (pop 'S) 'L)
            (link @) ) ) ) )
(test
   '((1) (2 3) (4 5 6) (7 8) (9) (10 11) (12 13 14) (15 16))
   (f4-37 (range 1 16)) )

#4.38
(de f4-38 (L)
   (mapcar
      '((L) (apply + (fish atom L)))
      L ) )
(test
   (21 24)
   (f4-38 '(((1 2 3)(4 5 6))((7 8 9)))) )

#4.39
(de accuL (V K N)
   (if (assoc K (val V))
      (push (cdr @) N)
      (push V (list K (list N))) ) )
(de f4-39 (L)
   (let R NIL
      (mapc
         '((L)
            (let P (cddr L)
               (mapc
                  '((I) (accuL 'R (car I) (cadr I)))
                  P ) ) )
         L )
      (car
         (maxi
            '((L)
               (/ (apply + (cadr L)) (length (cadr L))) )
            R ) ) ) )
(test
   'lisp
   (f4-39
      (quote
         (cameron  111 (java 5) (ruby 4) (lisp 5))
         (haberman 222 (java 3) (ruby 5) (lisp 5)) ) ) )

#4.40
(de subsetp (L1 L2)
   (fully '((I) (member I L2)) L1) )
(de f4-40 (L)
   (mapcon
      '((I)
         (and
            (not
               (find
                  '((J) (subsetp (car I) J))
                  (cdr I) ) )
            (cons (car I)) ) )
      L ) )
(test
   '((a b c) (d e) (f g h))
   (f4-40 '((a b) (a b c) (d e) (f g h))) )

#4.41
(def 'f4-41 permute)
(test
   '((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))
   (f4-41 (1 2 3)) )

#4.42
(de f4-42 (L)
   (remove (dec (length L)) L) )
(test
   (1 2 4)
   (f4-42 (1 2 3 4)) )

#4.43
(de f4-43 (L)
   (fully
      '((N) (prime? (+ (* N N) N 17)))
      L ) )
(test
   NIL
   (f4-43 (range 0 16)) )
(test
   T
   (f4-43 (range 0 15)) )

#4.44
(de f4-44 (L)
   (mapcan
      '((L)
         (and (cdr L) (cons (mapcar car L))) )
      (by cadr group L) ) )
(test
   '((1 3) (2 6 7))
   (f4-44 '((1 15) (2 17) (3 15) (4 21) (5 19) (6 17) (7 17))) )

#4.45
(de f4-45 (L)
   (mapcar '((L) (apply + L)) L) )
(test
   (3 6)
   (f4-45 '((1 2) (1 2 3))) )

#4.46
(de f4-46 (L)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L)
               (or (gt0 L) 0)
               (mapcar recurse L) ) ) )
      L ) )
(test
   '(1 ((0 3) 0) 5 (6))
   (f4-46 '(1 ((-2 3) -4) 5 (6))) )

#4.47
(de f4-47 (L)
   (let R NIL
      (mapc
         '((N) (accu 'R N 1))
         (fish atom L) )
      (extract
         '((L) (and (=1 (cdr L)) (car L)))
         R ) ) )
(test
   (9 8 7 4 3)
   (f4-47 '(1 2 (((2 3 4))) 7 (8 (9 1)))) )

#4.48
(de f4-48 (Lst)
   (let A (range (car Lst) (cadr Lst))
      (for (L (cddr Lst) L (cddr L))
         (setq A
            (sect A (range (car L) (cadr L))) ) )
      (and A (list (car A) (last A))) ) )
(test
   (12 15)
   (f4-48 '(2 15 10 20 12 25)) )

#4.49
(de f4-49 (L)
   (append L (reverse L)) )
(test
   (1 2 3 3 2 1)
   (f4-49 (1 2 3)) )

#4.50
(de f4-50 (L)
   (make
      (for (I . X) L
         (or (bit? 1 I) (link X)) ) ) )
(test
   (2 4 6)
   (f4-50 (range 1 7)) )

#4.51 # destructive
(de f4-51 (L)
   (xchg (tail 1 L) (tail 2 L))
   L )
(test
   (1 2 3 5 4)
   (f4-51 (1 2 3 4 5)) )

#4.52
(de f4-52 (L C)
   (default C 0)
   (cond
      ((not L))
      ((atom (car L))
         (cons
            (list (car L) C) # @
            (f4-52 (cdr L) C) ) )
      (T
         (conc
            (f4-52 (car L) (inc C))
            (f4-52 (cdr L) C) ) ) ) )
(test
   '((a 0) (b 0) (c 3) (d 3) (e 1) (f 1))
   (f4-52 '(a b (((c d)) e f))) )

#4.53
(de f4-53 (L)
   (filter '((L) (apply < L)) L) )
(test
   '((1 2 3) (4 5 7))
   (f4-53 '((1 2 3) (3 2 2) (4 5 7))) )

#4.54
(de f4-54-1 (Lst) # destructive
   (for (L Lst L (cddr L))
      (xchg L (cdr L)) )
   Lst )
(de f4-54-2 (Lst) # non-destructive
   (make
      (for (L Lst L (cddr L))
         (link (cadr L) (car L)) ) ) )
(let L (range 1 6)
   (test
      (2 1 4 3 6 5)
      (f4-54-1 L) )
   (test
      (1 2 3 4 5 6)
      (f4-54-2 L) ) )

#4.55
(de f4-55 (L)
   (apply mapcar L list) )
(test
   '((1 4 7) (2 5 8) (3 6 9))
   (f4-55 '((1 2 3) (4 5 6) (7 8 9))) )

#4.56
(de f4-56 (L) # without length art
   (filter
      '((I)
         (or
            (atom I)
            (nand (cdr I) (not (cddr I))) ) )
      L ) )
(test
   '(0 (1) (3 3 3))
   (f4-56 '(0 (1) (2 2) (3 3 3))) )

#4.57
(de f4-57 (Lst)
   (let Lst (shuffle Lst)
      (make
         (while (cut 9 'Lst) (link @)) ) ) )
(test
   4
   (length
      (f4-57
         (quote
            (6 x) (6 y) (6 u) (6 z) (7 x) (7 y) (7 u) (7 z)
            (8 x) (8 y) (8 u) (8 z) (9 x) (9 y) (9 u) (9 z)
            (10 x) (10 y) (10 u) (10 z) (11 x) (11 y) (11 u)
            (11 z) (12 x) (12 y) (12 u) (12 z) (13 x) (13 y)
            (13 u) (13 z) (14 x) (14 y) (14 u) (14 z) ) ) ) )

#4.58
(de f4-58 (Lst)
   (let
      (S (apply + Lst)
         L (frac (dec (length Lst)) 1) )
      (mapcar
         '((N) (f/ (frac (- S N) 1) L))
         Lst ) ) )
(test
   '((14 . 3) (13 . 3) (11 . 3) (10 . 3))
   (f4-58 (2 3 5 6)) )

#4.59
(de f4-59 (L)
   (filter gt0 L) )
(test
   (1 2 3)
   (f4-59 (0 1 0 2 0 3)) )

#4.60
(de f4-60-1 (L) # mess
   (cond
      ((not L))
      ((<= 1 (car L) 4)
         (cons 0 (f4-60-1 (cdr L))) )
      ((pair (car L))
         (cons (f4-60-1 (car L)) (f4-60-1 (cdr L))) )
      (T (cons (car L) (f4-60-1 (cdr L)))) ) )
(de f4-60-2 (L) # ok
   (mapcar
      '((L)
         (recur (L)
            (if2 (atom L) (<= 1 L 4)
               0
               L
               NIL
               (mapcar recurse L) ) ) )
      L ) )
(let L '(((-2) -1) 0 1 (2) (3 (4)) 5 6 7)
   (test
      (f4-60-1 L)
      (f4-60-2 L) ) )

#4.61
(de f4-61 (L)
   (by '((N) (bit? 1 N)) group L) )
(test
   '((1 3 5) (2 4 6))
   (f4-61 (range 1 6)) )

#4.62
(de f4-62 (L)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L)
               L
               (mapcar recurse (uniq L)) ) ) )
      L ) )
(test
   '(1 (1) a b (a (b)))
   (f4-62 '(1 (1 1) a b (a a (b b)))) )
(test
   '(1 (1) a b (a (b)))
   (f4-62 '(1 (1 1) a b (a a (b b)))) )

#4.63
(de f4-63 (L)
   (make
      (for (I L (cdr I) (cddr I))
         (link (list (car I) (cadr I))) ) ) )
(test
   '((1 a) (2 b) (3 c))
   (f4-63 '(1 a 2 b 3 c)) )
(test
   '((1 a) (2 b))
   (f4-63 '(1 a 2 b 3)) )

#4.64
(de f4-64 (L)
   (mapcar '((X) (mapcar flip X)) L) )
(test
   '(((b a) (d c) (f e)) ((b a) (d c) (f e)))
   (f4-64 '(((a b) (c d) (e f)) ((a b) (c d) (e f)))) )

#4.65
(de f4-65 (L) # send me your version
   (let R (list (car L))
      (mapc
         '((N) (setq R (cons R (list N))))
         (cdr L) )
      R ) )
(test
   '((((1) 2) 3) 4)
   (f4-65 (1 2 3 4)) )

#4.66
(de f4-66 (L)
   (filter '((I) (not (pair I))) L) )
(test
   (1)
   (f4-66 '(1 (2) (3 (4)))) )

#4.67 - ignored

#4.68
(de f4-68 (L1 L2)
   (make
      (mapc
         '((I)
            (mapc '((J) (link (list I J))) L2) )
         L1 ) ) )
(test
   '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2))
   (f4-68 '(a b c) (1 2)) )

#4.69
(de f4-69 (L)
   (filter atom L) )
(test
   '(2 4 c)
   (f4-69 '(2 (a e) 4 ((5) y) c)) )

#4.70 - ignored

#4.71
(de f4-71 (L)
   (mapcar
      '((N) (or (ge0 N) 'A))
      L ) )
(test
   '(1 A 0 1 A)
   (f4-71 (1 -2 0 1 -3)) )

#4.72
(de f4-72 (L)
   (let R NIL
      (mapc
         '((I) (accu 'R I 1))
         L )
      R ) )
(test
   '((c . 1) (b . 2) (a . 4))
   (f4-72 '(a b a b a c a)) )

#4.73 - ignored

#4.74
(de f4-74 (L)
   (cond
      ((not L))
      ((member (car L) (cdr L))
         (f4-74 (cdr L)) )
      (T (cons (car L) (f4-74 (cdr L)))) ) )
(let L (1 2 4 2 1 4 1)
   (test
      NIL
      (diff
         (uniq L)
         (f4-74 L) ) ) )

#4.75
(de f4-75-1 (L)
   (mapcar
      '((N) (or (ge0 N) 0))
      L ) )
(de f4-75-2 (L)
   (cond
      ((not L))
      ((lt0 (car L)) (cons 0 (f4-75-2 (cdr L))))
      (T (cons (car L) (f4-75-2 (cdr L))) ) ) )
(let L (1 -5 6 -7 8 -9 -4)
   (test
      (f4-75-1 L)
      (f4-75-2 L) ) )

#4.76
(de f4-76 (L)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L) (inc L) (mapcar recurse L)) ) )
      L ) )
(test
   '(2 (3 (4)))
   (f4-76 '(1 (2 (3)))) )
(test
   '((2 3 (4 5) (((6 7))) 0))
   (f4-76 '((1 2 (3 4) (((5 6))) -1))) )

#4.77
(de f4-77 (L)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L)
               (uppc L)
               (mapcar recurse L) ) ) )
      L ) )
(test
   '(("ABC" "ABC") ("ABC" "ABC"))
   (f4-77 '(("abc" "abc") ("abc" "abc"))) )

#4.78
(de f4-78 (L)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L) L (mapcar recurse (uniq L))) ) )
      L ) )
(test
   '(1 2 (2 3) 3)
   (f4-78 '(1 2 (2 2 3) 3)) )

#4.79 - ignored

#4.80
(de capc (Str)
   (let Str (chop Str)
      (if (upp? (car Str))
         (pack Str)
         (pack (uppc (car Str)) (cdr Str)) ) ) )
(de f4-80 (L)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L) (capc L) (mapcar recurse L)) ) )
      L ) )
(test
   '(("Abc" "Abc") ("Abc" "Abc"))
   (f4-80 '(("abc" "abc") ("abc" "abc"))) )

#4.81
(de f4-81 (L)
   (make
      (for (I L I (cddr I))
         (link (list (+ (car I) (cadr I)))) ) ) )
(test
   '((5) (9) (13))
   (f4-81 (2 3 4 5 6 7)) )

#4.82
(de f4-82 (L)
   (mapcan
      '((L)
         (recur (L)
            (if2 (atom L) (gt0 L)
               NIL
               (cons L)
               NIL
               (cons (mapcan recurse L)) ) ) )
      L ) )
(test
   '(a (-1 0) (0 NIL))
   (f4-82 '(a 1 (-1 0) (0 (1)))) )

#4.83
(de f4-83-1 (L)
   (make
      (for (I L (cdr I) (cdr I))
         (link (+ (car I) (cadr I))) ) ) )
(de f4-83-2 (L)
   (mapcon
      '((L)
         (and (+ (car L) (cadr L)) (cons @)) )
      L ) )
(test
   (f4-83-1 (1 2 3 4 5))
   (f4-83-2 (1 2 3 4 5)) )

#4.84
(de f4-84 (L)
   (flip
      (make
         (for (I . X) L
            (and (bit? 1 I) (link X)) ) ) ) )
(test
   (5 3 1)
   (f4-84 (1 2 3 4 5)) )

#4.85
(de f4-85 (L)
   (let R NIL
      (for I (fish atom L)
         (accu 'R I 1) )
      R ) )
(test
   '((c . 2) (b . 3) (a . 4))
   (f4-85 '(a ((a) (a (a)) b) (b (b) c) c)) )

#4.86
(de f4-86 (L)
   (mapcar
      '((I)
         (intern (pack (by char sort (chop I)))) )
      L ) )
(test
   '(27_ab 15_cd)
   (f4-86 '("b_a72" "dc5_1")) )

#4.87
(de f4-87 (L)
   (mapcar '((N) (* 2 N)) L) )
(test
   (2 4 6)
   (f4-87 (1 2 3)) )

#4.88
(def 'f4-88 reverse) # ??? let it be
(test
   (3 2 1)
   (f4-88 (1 2 3)) )

#4.89
(de f4-89 (L)
   (mapcan
      '((L)
         (recur (L)
            (if2 (atom L) (lt0 L)
               (cons L)
               NIL
               NIL
               (cons (mapcan recurse L)) ) ) )
      L ) )
(test
   '((-1 -3) -33)
   (f4-89 '(1 (-1 2 -3) -33)) )

#4.90
(de f4-90 (L)
   (cons (last L) (conc (head -1 (cdr L)) (cons (car L)))) )
(test
   '(d b c a)
   (f4-90 '(a b c d)) )

#4.91
(de f4-91 (L1 L2)
   (diff (fish atom L1) (fish atom L2)) )
(test
   '(a b)
   (f4-91 '(a b (c) d) '((c d) e)) )

#4.92
(de f4-92 (L)
   (mapcar dec L) )
(test
   (0 1 2 3)
   (f4-92 (1 2 3 4)) )

#4.93
(de f4-93 (L)
   (mapcar '((N) (if (gt0 N) 1 0)) L) )
(test
   (0 0 0 1 1)
   (f4-93 (-2 -1 0 1 2)) )

#4.94
(de f4-94 (L)
   (mapcar '((I) (bool (pair I))) L) )
(test
   '(NIL T)
   (f4-94 '(a (a b))) )

#4.95
(de f4-95 (L)
   (let E (eval L)
      (if (and (not (bit? 1 E)) (gt0 E))
         T
         L ) ) )
(test
   T
   (f4-95 '(+ 1 1)) )
(test
   '(+ 1 2)
   (f4-95 '(+ 1 2)) )
(test
   '(+ -8 2)
   (f4-95 '(+ -8 2)) )

#4.96
(de f4-96 (L)
   (let V '(a e i o u y h w)
      (cons
         (car L)
         (head
            3
            (mapcon
               '((L)
                  (cond
                     ((member (car L) V))
                     ((= (car L) (cadr L)))
                     (T (cons (car L))) ) )
               (cdr L) ) ) ) ) )
(test
   '(b r n g)
   (f4-96 '(b a r r i n g t o n)) )
(test
   '(a r n g)
   (f4-96 '(a r r i n g t o n)) )

#4.97
(de f4-97 (L)
   (flip (by cadr sort L)) )
(test
   '((C 5) (A 3) (B 2))
   (f4-97 '((A 3) (B 2) (C 5))) )

#4.98
(de f4-98 (L)
   (let
      (V '(a e i o u)
         S '(b c d f g h j k l m n p q r s t v w x y z) )
      (by
         '((I)
            (cond
               ((member I V) 1)
               ((member I S) 2)
               ((num? I) 0)
               (T) ) )
         group
         (fish atom L) ) ) )
(test
   '((3 2 3 1 1) (a u) (b b c c) (!))
   (f4-98 '(3 (2 a) b (3) b (u 1) c 1 c (!))) )

#4.99 - nums and syms only
(de f4-99 (L)
   (let (L (uniq (fish atom L))  Len (length L))
      (make
         (for I (by '((I) (and (num? I) T)) group L)
            (link (/ (* 100 (length I)) Len)) ) ) ) )
(test
   (50 50)
   (f4-99 '(1 (a b c) ((b 1 2 3) c))) )
(test
   (66 33)
   (f4-99 '(a b 1)) )

#4.100
(de f4-100 (L)
   (let D '((cakes . pyrogy) (ale . pyvo))
      (mapcar
         '((I)
            (cdr (assoc I D)) )
         (fish atom L) ) ) )
(test
   '(pyrogy pyvo)
   (f4-100 '(cakes ((ale)))) )

#4.101
(de f4-101 (L) # ok? ok!
   (let A T
      (mapcan
         '((I)
            (ifn A
               (cons I)
               (if (atom I)
                  (nil (off A))
                  (cons I) ) ) )
         L ) ) )
(test
   '((a b) (d) e)
   (f4-101 '((a b) c (d) e)) )

#4.102 - Dear, Mr. Freeman Dyson
(setq *D
   (quote
      ((2 1 1) (1  L)) ((1 0 0) (2  L)) ((0 2 2) (3  L))
      ((2 1 2) (4  L)) ((1 0 1) (5  L)) ((0 2 0) (6  L))
      ((2 1 0) (7  L)) ((1 0 2) (8  L)) ((0 2 1) (9  L))
      ((2 2 1) (10 L)) ((1 1 0) (11 L)) ((0 0 2) (12 L))
      ((0 1 1) (1  H)) ((1 2 2) (2  H)) ((2 0 0) (3  H))
      ((0 1 0) (4  H)) ((1 2 1) (5  H)) ((2 0 2) (6  H))
      ((0 1 2) (7  H)) ((1 2 0) (8  H)) ((2 0 1) (9  H))
      ((0 0 1) (10 H)) ((1 1 2) (11 H)) ((2 2 0) (12 H)) ) )
(setq *Steps
   (quote
      ((1 4 7 10) (3 6 9 12))
      ((3 6 9 10) (2 5 8 12))
      ((3 4 8 12) (2 6 7 11)) ) )
(de f4-102 (Coins)
   (cadr
      (assoc
         (mapcar
            '((L)
               (cond
                  ((> (car L) (cadr L)) 0)
                  ((< (car L) (cadr L)) 2)
                  (T 1) ) )
            (mapcar
               '((S)
                  (mapcar
                     '((I)
                        (sum '((J) (get Coins J)) I) )
                     S ) )
               *Steps ) )
         *D ) ) )
(test
   '(1 L)
   (f4-102 (1 2 2 2 2 2 2 2 2 2 2 2)) )
(test
   '(6 H)
   (f4-102 (4 4 4 4 4 22 4 4 4 4 4 4)) )

#4.103
(de f4-103 (L1 L2)
   (filter
      '((I)
         (and (num? I) (member I L2)) )
      L1 ) )
(test
   (2 3)
   (f4-103 '(a b 1 2 3) '(b c 2 3 4)) )

#4.104
(de f4-104 (L)
   (mapcon
      '((L)
         (if (assoc (caar L) (cdr L))
            NIL
            (cons (car L)) ) )
      L ) )
(test
   (quote
      (Sokolov Fedor 3)
      (Sidorov Kostya 4)
      (Vasiljev Dmitrij 5)
      (Petrov Ivan 6)
      (Ivanov Fedor 7) )
   (f4-104
      (quote
         (Ivanov   Slava   1)
         (Petrov   Igor    2)
         (Sokolov  Fedor   3)
         (Sidorov  Kostya  4)
         (Vasiljev Dmitrij 5)
         (Petrov   Ivan    6)
         (Ivanov   Fedor   7) ) ) )

#4.105
(de f4-105 (L)
   (list
      (sum '((L) (caddr L)) L)
      (/
         (sum '((L) (cadddr L)) L)
         (length L) ) ) )
(test
   (76 242)
   (f4-105
      (quote
         ("Grand" "5" 9 420)
         ("Nobis" "5" 4 318)
         ("Berns" "4" 8 333)
         ("Diplomat" "4" 30 320)
         ("Attache" "3" 8 164)
         ("General" "3" 7 207)
         ("Vanadis" "2" 5 99)
         ("Dialog" "2" 5 78) ) ) )

#4.106
(de f4-106 (Lst)
   (let L (list (car Lst) (last Lst))
      (make
         (if
            (fully
               '((N) (and (gt0 N) (not (bit? 1 N))))
               L )
         (link (** (cadr L) 2) (** (car L) 4))
         (chain L) ) ) ) )
(test
   (6724 614656)
   (f4-106 '(28 4 5 6 7 82)) )
(test
   (20 89)
   (f4-106 '(20 4 5 6 7 89)) )

#4.107
(de f4-107 (Lst)
   (mapcar
      '((L)
         (let (C (chop L)  S (sort (extract format C)))
            (intern
               (pack
                  (mapcar
                     '((I) (if (format I) (pop 'S) I))
                     C ) ) ) ) )
      Lst ) )
(test
   '(a23r5 v4n78)
   (f4-107 '(a53r2 v8n74)) )

#4.108
(de f4-108 (L)
   (recur (L)
      (let R NIL
         (if (lst? L)
            (mapcar recurse L)
            (for I (chop L)
               (accu 'R I 1) )
            (intern
               (pack
                  (mapcan
                     '((I)
                        (list
                           (car I)
                           (and (< 1 (cdr I)) (cdr I)) ) )
                     (flip R) ) ) ) ) ) ) )
(test
   '((a3b2 c4d3) (e3fg3 h2kl))
   (f4-108 '((aaabb ccccddd) (eeefggg hhkl))) )

#4.109
(de f4-109 (L)
   (mapcar
      '((N) (if (bit? 1 N) 0 1))
      L ) )
(test
   (1 0)
   (f4-109 (2 3)) )

#4.110
(de f4-110 (L)
   (conc (head -2 L) (cons (last L))) )
(test
   '(a b d)
   (f4-110 '(a b c d)) )

#4.111
(de f4-111 @
   (mapcar
      '((N)
         (apply + (mapcar format (chop N))) )
      (rest) ) )
(test
   (7 3 11 3 7 18)
   (f4-111 34 12 29 111 16 882) )

#4.112
(de f4-112 (L)
   (let V '(a e i o u)
      (by
         '((W) (cnt '((C) (member C V)) (chop W)))
         sort
         L ) ) )
(test
   '(red green abrakadabra)
   (f4-112 '(abrakadabra red green)) )

#4.113
(de f4-113 (L)
   (mapcar car L) )
(test
   '(a c a)
   (f4-113 '((a b) (c d) (a d))) )

#4.114
(de f4-114 (L)
   (make
      (for (I . X) L
         (or (bit? 1 I) (link X)) ) ) )
(test
   (2 4)
   (f4-114 (1 2 3 4 5)) )

#4.115
(de f4-115 (L)
   (filter sym? L) )
(test
   '(a b c)
   (f4-115 '(1 a 2 b 3 c)) )

#4.116
(de f4-116 (L)
   (make
      (for (I L I (cdr I))
         (link (apply * I)) ) ) )
(test
   (720 720 360 120 30 6)
   (f4-116 (range 1 6)) )

#4.117 - Rosetta Code
(de f4-117 (Lst)
   (map
      '((L) (and (cdr L) (xchg L (member (apply min @) L))))
      Lst )
   Lst )
(test
   (1 1 2 2 3 3 4 4)
   (f4-117 (1 2 3 4 1 2 3 4)) )

#4.118 - ignored

#4.119
(de f4-119 (L)
   (mapcar
      '((C)
         (cond
            ((gt0 C) 'positive)
            ((lt0 C) 'negative)
            ((=0 C)  'zero)
            (T C) ) )
      L ) )
(test
   '(a negative zero positive)
   (f4-119 '(a -1 0 1)) )

#4.120
(de f4-120 (L)
   (filter
      '((C) (not (< 100 (char C) 107)))
      L ) )
(test
   '(a z)
   (f4-120 '(a e j z)) )

#4.121
(de f4-121 (L)
   (make
      (let Last NIL
         (for (I L I (cdr I))
            (or
               (= Last (car I))
               (= (cadr I) (car I))
               (yoke (car I)) )
            (setq Last (car I)) ) ) ) )
(test
   (3 6 5 2)
   (f4-121 (2 3 3 4 4 5 6 3 4 4)) )

#4.122
(de f4-122 (L)
   (by '((N) (bit? 1 N)) group L) )
(test
   '((3 45 3 3) (458 4 434))
   (f4-122 (3 45 458 3 4 3 434)) )

#4.123
(de f4-123 (L)
   (apply
      conc
      (by '((N) (< 0 N)) group L) ) )
(test
   (-7 -2 -9 -1 1 8 4 9)
   (f4-123 (-7 1 8 -2 -9 4 9 -1)) )

#4.124 - ignored

#4.125
(de f4-125 (L)
   (mapcan flip L) )
(test
   '(b a d c)
   (f4-125 '((a b) (c d))) )

#4.126
(de f4-126 (L)
   (recur (L)
      (if (atom L)
         (inc L)
         (mapcar recurse L) ) ) )
(test
   '((2 3 4) (5 6 7) (8 9 (10)))
   (f4-126 '((1 2 3) (4 5 6) (7 8 (9)))) )

#4.127
(de f4-127 (L) # Rosetta
   (if (cdr L)
      (let Pivot (car L)
         (append
            (f4-127
               (filter '((A) (< A Pivot)) (cdr L)) )
            (filter '((A) (= A Pivot)) L)
            (f4-127
               (filter '((A) (> A Pivot)) (cdr L)) ) ) )
      L ) )
(test
   '(0 1 2 2 3 3 4 4 4 5 6 7 8 9 9)
   (f4-127 '(7 4 9 2 4 3 8 1 0 6 9 3 4 2 5)) )

#4.128
(de f4-128 (L)
   (make
      (for (I L I (cddr I))
         (if (cdr I)
            (link (cadr I) (car I))
            (chain I) ) ) ) )
(test
   (2 1 4 3 5)
   (f4-128 (1 2 3 4 5)) )
(test
   (2 1 4 3)
   (f4-128 (1 2 3 4)) )

#4.129
(de f4-129 (L)
   (recur (L)
      (if (atom L)
         (cond
            ((= 'sin L) 'cons)
            ((= 'sqrt L) 'abs)
            (T L) )
         (mapcar recurse L) ) ) )
(test
   '((cons (abs 90)) + (cons (abs 90)))
   (f4-129 '((sin (sqrt 90)) + (sin (sqrt 90)))) )

#4.130
(de f4-130 (L)
   (let (F NIL  M NIL)
      (mapc
         '((I) (accu (cadddr I) (cadr I) 1))
         L )
      (cons
         (car (maxi cdr M))
         (car (maxi cdr F)) ) ) )
(test
   '(Ivan . Anna)
   (f4-130
      (quote
         (Ivanov Ivan Ivanovich M 20 2)
         (Petrov Ivan Ivanovich M 20 2)
         (Petrova Anna Ivanovna F 20 2)
         (Petrova Inna Ivanovna F 20 2)
         (Ivanova Anna Ivanovna F 20 2) ) ) )

#4.131
(de f4-131 (L)
   (mapcar
      list
      '(Name Age Height)
      L ) )
(test
   '((Name Ann) (Age 20) (Height 160cm))
   (f4-131 '(Ann 20 160cm)) )

#4.132 - ignored

#4.133
(de f4-133 (L)
   (make
      (for (I . X) L
         (link (cons I X)) ) ) )
(test
   '((1 . 11) (2 . 12) (3 . 13) (4 . 14))
   (f4-133 (11 12 13 14)) )

#4.134
(de f4-134 (L)
   (uniq (fish atom L)) )
(test
   (1 2 3 4)
   (f4-134 '((1) 2 (3 (4 1) 2) ((3)) 4 ((1) 2))) )

#4.135
(de f4-135 (L)
   (fish atom L) )
(test
   '(a b c d e)
   (f4-135 '(a (b (c (d (e)))))) )

#4.136
(de street (L)
   (caddr L) )
(de numb (L)
   (cadddr L) )
(de apart (L)
   (car (cddddr L)) )
(de key136 (L)
   (list (street L) (numb L) (apart L)) )
(de accu136 (Var Key Name)
   (if (assoc Key (val Var))
      (push (cdr @) Name)
      (push Var (list Key (list Name))) ) )
(de f4-136 (L) # KISS
   (let R NIL
      (for I L
         (accu136 'R (key136 I) (car I)) )
      (extract
         '((L)
            (and (cdadr L) (cadr L)) )
         R ) ) )
(test
   '((Petrova Ivanov))
   (f4-136
      (quote
         (Ivanov Rostov Lenina 10 11)
         (Petrov Noginsk Lenina 100 111)
         (Petrova Podolsk Lenina 10 11) ) ) )

#4.137
(de f4-137 (C L F)
   (let R NIL
      (for I (filter F L)
         (accu 'R I 1) )
      (extract
         '((L)
            (and
               (< C (cdr L))
               (car L) ) )
         R) ) )
(test
   (2)
   (f4-137 2 (1 2 3 1 3 2 3 2 2) evenp?) )
(test
   (3)
   (f4-137 2 (1 2 3 1 3 2 3 2 2) oddp?) )
(test
   (3 5)
   (f4-137 2 (1 2 5 3 1 3 5 2 3 2 5 2) oddp?) )

#4.138
(de f4-138 (C L)
   (filter
      '((W) (= C (last (chop W))) )
      L ) )
(test
   '("aaaz" "bbbz")
   (f4-138 'z '("aaab" "aaac" "aaaz" "bbbc" "bbbz")) )

#4.139
(de f4-139 (L)
   (if (or (apply <= L) (apply >= L))
      L
      (make
         (for (I . X) L
            (cond
               ((not (bit? 1 I)) (link (* 3 X)))
               ((and (bit? 1 I) (=0 (% X 4))))
               (T (link X)) ) ) ) ) )
(test
   (1 21 3 12 18 24)
   (f4-139 '(1 7 3 4 8 6 12 8)) )

#4.140
(de f4-140 (L)
   (if (bit? 1 (car L))
      (cdr L)
      (cons (inc (car L)) (cdr L)) ) )
(test
   (3 1)
   (f4-140 (2 1)) )
(test
   (2 1)
   (f4-140 (3 2 1)) )

#4.141
(de f4-141 (L)
   (if (and (lt0 (cadr L)) (bit? 1 (cadr L)))
      (head -1 L)
      (cons (cadr L) (cons (car L) (cddr L))) ) )
(test
   (2 1 3 4)
   (f4-141 (1 2 3 4)) )
(test
   (2 -1 3)
   (f4-141 (2 -1 3 4)) )

#4.142
(de f4-142 (L)
   (let (R NIL  S '(queue push .))
      (mapc
         '((N) ((pop 'S) 'R N))
         (sort L) )
      R ) )
(test
   (5 3 1 0 2 4 6)
   (f4-142 '(3 2 1 5 6 0 4)) )

#4.143
(de f4-143 (L)
   (let
      (Min (apply min L)
         Max (apply max L)
         Pos (index Max L) )
      (if (= (* 2 Min) Max)
         (make
            (for (I . X) L
               (link (if (< I Pos) Min X)) ) )
         L ) ) )
(test
   (1 5 3 2 1 2 3 5 6 12)
   (f4-143 '(1 5 3 2 1 2 3 5 6 12)) )
(test
   (3 3 3 3 3 3 3 6 3 4 5)
   (f4-143 '(5 5 3 4 4 3 5 6 3 4 5)) )

#4.144
(de f4-144-1 (F L) # make
   (make
      (for I L
         (and (F I) (link '*))
         (link I) ) ) )
(de f4-144-2 (F L) # mapcan
   (mapcan
      '((N)
         (conc
            (and (F N) (cons '*))
            (cons N) ) )
      L ) )
(test
   (-1 * 2 -3 -4 -5 -6 * 7 * 8 * 9)
   (f4-144-1 gt0 (-1 2 -3 -4 -5 -6 7 8 9)) )
(test
   '(* 0 -1 * 2 -3 -4)
   (f4-144-1 ge0 (0 -1 2 -3 -4)) )
(test
   (-1 * 2 -3 * -4 -5 * -6 7 * 8 9)
   (f4-144-1 evenp? (-1 2 -3 -4 -5 -6 7 8 9)) )
(test
   (f4-144-1 ge0 (0 -1 2 -3 -4))
   (f4-144-2 ge0 (0 -1 2 -3 -4)) )

#4.145
(de f4-145 (L)
   (make
      (for (I L I (cddr I))
         (link (head 2 I)) ) ) )
(test
   '((1 2) (3 4))
   (f4-145 (1 2 3 4)) )
(test
   '((1 2) (3 4) (5))
   (f4-145 (1 2 3 4 5)) )

#4.146
(de f4-146 (L N) #N99
   (mapcan '((I) (need N I)) L) )
(test
   (1 1 2 2 3 3)
   (f4-146 (1 2 3) 2) )

#4.147
(de accu147 (Var Age Name)
   (let L (assoc Age (val Var))
      (ifn L
         (push Var (list Age 1 (list Name)))
         (push (cddr L) Name)
         (inc (cdr L)) ) ) )
(de age147 (L)
   (car (cddddr L)) )
(de f4-147 (L)
   (let R NIL
      (for I L
         (accu147 'R (age147 I) (car I)) )
      (caddr (maxi cadr R)) ) )
(test
   '(Semenova Ivanova)
   (f4-147
      (quote
         (Ivanova Anna Savishna F 20 3)
         (Petrova Olga Andreevna F 21 3)
         (Semenova Alina Sergeevna F 20 2) ) ) )

#4.148
(de f4-148 (L)
   (let R NIL
      (for I L
         (accu 'R I 1) )
      (extract
         '((I) (and (=1 (cdr I)) (car I)))
         R ) ) )
(test
   '(c b)
   (f4-148 '(a b a a c)) )

#4.149
(de f4-149 (L)
   (let R NIL
      (for I (fish atom L)
         (and I  (accu 'R I 1)) )
      R ) )
(test
   '((8 . 1) (3 . 1) (k . 2) (c . 1) (b . 2) (a . 2))
   (f4-149 '(a b c b (a ((k)) ()) (3 8 k))) )

#4.150
(de f4-150 (L)
   (make
      (for (I L I (cddr I))
         (link (car I))
         (and (cadr I) (link (cons @))) ) ) )
(test
   '(a (b) c (d))
   (f4-150 '(a b c d)) )
(test
   '(a (b) c (d) e)
   (f4-150 '(a b c d e)) )

#4.151
(de f4-151 (L1 D1)
   (make
      (for (I . X) L1
         (or
            (member I D1)
            (link X) ) ) ) )
(test
   '(a s h j)
   (f4-151 '(a s d f g h j) (3 4 5)) )

#4.152
(de f4-152 (L1 L2)
   (sect
      (uniq (fish atom L1))
      (uniq (fish atom L2)) ) )
(test
   (3 4)
   (f4-152 '((1) 3 4 (3)) '((3 4) 5)) )

#4.153
(de f4-153 (Lst)
   (extract
      '((L)
         (and
            (gt0
               (cnt '((N) (> 3 N)) (cddr L)) )
            (car L) ) )
      Lst ) )
(test
   '(Ivanov Sidorov)
   (f4-153
      (quote
         (Ivanov 2 4 5 2)
         (Petrov 4 4 4 4)
         (Sidorov 3 2 2 2) ) ) )

#4.154
(de f4-154 (L)
   (maplist '((L) (apply * L)) L) )
(test
   (720 720 360 120 30 6)
   (f4-154 (1 2 3 4 5 6)) )

#4.155
(de f4-155 (L)
   (head 3 (sort L)) )
(test
   (1 1 2)
   (f4-155 (6 5 4 3 2 1 1 2 3)) )

#4.156
(de f4-156 (L N M)
   (filter
      '((I) (nor (pair I) (<= N I M)))
      L ) )
(test
   '(1 11 22 33 w e r)
   (f4-156 '(1 2 3 4 11 22 33 (w e r) w e r) 2 4) )

#4.157
(de f4-157 (L)
   (mapcar
      '((I) (if (atom I) I 'A))
      L ) )
(test
   '(A 5 6 A)
   (f4-157 '((3 4) 5 6 (5 (5 8)))) )

#4.158
(de findSteps (L)
   (let C 0
      (and
         (find
            '((N) (and (inc 'C) (lt0 N)))
            L )
         (cons C @) ) ) )
(de nextlt0 (L R)
   (let (L (findSteps L)  R (findSteps R))
      (cond
         ((not L) (cdr R))
         ((not R) (cdr L))
         ((>= (car L) (car R)) (cdr R))
         (T (cdr L)) ) ) )
(de f4-158 (L)
   (let LL NIL
      (make
         (for (I L I (cdr I))
            (link
               (if (lt0 (car I))
                  @
                  (nextlt0 LL (cdr I)) ) )
            (push 'LL (car I) ) ) ) ) )
(test
   (-2 -2 -4 -4 -5 -5 -5 -2 -2 -2 -2)
   (f4-158 (1 -2 3 -4 -5 6 7 7 7 -2 8)) )

#4.159
(de f4-159 (A L)
   (mapcar
      '((I) (if (atom I) A I))
      L ) )
(test
   '((+ 1 2) (+ 1 2) (+ 1 2))
   (f4-159 '(+ 1 2) '(A B C)) )
(test
   '((+ 1 2) (1 2 3) (+ 1 2))
   (f4-159 '(+ 1 2) '(A (1 2 3) B)) )

#4.160
(de f4-160 (L)
   (mapcar flip L) )
(test
   '((C B A) (AA Z1 D1 F1))
   (f4-160 '((A B C) (F1 D1 Z1 AA))) )

#4.161
(de f4-161-1 (Lst)
   (let (L NIL  R NIL)
      (for I Lst
         (cond
            ((gt0 I) (push 'L I))
            ((lt0 I) (push 'R I)) ) )
      (list L R) ) )
(de f4-161-2 (Lst)
   (by
      '((I)
         (cond
            ((gt0 I) T)
            ((lt0 I) NIL)
            (T 0) ) )
      group
      Lst ) )
(test
   '((2 1) (-1 -2))
   (f4-161-1 (-2 -1 0 1 2)) )
(test
   '((-2 -1) (0) (1 2))
   (f4-161-2 (-2 -1 0 1 2)) )

#4.162
(de f4-162 (Lst)
   (mapcar car Lst) )
(test
   '(W W I)
   (f4-162 '((W o r l d) (W a r) (I))) )

#4.163
(de f4-163 (Lst)
   (if (fully sym? Lst)
      (cons (car Lst) (last Lst))
      (remove 2 Lst) ) )
(test
   '(A . E)
   (f4-163 '(A B C G E)) )
(test
   '(A C G 10)
   (f4-163 '(A B C G 10)) )

#4.164
(de f4-164 (Lst)
   (mapcar length Lst) )
(test
   (3 4 4)
   (f4-164 '(abc defg hijk)) )

#4.165
(de prec (Op)
   (case Op
      (("*" "/") 3)
      (("+" "-") 2) ) )
(de f4-165 (Lst) # In memory of Mr.Dijkstra
   (let S NIL
      (make
         (for Op Lst
            (if (num? Op)
               (link @)
               (while (and S (>= (prec (car S)) (prec Op)))
                  (link (pop 'S)) )
               (push 'S Op) ) )
         (while S
            (link (pop 'S))) ) ) )
(test
   '(3 2 * 5 -)
   (f4-165 '(3 * 2 - 5)) )
(test
   '(1 2 3 * + 4 -)
   (f4-165 '(1 + 2 * 3 - 4)) )

#4.166
(de f4-166 (Lst)
   (mapcar
      '((N)
         (if (bit? 1 N)
            (inc N)
            (dec 'N 2) ) )
      Lst ) )
(test
   (2 0 4 2 6 4 8 6 10)
   (f4-166 (range 1 9)) )

#4.167 = 4.65

#4.168
(de accqueue (Var Key)
   (if (assoc Key (val Var))
      (con @ (inc (cdr @)))
      (queue Var (cons Key 1)) ) )
(de f4-168 (Lst)
   (let R NIL
      (for I Lst
         (accqueue 'R I 1) )
      (extract
         '((L) (and (=1 (cdr L)) (car L)))
         R ) ) )
(test
   '(f bb gg)
   (f4-168 '(aa f aa bb ff gg ff)) )

#4.169
(de f4-169 (Lst)
   (let N (/ (length Lst) 2)
      (make
         (for I N
            (link
               (+ (get Lst I) (get Lst (+ I N))) ) ) ) ) )
(test
   (7 9 11 13 15)
   (f4-169 (range 1 10)) )

#4.170
(de f4-170 (Lst)
   (filter atom Lst) )
(test
   (1 3 5)
   (f4-170 '(1 (2) 3 (4) 5)) )

#4.171
(de f4-171 (L)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L) (inc L) (mapcar recurse L)) ) )
      L ) )
(test
   '((2 3) 4 (5 6))
   (f4-171 '((1 2) 3 (4 5))) )

#4.172
(de f4-172 (L N)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L) (* N L) (mapcar recurse L)) ) )
      L ) )
(test
   '((3 6) 9 (12 15))
   (f4-172 '((1 2) 3 (4 5)) 3) )

#4.173
(de f4-173 (L)
   (mapcar
      '((C)
         (if (<= `(char 'a) (char C) `(char 'z))
            (- (char C) 96)
            C ) )
      L ) )
(test
   '(1 19 4 ! 18 26)
   (f4-173 '(a s d ! r z)) )

#4.174
(de f4-174 (L)
   (make
      (while L
         (if (pair (car L))
            (mapc link (pop 'L))
            (link
               (make
                  (link (pop 'L))
                  (while
                     (and
                        L
                        (atom (car L))
                        (link (pop 'L)) ) ) ) ) ) ) ) )
(test
   '(a (b c) d e (f g) h i)
   (f4-174 '((a) b c (d e) f g (h i))) )
(test
   '(2 (3) 4 5)
   (f4-174 '((2) 3 (4 5))) )

#4.175
(de f4-175-1 (L) # destructive
   (xchg
      (nth L 1)
      (nth L (length L)) )
   L )
(de f4-175-2 (L) # non-destructive
   (cons
      (last L)
      (conc
         (head -1 (cdr L))
         (cons (car L)) ) ) )
(test
   (f4-175-1 '(NIL 1 2 3 4 5))
   (f4-175-2 '(NIL 1 2 3 4 5)) )
(test
   (f4-175-1 (1 2 3 4 5))
   (f4-175-2 (1 2 3 4 5)) )

#4.176
(de f4-176 (Lst)
   (mapcar
      '((F)
         (let A (apply F Lst)
            (make
               (for (I . X) Lst
                  (and (= X A) (link I)) ) ) ) )
         '(min max) ) )
(test
   '((1 5 9) (4 8 12))
   (f4-176 (1 2 3 4 1 2 3 4 1 2 3 4)) )


#4.177
(de f4-177 (Lst)
   (maxi
      '((L)
         (length
            (sect
               (chop (car L))
               (chop (cadr L)) ) ) )
      (subsets 2 Lst) ) )
(test
   '(abcde bcdef)
   (f4-177 '(abcde defgi bcdef)) )

#4.178
(de f4-178 (Lst)
   (mapcar
      '((L)
         (let (A (apply min L)  B (apply max L))
            (xchg
               (nth L (index A L))
               (nth L (index B L)) )
            L ) )
      Lst ) )
(test
   '((5 2 3 4 1) (1 4 3 2 5) (5 2 3 4 1))
   (f4-178 '((1 2 3 4 5) (5 4 3 2 1) (1 2 3 4 5))) )

#4.179
(de f4-179 (Lst)
   (make
      (for (I Lst I (cddr I))
         (link (car I)) ) ) )
(test
   (1 3 5 7)
   (f4-179 (1 2 3 4 5 6 7)) )
(test
   (1 3)
   (f4-179 (1 2 3 4)) )

#4.180
(de f4-180 (L)
   (filter
      '((A) (and (pair A) (cdddr A)))
      L ) )
(test
   '((4 5 6 7))
   (f4-180 '(1 (2 3) (4 5 6 7) 8 (9 0))) )

#4.181
(de randN ()
   (make
      (do 4096
         (link (rand 1 4096)) ) ) )
(de f4-181 (L)
   (let (A (apply min L)  B (apply max L))
      (list
         (index A L)
         (index B L) ) ) )
(test
   T
   (fully num? (f4-181 (randN))) )

#4.182 - without interactive
(de f4-182 (F Lst)
   (extract
      '((L) (and (= F (car L)) (cadr L)))
      Lst ) )
(test
   (1994 1995)
   (f4-182
      'Ivanov
      (quote
         (Ivanov 1994)
         (Petrov 1993)
         (Ivanov 1995) ) ) )

#4.183
(de f4-183-1 (L)
   (cond
      ((not L))
      ((atom L) (cons (bool (=0 L))))
      (T (append (f4-183-1 (car L)) (f4-183-1 (cdr L)))) ) )
(de f4-183-2 (L)
   (mapcan
      '((L)
         (recur (L)
            (if (atom L)
               (cons (bool (=0 L)))
               (mapcan recurse L) ) ) )
      L ) )
(test
   (f4-183-1 '(((1)) 0 (1)))
   (f4-183-2 '(((1)) 0 (1))) )

#4.184
(de f4-184 (L)
   (let (A 0  P 0)
      (mapc
         '((L)
            (recur (L)
               (if (atom L)
                  (inc 'A)
                  (inc 'P)
                  (mapc recurse L) ) ) )
         L )
      (list A P) ) )
(test
   (6 5)
   (f4-184 '((1 2) (3 (4)) 5 ((6)))) )

#4.185
(de f4-185 @
   (apply mapcar (rest) *) )
(test
   (1000 8000)
   (f4-185 (1 2) (10 20) (100 200)) )

#4.186
(de f4-186 (Lst)
   (make
      (for (I Lst I (cddr I))
         (and
            (cdr I)
            (link (cadr I)) )
         (link (car I)) ) ) )
(test
   (2 1 4 3 6 5)
   (f4-186 (range 1 6)) )
(test
   (2 1 4 3 6 5 7)
   (f4-186 (range 1 7)) )

#4.187
(de f4-187 (L)
   (let S (/ (apply + L) (length L))
      (filter
         '((N) (>= S N))
         L ) ) )
(test
   (1 2 3 4)
   (f4-187 (range 1 7)) )

#4.188
(de f4-188 (L)
   (let M (apply max (filter lt0 L))
      (make
         (for (I . X) L
            (link
               (if (bit? 1 I) X M) ) ) ) ) )
(test
   (-2 -1 0 -1 2 -1)
   (f4-188 (-2 -1 0 1 2 3)) )

#4.189
(de f4-189 (L)
   (make
      (for I L
         (yoke I) ) ) )
(test
   (5 4 3 2 1)
   (f4-189 (1 2 3 4 5)) )

#4.190
(de f4-190 (L)
   (make
      (for (I . X) L
         (and (bit? 1 I) (link X)) ) ) )
(test
   (1 3 5)
   (f4-190 (1 2 3 4 5 6)) )

#4.191
(de accuNum (V I)
   (let X (accu V I 1)
      (if (num? X) @ (cdr X)) ) )
(de f4-191 (L)
   (let R NIL
      (make
         (for I L
            (and
               (accuNum 'R I)
               (not (=0 (% @ 3)))
               (link I) ) ) ) ) )
(test
   '(a 1 s 2 d 3 a 1 s 2 d)
   (f4-191 '(a 1 s 2 d 3 a 1 s 2 2 d a 1 s d)) )

#4.192
(de f4-192 (L)
   (filter
      '((I) (not (find format (chop I))))
      L ) )
(test
   '(asd gh a s)
   (f4-192 '(asd gh f12s 6 7 a s h7)) )

#4.193
(de f4-193 (Lst)
   (let
      (L (length Lst)
         M
         (-
            (/ L 2)
            (if (bit? 1 L) 0 1) ) )
      (conc (head M Lst) (tail M Lst)) ) )
(test
   (1 4)
   (f4-193 (1 2 3 4)) )
(test
   (1 3)
   (f4-193 (1 2 3)) )

#4.194
(de f4-194 (Lst)
   (let S
      (apply
         +
         (mapcar
            '((I)
               (format
                  (pack (if (filter format (chop I)) @ 0)) ) )
            Lst ) )
      (mapcar
         '((I)
            (intern
               (pack
                  S
                  "_"
                  (extract
                     '((J) (and (not (format J)) (char J)))
                     (chop I) ) ) ) )
         Lst ) ) )
(test
   '(7_100 7_114 7_115)
   (f4-194 '(2d 4r 1s)) )
(test
   '(124_109105107101 124_98)
   (f4-194 '(123mike 1b)) )

#4.195
(de f4-195 (F L)
   (make
      (for (I L I (cdr I))
         (link (F I)) ) ) )
(test
   '((6 5 4 3 2 1) (6 5 4 3 2) (6 5 4 3) (6 5 4) (6 5) (6))
   (f4-195 reverse (1 2 3 4 5 6)) )

#4.196
(de f4-196-1 (L)
   (mapcar
      '((I) ((if (pair I) apply pass) + I))
      L ) )
(de f4-196-2 (L)
   (mapcar
      '((I) (if (num? I) @ (apply + I)))
      L ) )
(test
   (f4-196-1 '(1 (1 2) (1 2 3)))
   (f4-196-2 '(1 (1 2) (1 2 3))) )

#4.197
(de f4-197 (X Lst)
   (mapcan
      '((L)
         (recur (L)
            (if2 (= X L) (atom L)
               NIL
               NIL
               (cons L)
               (cons (mapcan recurse L)) ) ) )
      Lst ) )
(let Lst '(1 ((1 2 (2)) 1) (2) 1 2)
   (test
      '(1 ((1 2) 1) 1 2)
      (f4-197 (2) Lst) )
   (test
      '(((2 (2))) (2) 2)
      (f4-197 1 Lst) ) )

#4.198
(de f4-198 (L)
   (uniq (fish atom L)) )
(test
   '(a b c)
   (f4-198 '((a b) ((a)) a c)) )

#4.199
(de f4-199 (Lst) # N99
   (mapcon
      '((L)
         (unless (= (car L) (cadr L))
            (cons (car L)) ) )
      Lst ) )
(test
   '(a b c d e)
   (f4-199 '(a a b c c c d e e)) )

#4.200
(de f4-200 (Lst)
   (flip
      (make
         (for I Lst
            (and (>= I (car (made))) (yoke I)) ) ) ) )
(test
   (1 2 3 4)
   (f4-200 (1 2 3 4 1)) )
(test
   (1 2 3 4)
   (f4-200 (1 2 3 1 4)) )

#4.201
(de f4-201 (Lst)
   (maxi
      length
      (make
         (for (I Lst I (cdr I))
            (link
               (flip
                  (make
                     (for (J I J (cdr J))
                        (NIL (> (car J) (car (made))))
                        (yoke (car J)) ) ) ) ) ) ) ) )
(test
   (1 2 3 4)
   (f4-201 (1 2 3 1 2 3 4 1 2)) )

#4.202
(de f4-202 (Lst)
   (maxi
      '((L) (sum caddr L))
      (make
         (for I Lst
            (let (X (cadr I)  Lst (copy Lst))
               (and
                  (make
                     (setq Lst (delete (link I) Lst))
                     (while
                        (setq X
                           (cadr
                              (find
                                 '((I) (and (= X (car I)) I))
                                 Lst ) ) )
                        (setq Lst (delete (link @@) Lst)) ) )
                  (link @) ) ) ) ) ) )
(test
   '((d k 2) (k b 7) (b c 3) (c e 5))
   (f4-202 '((c e 5) (a b 1) (d k 2) (b c 3) (f p 4) (p f 6) (k b 7))) )

#4.203
(de f4-203 (F Lst)
   (apply
      conc
      (maplist F Lst) ) )
(test
   '((1 2 3 4 5) (2 3 4 5) (3 4 5) (4 5) (5))
   (f4-203 list (1 2 3 4 5)) )
(test
   (1 2 3 4 5 2 3 4 5 3 4 5 4 5 5)
   (f4-203 copy (1 2 3 4 5)) )
(test
   (5 4 3 2 1 5 4 3 2 5 4 3 5 4 5)
   (f4-203 reverse (1 2 3 4 5)) )

#4.204
(de f4-204 (Lst)
   (when (cdr Lst)
      (cons (car Lst) (f4-204 (cdr Lst))) ) )
(test
   (1 2 3)
   (f4-204 (1 2 3 4)) )

#4.205
(de f4-205 (Lst)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L)
               L
               (mapcar recurse (reverse L)) ) ) )
      (reverse Lst) ) )
(test
   '(((7) 6) (5 (4 (3 2))) 1)
   (f4-205 '(1 (((2 3) 4) 5) (6 (7)))) )

#4.206
(de f4-206 (Lst)
   (list
      (filter '((N) (not (num? N))) Lst)
      (apply
         +
         (filter num? Lst) ) ) )
(test
   '((a (2 3) (a b) (4)) 3)
   (f4-206 '(1 a (2 3) (a b) 2 (4))) )

#4.207 - ignored

#4.208
(de f4-208 (Lst)
   (mapcar
      '((L)
         (recur (L)
            (if2
               (pair L)
               (and
                  (num? L)
                  (gt0 L)
                  (not (bit? 1 L)) )
               NIL
               (mapcar recurse L)
               (format (flip (chop L)))
               L ) ) )
      Lst ) )
(test
   '((21 45 -72) (a b 15) (49 c 81))
   (f4-208 '((12 45 -72) (a b 15) (49 c 18))) )

#4.209
(de f4-209 (Lst)
   (mapcar prime? Lst) )
(test
   '(T T NIL T NIL T NIL NIL NIL T)
   (f4-209 (range 2 11)) )

#4.210
(de f4-210-1 (Lst)
   (make
      (while Lst
         (let (Y (pop 'Lst)  X (cadr Y))
            (and
               (setq @@
                  (make
                     (setq Lst (delete (link Y) Lst))
                     (while
                        (setq X
                           (cadr
                              (find
                                 '((I) (and (= X (car I)) I))
                                 Lst ) ) )
                        (setq Lst (delete (link @@) Lst)) ) ) )
               (cdr @@)
               (link @@) ) ) ) ) )
(de f4-210-2 (Lst)
   (let L (copy Lst)
      (make
         (for I L
            (let X (cadr I)
               (and
                  (member I Lst)
                  (setq @@
                     (make
                        (setq Lst (delete (link I) Lst))
                        (while
                           (setq X
                              (cadr
                                 (find
                                    '((I) (and (= X (car I)) I))
                                    Lst ) ) )
                           (setq Lst (delete (link @@) Lst)) ) ) )
                  (or
                     (cdr @@)
                     (nil (push 'Lst (car @@))) )
                  (link @@) ) ) ) ) ) )
# task unclear, I can solve in two and counting ways
#
(let  L '((a 2) (n 6) (2 f) (a v) (6 b) (f p) (d a))
   (test
      '(((a 2) (2 f) (f p)) ((n 6) (6 b)))
      (f4-210-1 L) )
   (test
      '(((a 2) (2 f) (f p)) ((n 6) (6 b)) ((d a) (a v)))
      (f4-210-2 L) ) )

#4.211
(de f4-211 (Lst)
   (mapcar
      '((L)
         (intern (pack (reverse (chop L)))) )
      Lst ) )
(test
   '(imortal deeds)
   (f4-211 '(latromi sdeed)) )

#4.212
(de f4-212 (Str)
   (glue " " (f4-211 (str Str))) )
(test
   "imortal deeds"
   (f4-212 "latromi sdeed") )

#4.213 - ignored

#4.214
(de f4-214 (Lst)
   (let M (apply min (filter gt0 Lst))
      (make
         (for (I . X) Lst
            (link (if (bit? 1 I) X M)) ) ) ) )
(test
   (0 1 2 1 4 1 6 1 8)
   (f4-214 (range 0 8)) )

#4.215
(de f4-215 (Lst)
   (let
      (Len (length Lst)
         L (+ Len (if (bit? 1 Len) 1 0)) )
      (tail (/ L 2) Lst) ) )
(test
   (4 5 6)
   (f4-215 (range 1 6)) )
(test
   (4 5 6 7)
   (f4-215 (range 1 7)) )

#4.216
(de f4-216 (Lst) # N99
   (mapcar
      '((L)
         (if (cdr L)
            (cons (car L) (length L))
            (car L) ) )
      (make
         (let Last NIL
            (for I Lst
               (if (= I (car Last))
                  (conc Last (cons I))
                  (link (setq Last (cons I))) ) ) ) ) ) )
(test
   '((nil . 2) a (b . 3) (c . 3) d (nil . 3))
   (f4-216 '(nil nil a b b b c c c d nil nil nil)) )

#4.217
(de f4-217-1 (Lst)
   (cons
      (cnt gt0 Lst)
      (sum gt0 Lst) ) )
(de f4-217-2 (Lst) # one pass
   (let (C 0  S 0)
      (for I Lst
         (and
            (gt0 I)
            (inc 'C)
            (inc 'S I) ) )
      (cons C S) ) )
(let L (-1 0 1 2 3)
   (test
      (f4-217-2 L)
      (f4-217-1 L) ) )

#4.218
(de f4-218 (Lst)
   (mapcan
      '((N)
         (and (=0 (% N 3)) (cons N)) )
      Lst ) )
(test
   (3 6 9)
   (f4-218 (range 1 10)) )

#4.219
(de f4-219 (Lst X)
   (mapcan
      '((N)
         (and (=0 (% N X)) (cons N)) )
      Lst ) )
(test
   (3 6 9)
   (f4-219 (range 1 10) 3) )
(test
   (4 8)
   (f4-219 (range 1 10) 4) )

#4.220
(de f4-220 (Lst)
   (list
      (apply
         mapcar
         Lst
         '(@ (sum '((N) (gt0 N)) (rest))) )
      (apply
         mapcar
         Lst
         '(@ (cnt '((N) (gt0 N)) (rest))) ) ) )
(test
   '((11 10 9) (2 2 2))
   (f4-220 '((-1 2 3) (4 -5 6) (7 8 -9))) )

#4.221
(de f4-221 (Lst)
   (let
      (Min (apply min Lst)
         R (list Min (apply max Lst)) )
      (make
         (for I Lst
            (apply link (if (= Min I) R (cons I))) ) ) ) )
(test
   (0 5 1 2 5 1 2 3 0 5 1 2 3 0 5 4)
   (f4-221 (0 1 2 5 1 2 3 0 1 2 3 0 4)) )

#4.222
(de f4-222 (Lst)
   (mapcar
      '((L)
         (let (Min (apply min L)  Max (apply max L))
            (setq L
               (remove
                  (index Min L)
                  L ) )
            (setq L
               (remove
                  (index Max L)
                  L ) )
            (conc (cons Max) L (cons Min)) ) )
      Lst ) )
(test
   '((33 11 2 3 1) (6 5 4) (9 8 7))
   (f4-222 '((11 33 1 2 3) (4 5 6) (7 8 9))) )
(test
   '((3 2 1) (6 5 4) (9 8 7))
   (f4-222 '((1 2 3) (4 5 6) (7 8 9))) )

#4.223
(de f4-223 (Lst)
   (make
      (for (I 0 (>= 3 I) (inc I))
         (apply link (subsets I Lst)) ) ) )
(test
   '(NIL (A) (B) (C) (A B) (A C) (B C) (A B C))
   (f4-223 '(A B C)) )

#4.224
(de f4-224 (Lst)
   (mapcar '((N) (bool (num? N))) Lst) )
(test
   '(NIL T NIL NIL NIL T)
   (f4-224 '(NIL 1 a a7a (1 2 a) 777)) )

#4.225
(de f4-225 (L N M)
   (let X (get L N)
      (place M (place N L (get L M)) X) ) )
(test
   (11 555 33 44 22)
   (f4-225 (11 22 33 44 555) 2 5) )

#4.226
(de f4-226 (L N M)
   (xchg (nth L N) (nth L M))
   L )
(test
   (11 555 33 44 22)
   (f4-226 (11 22 33 44 555) 2 5) )

#4.227
(de f4-227 (Lst)
   (mapcar
      '((L)
         (let (Len (length L)  N (/ Len 2))
            (if (bit? 1 Len)
               (conc
                  (head N L)
                  (tail N L) )
               L ) ) )
      Lst ) )
(test
   '((3 7) (2 4) (2 5) (7 1) (8 9 4 5))
   (f4-227 '((3 7) (2 7 4) (2 9 5) (7 1) (8 9 2 4 5))) )

#4.228
(de f4-228 (Lst)
   (make
      (for (I . L) Lst
         (let Y (index (apply max L) L)
            (link (f4-225 L I Y)) ) ) ) )
(test
   '((3 2 1) (4 6 5) (7 8 9))
   (f4-228 '((1 2 3) (4 5 6) (7 8 9))) )

#4.229
(de f4-229-1 (Lst)
   (make
      (while Lst
         (let S (pop 'Lst)
            (ifn (memq S '(+ -))
               (link S)
               (while (and Lst (memq (car Lst) '(+ -)))
                  (setq S
                     (if (== S (pop 'Lst)) '+ '-) ) )
               (link S) ) ) ) ) )
(de f4-229-2 (Lst)
   (for (L Lst (cdr L))
      (cond
         ((num? (car L)) (pop 'L))
         ((num? (cadr L)) (setq L (cddr L)))
         (T
            (set L
               (if (== (car L) (cadr L))
                  '+
                  '- ) )
            (con L (cddr L)) ) ) )
      Lst )
(test
   (f4-229-1 '(1 + - + + - 1 - - - + 1 + + - 1))
   (f4-229-2 '(1 + - + + - 1 - - - + 1 + + - 1)) )

#4.230
(de f4-230 (Lst)
   (f4-229-1 Lst) )
(test
   '(1 + 1 - 1 - 1)
   (f4-230 '(1 + - + + - 1 - - - + 1 + + - 1)) )
(test
   '(A + A)
   (f4-230 '(A + - + + - A)) )

#4.231
(de f4-231 (Lst)
   (let
      (C (filter sym? (fish atom Lst))
         N (filter num? (fish atom Lst)) )
      (uniq
         (if (> (apply + (mapcar char C)) (apply + N))
            C
            N ) ) ) )
(test
   (1 300)
   (f4-231 '(1 (a (b) 300) (1 A))) )
(test
   '(a b A)
   (f4-231 '(1 (a (b) a 300) (1 A))) )

#4.232
(setq *F4-232-TABLE
   (quote
      (down . up)
      (up . down)
      (left . rigth)
      (right . left)
      (big . small)
      (small . big) ) )
(de f4-232 (Lst)
   (mapcar
      '((I) (if (assoc I *F4-232-TABLE) (cdr @) I))
      Lst ) )
(test
   '(down left mike big)
   (f4-232 '(up right mike small)) )

#4.233
(de f4-233 (Lst) # no parentheses
   (let S NIL
      (make
         (for Op (reverse Lst)
            (ifn (memq Op '(+ *))
               (yoke Op)
               (while (and S (> (prec (car S)) (prec Op)))
                  (yoke (pop 'S)) )
               (push 'S Op) ) )
         (while S
            (yoke (pop 'S)) ) ) ) )
(test
   '(+ A B)
   (f4-233 '(A + B)) )
(test
   '(+ A * B C)
   (f4-233 '(A + B * C)) )
(test
   '(+ + A * B C D)
   (f4-233 '(A + B * C + D)) )
(test
   '(+ * A B * C D)
   (f4-233 '(A * B + C * D)) )
(test
   '(+ + + A B C D)
   (f4-233 '(A + B + C + D)) )

#4.234
(de f4-234 (Lst)
   (let
      (S (index (apply min Lst) Lst)
         E (index (apply max Lst) Lst) )
      (and (> S E) (xchg 'S 'E))
      (conc
         (head (dec S) Lst)
         (flip
            (head (inc (- E S)) (nth Lst S)) )
         (tail (- E) Lst) ) ) )
(test
   (5 6 8 4 3 2 1 2 3)
   (f4-234 (5 6 1 2 3 4 8 2 3)) )
(test
   (5 6 1 4 3 2 8 2 3)
   (f4-234 (5 6 8 2 3 4 1 2 3)) )
(test
   (8 8 8 8 8 8 8 8 8)
   (f4-234 (8 8 8 8 8 8 8 8 8)) )

#4.235
(de f4-235-1 (F L)
   (mapcan
      '((I) (and (F I) (cons I)))
      L ) )
(de f4-235-2 (F L)
   (make
      (for I L
         (and (F I) (link I)) ) ) )
(de f4-235-3 (F L)
   (make
      (mapc
         '((I) (and (F I) (link I)))
         L ) ) )
(let L (range 1 10)
   (test
      T
      (=
         (f4-235-1 oddp? L)
         (f4-235-2 oddp? L)
         (f4-235-3 oddp? L)
         (filter oddp? L) ) ) )

#4.236
(de f4-236 (Lst)
   (mapcar
      '((A)
         (let (L (chop A)  N (flip (extract format L)))
            (intern
               (pack
                  (make
                     (for I L
                        (link (if (format I) (pop 'N) I)) ) ) ) ) ) )
      Lst ) )
(test
   '(a2b1c a32b01)
   (f4-236 '(a1b2c a10b23)) )

#4.237
(setq *F4-237-TABLE
   (quote
      (4 . A)
      (3 . B)
      (2 . C)
      (1 . D)
      (0 . F)
      (A . 4)
      (B . 3)
      (C . 2)
      (D . 1)
      (F . 0) ) )
(de f4-237 (Lst)
   (mapcar
      '((I) (if (assoc I *F4-237-TABLE) (cdr @) I))
      Lst ) )
(test
   '(4 3 A B)
   (f4-237 '(A B 4 3)) )

#4.238
(de f4-238 (Lst)
   (mapcar
      '((N) (if (lt0 N) 0 N))
      Lst ) )
(test
   (0 0 1)
   (f4-238 (-1 0 1)) )

#4.239 - ignored

#4.240
(de f4-240 (Lst)
   (make
      (for (I . X) Lst
         (and
            (= (dec I) X)
            (link X) ) ) ) )
(test
   (0 1 3)
   (f4-240 (0 1 1 3)) )

#4.241
(de f4-241 (Lst)
   (mapcar
      '((N) ((if (gt0 N) - +) (abs N)))
      Lst ) )
(test
   (0 1 -1)
   (f4-241 (0 -1 1)) )

#4.242
(de f4-242 (N Lst)
   (seek '((L) (> (car L) N)) Lst) )
(test
   (4 5 6 7)
   (f4-242 3 (range 1 7)) )

#4.243
(de f4-243 (Lst)
   (cond
      ((not (cdr Lst)) Lst)
      (T (cons (car Lst) (list (f4-243 (cdr Lst))))) ) )
(test
   '(A (B (C (D (E)))))
   (f4-243 '(A B C D E)) )

#4.244
(de f4-244 (Lst)
   (filter evenp? Lst) )
(test
   (0 2 4)
   (f4-244 (range 0 5)) )

#4.245
(de f4-245 (Lst)
   (cond
      ((atom Lst) Lst)
      (T
         (cons
            (f4-245 (car Lst))
            (and
               (cadr Lst)
               (cons
                  (f4-245 (cadr Lst))
                  (f4-245 (cdddr Lst)) ) ) ) ) ) )
(test
   '(1 2 (4 5))
   (f4-245 '(1 2 3 (4 5 6))) )

#4.246
(de f4-246 (Lst)
   (mapcar '((L) (cons (car L) (cadr L))) Lst) )
(test
   '((a . 1) (b . 2) (c . 3))
   (f4-246 '((a 1) (b 2) (c 3))) )

#4.247
(de f4-247 (Lst)
   (make
      (for (I . X) Lst
         (if (oddp? I)
            (link X)
            (link I X) ) ) ) )
(test
   '(A 2 B C 4 D E)
   (f4-247 '(A B C D E)) )

#4.248
(de f4-248 (Lst)
   (make
      (for (L Lst L (cddr L))
         (link (apply + (head 2 L))) ) ) )
(test
   (3 7 11 15)
   (f4-248 (range 1 8)) )

#4.249
(de f4-249 (Lst)
   (mapcar length Lst) )
(test
   (2 4 3)
   (f4-249 '((a b) (c d e f) (g h i))) )

#4.250
(de f4-250 (Lst)
   (make
      (for (L Lst L (cddr L))
         (link (head 2 L)) ) ) )
(test
   '((A B) (C D) (E F))
   (f4-250 '(A B C D E F)) )
(test
   '((A B) (C D) (E))
   (f4-250 '(A B C D E)) )

#4.251
(de f4-251 (Lst)
   (make
      (for (I . L) Lst
         (link
            (apply (if (evenp? (dec I)) - +) L) ) ) ) )
(test
   (2 14 -7)
   (f4-251 '((5 3) (8 6) (2 9))) )

#4.252
(de f4-252 (Lst)
   (make
      (for (I . X) Lst
         (link X I) ) ) )
(test
   '(A 1 B 2 C 3 D 4)
   (f4-252 '(A B C D)) )

#4.253
(de f4-253 (Lst) # simpler a bit
   (let R NIL
      (mapc
         '((I)
            (mapc
               '((J) (accu 'R (intern J) 1))
               (chop I) ) )
         Lst )
      R ) )
(test
   9
   (length (f4-253 '(mickey mouse))) )

#4.254
(de f4-254 (Lst)
   (conc (head 2 Lst) (tail 2 Lst)) )
(test
   (1 2 6 7)
   (f4-254 (range 1 7)) )
(test
   (1 2 1 2)
   (f4-254 (range 1 2)) )
(test
   (1 1)
   (f4-254 (range 1 1)) )
(test
   NIL
   (f4-254) )

#4.255
(de f4-255 @
   (let L (mapcar abs (rest))
      (cons (apply min L) (apply max L)) ) )
(test
   (1 . 5)
   (f4-255 1 2 3 4 -5) )

#4.256 - ignored

#4.257
(de f4-257 (Lst)
   (mapcar
      '((L)
         (let X NIL
            (recur (L)
               (if (atom L)
                  L
                  (mapcar recurse (if (onOff X) (flip L) L)) ) ) ) )
         Lst ) )
(test
   '(a b (i (e f (h g)) d c) ((k (n m l)) j))
   (f4-257 '(a b (c d (e f (g h)) i) (j (k (l m n))))) )

#4.258
(de f4-258 (Lst)
   (make
      (for (I . X) Lst
         (link (list X '- I)) ) ) )
(test
   '((A - 1) (B - 2) (C - 3) (D - 4))
   (f4-258 '(A B C D)) )

#4.259
(de f4-259 (Lst)
   (mapcar dec Lst) )
(test
   (0 1 2 3 4)
   (f4-259 (1 2 3 4 5)) )

#4.260
(de f4-260 (Lst)
   (make
      (for (I . X) Lst
         (and (oddp? I) (link X)) ) ) )
(test
   (1 3 5)
   (f4-260 (1 2 3 4 5)) )

#4.261
(de f4-261 (Lst)
   (make
      (for (L (fish atom Lst) L (cddr L))
         (link (head 2 L)) ) ) )
(test
   '((a b) (c d) (e f) (g h) (i j) (k))
   (f4-261 '(a b ((c d e) f g (h i)) j k)) )
(test
   '((a b) (c d) (e f) (g h) (i j) (k l))
   (f4-261 '(a b ((c d e) f g (h i)) j k l)) )

#4.262
(de f4-262 (Lst)
   (by gt0 sort Lst) )
(test
   (-7 -4 0 3 5)
   (f4-262 '(3 -7 0 5 -4)) )

#4.263
(de f4-263 (Lst)
   (mapcar
      '((N) (* N (if (oddp? N) 2 3)))
      Lst ) )
(test
   (6 -14 0 10 -12)
   (f4-263 '(3 -7 0 5 -4)) )

#4.264 - ignored

#4.265
(de f4-265 (Lst) # N99
   (mapcan list Lst Lst) )
(test
   '(A A B B C C)
   (f4-265 '(A B C)) )

#4.266
(de f4-266 (Lst)
   (mapcar
      '((N) (if (gt0 N) (* N N) N))
      Lst ) )
(test
   (-2 4)
   (f4-266 '(-2 2)) )

#4.267
(de f4-267 (Lst)
   (mapcar
      '((L)
         (let (S (sum gt0 L)  N (cnt gt0 L))

            (list
               S
               N
               (and
                  (gt0 N)
                  (f/ (frac S 1) (frac N 1)) ) ) ) )
      Lst ) )
(test
   '((6 3 (2 . 1)) (11 2 (11 . 2)) (0 0 NIL))
   (f4-267 '((1 2 3 -1 -2 -3) (0 0 5 6 -7 -8) (0 0 0 -7 -9))) )

#4.268
(de f4-268 (Lst)
   (make
      (for N Lst
         ((if (gt0 N) yoke link) N) ) ) )
(let L '(1 -2 3 -4 -7 4 5)
   (test
      (flip (f4-262 L))
      (f4-268 L) ) )

#4.269
(de f4-269 (Lst)
   (by =0 sort Lst) )
(test
   (1 3 4 5 0 0 0)
   (f4-269 '(1 0 3 0 0 4 5)) )

#4.270
(de f4-270 (Lst)
   (mapcar
      '((L)
         (recur (L)
            (if2 (atom L) (sym? L)
               1
               L
               NIL
               (mapcar recurse L) ) ) )
      Lst ) )
(test
   '(1 (2 1) 1 14 1 1)
   (f4-270 '(1 (2 a) b 14 1 b)) )

#4.271
(de f4-271 (Lst)
   (mapcar
      '((N)
         (format
            (mapcar
               '((N) (% (inc (format N)) 10))
               (chop N) ) ) )
      Lst ) )
(test
   (234 678 907 989 213)
   (f4-271 '(123 567 896 878 102)) )

#4.272
(de f4-272 (N) # Rosetta
   (let Sieve (range 1 N)
      (set Sieve)
      (for I (cdr Sieve)
         (when I
            (for (S (nth Sieve (* I I)) S (nth (cdr S) I))
               (set S) ) ) )
      (filter bool Sieve) ) )
(test
   (2 3 5 7 11 13 17 19 23 29 31 37 41 43
      47 53 59 61 67 71 73 79 83 89 97)
   (f4-272 100) )

#4.273
(de f4-273 (Lst)
   (let R NIL
      (for I Lst
         (accu 'R I 1) )
      R ) )
(test
   '((C . 1) (B . 2) (A . 3))
   (f4-273 '(A B A A C B)) )

#4.274
(de f4-274 (Str) # Rosetta
   (let *L (str Str "")
      (eval (aggregate)) ) )
(de aggregate ()
   (let X (product)
      (while (member (car *L) '(+ -))
         (setq X (list (intern (pop '*L)) X (product))) )
      X ) )
(de product ()
   (let X (term)
      (while (member (car *L) '(* /))
         (setq X (list (intern (pop '*L)) X (term))) )
      X ) )
(de term ()
   (let X (pop '*L)
      (cond
         ((num? X) X)
         ((= '+ X) (term))
         ((= '- X) (list '- (term)))
         ((= "(" X) (prog1 (aggregate) (pop '*L)))) ) )
(test
   30
   (f4-274 "((6 + (7 - 8)) * 6)") )
(test
   6
   (f4-274 "((-8 + 10) * (1 + 2))") )

#4.275
(de f4-275 (Lst N)
   (default N 0)
   (mapcan
      '((X)
         (if (atom X)
            (list (cons X N))
            (f4-275 X (inc N)) ) )
      Lst ) )
(test
   '((a . 0) (s . 0) (d . 1) (f . 1) (g . 2) (h . 2) (j . 3) (q . 2))
   (f4-275 '(a s (d f (g h (j) q)))) )

#4.276
(de f4-276 (Lst)
   (let L (fish atom Lst)
      (list
         (apply min L)
         (apply max L) ) ) )
(test
   (1 6)
   (f4-276 '((1 2) (3 4) (5 6))) )

#4.277
(de f4-277 (Lst)
   (maxi
      car
      (make
         (for (I . X) Lst
            (for (J . Y) X
               (link (list Y I J)) ) ) ) ) )
(test
   (15 2 1)
   (f4-277 '((1 2 3) (15 2 6) (7 8 9))) )

#4.278
(de f4-278 (Lst)
   (list
      (mapcar '((L) (apply min L)) Lst)
      (mapcar '((L) (apply max L)) Lst) ) )
(test
   '((1 4 7) (3 6 9))
   (f4-278 '((1 2 3) (4 5 6) (7 8 9))) )

#4.279
(de f4-279-1 (Lst)
   (list
      (cnt atom Lst)
      (cnt pair Lst) ) )
(de f4-279-2 (Lst A L)
   (default A 0 L 0)
   (cond
      ((not Lst) (list A L))
      ((atom (car Lst))
         (f4-279-2 (cdr Lst) (inc A) L) )
      (T (f4-279-2 (cdr Lst) A (inc L))) ) )
(let L '(a (b) c (d) e)
   (test
      (f4-279-1 L)
      (f4-279-2 L) ) )

#4.280
(de f4-280 (Lst)
   (make
      (for N (range (car Lst) (last Lst))
         (or (member N Lst) (link N)) ) ) )
(test
   (3 5 7 9)
   (f4-280 (2 4 6 8 10)) )
(test
   (3 4 5 6 7 8 9)
   (f4-280 (2 10)) )

#4.281
(de f4-281 @
   (apply list (rest)) )
(test
   (1 2 3)
   (f4-281 1 2 3) )

#4.282
(de f4-282 (Lst)
   (fully
      '((L) (apply <= L))
      (list Lst (apply mapcar Lst list)) ) )
(test
   T
   (f4-282 '((1 2 3 3) (1 2 3 4) (1 2 3 4))) )
(test
   NIL
   (f4-282 '((1 2 3 3) (1 2 3 4) (1 2 3 3))) )

#4.283
(de f4-283 (Lst)
   (let R NIL
      (for I Lst
         (and (sym? I) (accu 'R I 1)) ) # out of order
      (car (maxi cdr R)) ) )
(test
   "a"
   (f4-283 '(1 "a" "a" "a" "b")) )
(test
   "b"
   (f4-283 '(1 "a" "a" "b" "b")) )

#4.284
(de f4-284-1 (Lst)
   (make
      (recur (Lst)
         (for X Lst
            (and
               (pair X)
               (link X)
               (recurse X) ) ) ) ) )
(de f4-284-2 (Lst)
   (mapcan
      '((X)
         (and
            (pair X)
            (cons X (f4-284-2 X)) ) )
      Lst ) )
(test
   '((a 3 4) (b 2 (c 3 4) 5) (c 3 4) (d 7) ((e 7)) (e 7))
   (f4-284-1 '((a 3 4) (b 2 (c 3 4) 5) (d 7) ((e 7)))) )
(test
   '((a 3 4) (b 2 (c 3 4) 5) (c 3 4) (d 7) ((e 7)) (e 7))
   (f4-284-2 '((a 3 4) (b 2 (c 3 4) 5) (d 7) ((e 7)))) )
(test
   '((a 3 4))
   (f4-284-1 '((a 3 4))) )
(test
   NIL
   (f4-284-1 '(a 3 4)) )

#4.285
(de f4-285 (Lst)
   (cdr
      (last
         (sort
            (group
               (mapcar
                  '((L) (cons (sum prog L) L))
                  Lst ) ) ) ) ) )
(test
   '((a 3 4) (b 2 (c 3 4) 5) (d 7))
   (f4-285 '((a 3 4) (b 2 (c 3 4) 5) (d 7) ((e 7)))) )
(test
   '((d 8))
   (f4-285 '((a 3 4) (b 2 (c 3 4) 5) (d 8) ((e 8)))) )

#4.286
(de f4-286 (Lst)
   (cdr
      (last
      (sort
         (group
            (mapcar
               '((L) (cons (sum prog L) L))
               (f4-284-2 Lst) ) ) ) ) ) )
(test
   '((a 3 4) (b 2 (c 3 4) 5) (c 3 4) (d 7) (e 7))
   (f4-286 '((a 3 4) (b 2 (c 3 4) 5) (d 7) ((e 7)))) )
(test
   '((e 8))
   (f4-286 '((a 3 4) (b 2 (c 3 4) 5) (d 7) ((e 8)))) )

#4.287
(de f4-287 (Lst)
   (cdr
      (last
         (sort
            (group
               (mapcar
                  '((L) (cons (cadr L) (car L)))
                  Lst ) ) ) ) ) )
(test
   '(b c)
   (f4-287 '((a 1) (b 2) (c 2))) )

#4.288
(de f4-288 (Lst)
   (cdar
      (sort
         (group
            (mapcar
               '((L) (cons (cadr L) (car L)))
               Lst ) ) ) ) )
(test
   '(a)
   (f4-288 '((a 1) (b 2) (c 2))) )

#4.289
(de f4-289 (Lst)
   (mapcar list Lst) )
(test
   '((1) (2) (3) (4) (5))
   (f4-289 (1 2 3 4 5)) )

#4.290
(de f4-290 (Lst)
   (let R NIL
      (for I (fish atom Lst)
         (accu 'R I 1) )
      (by cdr sort R) ) )
(test
   '((a . 1) (b . 2) (c . 3))
   (f4-290 '(a b b c c c)) )

#4.291
(def 'f4-291 f4-290)
(test
   '((a . 1) (b . 2) (c . 3))
   (f4-291 '(a (b (b) c) (c) c)) )

#4.292
(de f4-292 (Lst)
   (mapcan
      '((L)
         (recur (L)
            (if2 (atom L) (gt0 L)
               (cons L)
               NIL
               NIL
               (cons (mapcan recurse L)) ) ) )
      Lst ) )
(test
   '((1 6 (2) 7))
   (f4-292 '((1 6 (-5 2) -3 7))) )

#4.293
(de accuR (Var Key)
   (if (rassoc Key (val Var))
      (inc @)
      (push Var (cons 1 Key)) ) )
(de f4-293 (Lst)
   (let R NIL
      (for I Lst
         (accuR 'R I) )
      (mapcan
         '((L)
            ((if (cddr L) cons prog) (cdr L)) )
         (sort (group R)) ) ) )
(test
   '((d a) s f)
   (f4-293 '(a s s a s d f d f f f)) )

#4.294
(de f4-294 (Lst)
   (by sym? group Lst) )
(test
   '((a b c) (1 2 3))
   (f4-294 '(a 1 b 2 c 3)) )

#4.295
(de f4-295 (Lst)
   (let (N 0  R NIL)
      (recur (Lst N)
         (if (atom Lst)
            (accu 'R N 1)
            (recurse (car Lst) (inc N))
            (and (cdr Lst) (recurse @ N)) ) )
      R ) )
(test
   '((3 . 3) (2 . 3) (1 . 4))
   (f4-295 '(1 (a b) 1 (c) 1 ((3)) 1 ((3 3)))) )

#4.296
(de f4-296 (Lst)
   (let L (need (apply max (fish num? Lst)))
      (for X (filter pair Lst)
         (for N (cdr X)
            (set (nth L N) (car X)) ) )
      (for X (filter atom Lst)
         (set (seek '((L) (not (car L))) L) X) )
      L ) )
(test
   '(a d a c d a)
   (f4-296 '((a 1 3 6) c (d 2 5))) )
(test
   '(a d a NIL d a)
   (f4-296 '((a 1 3 6) (d 2 5))) )
(test
   '(a d c Z d a)
   (f4-296 '((a 1 6) c Z (d 2 5))) )

#4.297
(de f4-297 (Lst)
   (cons
      (apply + (fish num? Lst))
      (cnt num? (fish atom Lst)) ) )
(test
   (10 . 4)
   (f4-297 '((1 a)(2 (3) b (4)))) )

#4.298
(de f4-298 (Lst)
   (mapcan
      '((L)
         (recur (L)
            (if2 (atom L) (num? L)
               NIL
               (cons L)
               NIL
               (cons (mapcan recurse L)) ) ) )
      Lst ) )
(test
   '(a (b) c)
   (f4-298 '(a 1 (b 2) c)) )

#4.299
(def 'f4-299 f4-243)
(test
   '(a (b (c (d (e (f))))))
   (f4-299 '(a b c d e f)) )

#4.300
(def 'f4-300 f4-161-2)
(test
   '((-2 -1) (0) (1 2))
   (f4-300 '(-2 -1 0 1 2)) )

#4.301
(de f4-301 (Lst)
   (apply conc (by evenp? group Lst)) )
(test
   (1 3 5 7 2 4 6)
   (f4-301 (range 1 7)) )

#4.302
(de f4-302 (Lst)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L)
               L
               (mapcar recurse (sort L)) ) ) )
      (sort Lst) ) )
(test
   '(2 5 9 12 (1 2) (2 3 6) (6 (1 3)))
   (f4-302 '(9 2 (2 1) 5 (3 6 2) 12 (6 (3 1)))) )

#4.303
(de f4-303 (Lst)
   (mapcar
      '((L) (apply + L))
      Lst ) )
(test
   (3 12)
   (f4-303 '((1 2) (3 4 5))) )

#4.304
(de f4-304 (Lst)
   (let A (need 3 0)
      (mapc
         '((N)
            (if (oddp? N)
               (inc (cddr A) N)
               (inc A N)
               (inc (cdr A)) ) )
         Lst )
      (list
         (and (gt0 (cadr A)) (/ (car A) (cadr A)))
         (caddr A) ) ) )
(test
   (4 16)
   (f4-304 (range 1 7)) )
(test
   '(NIL 16)
   (f4-304 (1 3 5 7)) )

#4.305
(de f4-305 (Lst)
   (maplist
      '((L) (apply + L))
      Lst ) )
(test
   (55 54 52 49 45 40 34 27 19 10)
   (f4-305 (range 1 10)) )

#4.306
(de f4-306 (Lst)
   (recur ()
      (let X (pop 'Lst)
         (if (memq X '(+ - * /))
            (conc (recurse) (recurse) (cons X))
            (cons X) ) ) ) )
(test
   '(A B +)
   (f4-306 '(+ A B)) )
(test
   '(A B C * +)
   (f4-306 '(+ A * B C)) )
(test
   '(A B C * + D +)
   (f4-306 '(+ + A * B C D)) )
(test
   '(A B + C D + *)
   (f4-306 '(* + A B + C D)) )
(test
   '(A B * C D * +)
   (f4-306 '(+ * A B * C D)) )
(test
   '(A B + C + D +)
   (f4-306 '(+ + + A B C D)) )
(test
   '(A B * C D / +)
   (f4-306 '(+ * A B / C D)) )
(test
   '(A B C + * D /)
   (f4-306 '(/ * A + B C D)) )
(test
   '(A B C D / + *)
   (f4-306 '(* A + B / C D)) )

#4.307
(de f4-307 (Lst)
   (mapcon
      '((L)
         (or
            (= (car L) (cadr L))
            (cons (car L)) ) )
      Lst ) )
(test
   (1 2 3 4 5 4 3 1)
   (f4-307 '(1 2 3 3 4 5 4 4 3 1 1 1)) )

#4.308
(de f4-308 (Lst)
   (sort (fish atom Lst)) )
(test
   (0 1 2 3 4 5 6 7)
   (f4-308 '(7 ((3 5 (((4) 6 1) 0)) 2))) )

#4.309
(de f4-309 (Lst) # like #4.293 without (accuR)
   (let R NIL
      (for I Lst
         (accu 'R I 1) )
      (sort
         (mapcar
            car
            (last (by cdar sort (by cdr group R))) ) ) ) )
(test
   '(a b)
   (f4-309 '(a b c a b)) )
(test
   '((a) (b))
   (f4-309 '((a) (b) c (a) (b))) )

#4.310
(de f4-310 (Lst Index)
   (mapcar
      '((F)
         (mapcar
            '((L I)
               (make
                  (for (J . X) L
                     (and (F (member J I)) (link X)) ) ) )
            Lst
            Index ) )
      '(prog not) ) )
(test
   '(((1 3) (6 8) (9 10)) ((2 4) (5 7) (11 12)))
   (f4-310
      '((1 2 3 4) (5 6 7 8) (9 10 11 12))
      '((1 3) (2 4) (1 2)) ) )

#4.311
(de f4-311 (Lst)
   (mapcar
      '((L)
         (apply
            conc
            (list
               (cons (caar L))
               (and (cdr L) (cons (car (last L))))
               (cons (cadar L)) ) ) )
   (by cdr group Lst) ) )
(test
   '((1 2 r) (3 4 i) (5 x) (6 8 e) (9 z))
   (f4-311 '((1 r) (2 r) (3 i) (4 i) (5 x) (6 e) (7 e) (8 e) (9 z))) )

#4.312 - ignored

#4.313
(de f4-313 (M1 M2)
   (mapcar
      '((L1 L2) (mapcar + L1 L2))
      M1
      M2 ) )
(test
   '((2 4 6) (8 10 12) (14 16 18))
   (f4-313 '((1 2 3) (4 5 6) (7 8 9)) '((1 2 3) (4 5 6) (7 8 9))) )

#4.314 - ignored

#4.315
(de f4-315 (Lst)
   (let R NIL
      (make
         (for ((I . L) Lst L (cdr L))
            (and
               (> (car L) (car R))
               (> (car L) (cadr L))
               (link I) )
            (push 'R (car L)) ) ) ) )
(test
   (2 6)
   (f4-315 '(0 1 0 1 2 3 1)) )

#4.316
(de f4-316 (Lst) # first only
   (maxi
      '((L) (apply * L))
      (mapcon '((L) (maplist reverse (reverse L)))
         Lst) ) )
(test
   (1 3 4 8 -4 -6)
   (f4-316 '(1 2 3 0 1 3 4 8 -4 -6 0 3 4)) )
(test
   (2 3)
   (f4-316 '(2 3 -2 4)) )

#4.317
(def 'f4-317 f4-243)
(test
   '(a (b (c (d (e)))))
   (f4-317 '(a b c d e)) )

#4.318
(de f4-318 (Lst)
   (let R NIL
      (for I Lst
         (accu 'R I 1) )
      (extract '((L) (and (=1 (cdr L)) (car L))) R) ) )
(test
   '(5 (3 2 3) 4)
   (f4-318 '(1 (2 2 3) 4 (3 2 3) (8 9) 5 1 (8 9) (2 2 3))) )

#4.319
(de f4-319 (Lst)
   (mapcar '((I) (bool (pair I))) Lst) )
(test
   '(T NIL)
   (f4-319 '((a) a)) )

#4.320
(de f4-320 (Lst)
   (let M (apply max (fish atom Lst))
      (make
         (for (I . L) Lst
            (for (J . P) L
               (T (= M P) (link P I J)) ) ) ) ) )
(test
   (8 2 2)
   (f4-320 '((1 2 3 4) (-5 8 3 5))) )
(test
   (5 2 3)
   (f4-320 '((1 2 3) (-1 -2 5) (3 4 2))) )

#4.321
(de f4-321 (Lst)
   (cons
      (caaar (cdaadr (cddadr Lst)))
      (cons (caadr Lst) (cons (cons (car Lst)))) ) )
(test
   '(f b (a))
   (f4-321 '(a (b (c) d ((e ((f))))))) )

#4.322
(de f4-322 (Lst)
   (conc
      (cons (caddr Lst))
      (head 2 Lst)
      (cons (last Lst)) ) )
(test
   '(a3 a1 a2 a4)
   (f4-322 '(a1 a2 a3 a4)) )

#4.323
(de f4-323 (Lst)
   (mapcar
      '((L)
         (recur (L)
            (if (atom L) (inc L) (mapcar recurse L)) ) )
      Lst ) )
(test
   '(((2) (3)) ((4) (5)))
   (f4-323 '(((1) (2)) ((3) (4)))) )

#4.324
(de f4-324 (X)
   (if (atom X)
      X
      (mapcon
         '((L)
            (cons
               (f4-324 (car L))
               (and (cdr L) (cons (car X))) ) )
         (cdr X) ) ) )
(test
   '((3 + 4 + 6) * (1 - 2 - 3) * 8 * 9)
   (f4-324 '(* (+ 3 4 6) (- 1 2 3) 8 9)) )

#4.325
(de f4-325 (Lst)
   (let M (apply min Lst)
      (mapcar
         '((I) (if (lt0 I) @ M))
         Lst ) ) )
(test
   (-5 -5 -5 -1 -5 -5)
   (f4-325 '(1 2 3 -1 4 -5)) )

#4.326
(de f4-326 (Lst)
   (let M (apply min (fish atom Lst))
      (mapcar
         '((L)
            (recur (L)
               (if2 (atom L) (lt0 L)
                  L
                  M
                  NIL
                  (mapcar recurse L) ) ) )
         Lst ) ) )
(test
   '(-5 (-5 (-5)) ((-1) -5) ((-5)))
   (f4-326 '(1 (2 (3)) ((-1) 4) ((-5)))) )

#4.327 - ignored

