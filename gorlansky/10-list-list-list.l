#10.1
(de f10-1 (Lst P)
   (by
      '((L)
         (mapcar '((I) (get L I)) P) )
      sort
      Lst ) )
(test
   '((0 0 0) (1 0 0) (0 1 0) (1 1 0)
      (0 0 1) (1 0 1) (0 1 1) (1 1 1) )
   (f10-1
      '((0 0 0) (0 0 1) (0 1 0) (0 1 1)
         (1 0 0) (1 0 1) (1 1 0) (1 1 1) ) 
      (3 2 1) ) )

#10.2
(de f10-2 (L1 L2)
   (uniq (append L1 L2)) )
(test
   (range 1 4)
   (f10-2 (1 2 3) (1 2 4)) )

#10.3
(de f10-3 (L1 L2)
   (mapcan list L1 L2) )
(test
   '(1 a 2 b 3 c)
   (f10-3 (1 2 3) '(a b c)) )

#10.4
(de groupL (Lst)
   (make
      (while Lst
         (link
            (if (pair (car Lst))
               (pop 'Lst)
               (make
                  (link (pop 'Lst))
                  (while (and Lst (atom (car Lst)))
                     (link (pop 'Lst)) ) ) ) ) ) ) )
(de f10-4 (L1 L2)
   (let
      (L1 (groupL L1)
         L2 (groupL L2)
         Len (dec (length L1)) )
      (make
         (for
            (N 
               1
               (<= N (dec (length L1))) 
               (inc 'N 2) )
            (link 
               (conc (get L1 N) (get L2 (inc N)))
               (conc (get L2 N) (get L1 (inc N))) ) ) ) ) )
(test
   '((a b 2 3) (1 c d e) (f 8) 
      (4 5 6 7 g h) (i j k 11 12) (9 10 l m) )
   (f10-4
      '((a b) c d e (f) g h (i j k) l m)
      '((1) 2 3 (4 5 6 7) 8 (9 10) 11 12) ) )

#10.5
(de f10-5 (L1 L2) # 4clojure
   (mapcan
      '((X) (mapcar '((Y) (list X Y)) L2))
      L1 ) )
(test
   '((a 1) (a 2) (a 3) (b 1) (b 2) (b 3) (c 1) (c 2) (c 3))
   (f10-5 '(a b c) '(1 2 3)) )

#10.6 - ignored

#10.7
(de f10-7 (L1 L2)
   (if (gt0 (car L1))
      L2
      (cons (car L2) (cdr L1)) ) )
(test
   '(a b c)
   (f10-7 (1 2 3) '(a b c)) )
(test
   '(a 2 3)
   (f10-7 (0 2 3) '(a b c)) )

#10.8
(de f10-8 (L1 L2)
   (mapcar = L1 L2) )
(test
   '(T NIL T T NIL)
   (f10-8 '(5 3 9 7 4) '(5 2 9 7 8)) )

#10.9
(de f10-9 (L1 L2)
   (mapcan list L1 L2) )
(test
   '(a 1 b 2 c 3)
   (f10-9 '(a b c) (1 2 3)) )

#10.10
(de f10-10 (L1 L2)
   (mapcar * L1 L2) )
(test
   (2 4 6)
   (f10-10 (1 2 3) (2 2 2)) )

#10.11
(de f10-11 (L1 L2)
   (diff L1 L2) )
(test
   (1 2 3)
   (f10-11 (1 2 3 4 5) (4 5 6 7)) )

#10.12
(de f10-12 (L1 L2)
   (let L2 (mapcar chop L2)
      (mapcar # multi chop
         '((W)
            (and
               (mini
                  '((L) (offset L (chop W)))
                  L2 )
               (pack (head (dec @@) (chop W))) ) )
         L1 ) ) )
(test
   '("n" "n")
   (f10-12 '("nokia" "nokia") '("kia" "okia")) )

#10.13
(def 'f10-13 f10-2)
(test
   (1 2 3 4)
   (f10-13 (1 2 3) (2 3 4)) )

#10.14
(de f10-14 (L1 L2)
   (mapcar
      '((L1 L2) (L1 L2))
      L1
      L2 ) )
(test
   (0 2 2)
   (f10-14 '(dec inc inc) (1 1 1)) )

#10.15
(de f10-15 (L1 L2)
   (filter evenp? (sect L1 L2)) )
(test
   (4 6)
   (f10-15 (1 2 3 4 5 6) (4 5 6 7 8)) )

#10.16
(de f10-16 (L1 L2)
   (sort (conc (diff L1 L2) (diff L2 L1))) )
(test
   (2 5)
   (f10-16 (5 4 3) (4 3 2)) )

#10.17
(de f10-17 (L1 L2)
   (conc (diff L1 L2) (diff L2 L1)) )
(test
   (1 2 6 7)
   (f10-16 (1 2 3 4 5) (3 4 5 6 7)) )

#10.18
(de f10-18-1 (L1 L2)
   (mapcar sort (f10-5 L1 L2)) )
(de f10-18-2 (L1 L2)
   (mapcan
      '((X) (mapcar '((Y) (sort (list X Y))) L2))
      L1 ) )
(test
   (f10-18-1 (2 2 2) (1 1 1))
   (f10-18-2 (2 2 2) (1 1 1)) )

#10.19
(de f10-19 (L1 L2)
   (make
      (for I L1
         (or (member I L2) (link I)) )
      (for I L2
         (or (member I L1) (link I)) ) ) )
(test
   '(a c) 
   (f10-19 '(a b) '(b c)) )
(test
   '(a)
   (f10-19 '(a b) '(b)) )
(test
   '(a b)
   (f10-19 '(a b)) )
(test
   '(a b c)
   (f10-19 '(a b) '(c)) )

#10.20
(de f10-20 (L1 L2)
   (sect L1 L2) )
(test
   '(a s d)
   (f10-20 '(a s d f g h ) '(q a w s e d r)) )

#10.21 - ignored

#10.22
(de f10-22 (L1 L2)
   (mapcar + L1 L2) )
(test
   (2 4)
   (f10-22 (1 2) (1 2)) )

#10.23
(de f10-23 (L1 L2)
   (filter
      '((I)
         (if (atom I) I (and (diff I L2) I)) )
      L1 ) )
(test
   '(8 (2 7) 5)
   (f10-23 '((2 3 2 3) 8 (2 3) (2 7) (2) (2 2 3) 5) '(3 2 3 2)) )

#10.24
(de f10-24 (B S E)
   (let (Big 0  Small 0)
      (make
         # start
         (link (list Big Small))
         (loop
            # pour big
            (inc 'Big (- B Big))
            (link (list Big Small)) 
            (loop
               # share
               (if (<= Big S)
                  (xchg 'Big 'Small)
                  (inc
                     'Small
                     (setq @ (% (- S Small) B)) )
                  (dec 'Big @) )
               (link (list Big Small))
               (T (or (=0 Big) (= Big E)))
               # pour off small
               (zero Small)
               (link (list Big Small)) )
            (T (= Big E)
               (zero Small)
               (link (list Big Small)) ) ) ) ) )
(test
   '((0 0) (9 0) (5 4) (5 0) (1 4)
      (1 0) (0 1) (9 1) (6 4) (6 0) )
   (f10-24 9 4 6) )
(test
   '((0 0) (8 0) (3 5) (3 0))
   (f10-24 8 5 3) )
(test
   '((0 0) (8 0) (5 3) (5 0) (2 3)
      (2 0) (0 2) (8 2) (7 3) (7 0) )
   (f10-24 8 3 7) )
(test
   '((0 0) (5 0) (3 2) (3 0) (1 2) (1 0))
   (f10-24 5 2 1) )
(test
   '((0 0) (8 0) (3 5) (3 0) (0 3) (8 3) (6 5) (6 0))
   (f10-24 8 5 6) )

#10.25
(de f10-25 (L1 L2)
   (filter
      '((I) (nor (= I L2)))
      L1 ) )
(test
   '(1 4 (3 2 3) 5)
   (f10-25 '(1 (2 2 3) 4 (3 2 3) 5) (2 2 3)) )

#10.26
(de f10-26 (L1 L2)
   (mapcar + L1 L2) )
(test
   (2 4 6)
   (f10-26 (1 2 3) (1 2 3)) )

#10.27
(de f10-27 (L1 L2)
   (sect L1 L2) )
(test
   '(b c)
   (f10-27 '(a b c) '(b c d)) )

#10.28
(de f10-28 (L1 L2)
   (mapcar * L1 L2) )
(test
   (2 4 6)
   (f10-28 (1 2 3) (need 3 2)) )

#10.29
(de f10-29-1 (L1 L2)
   (sort (append L1 L2)) )
(de f10-29-2 (L1 L2)
   (let P 0
      (for I L1
         (while (and (< (get L2 P) I) (inc 'P)))
         (setq L2 (insert P L2 I)) ) ) )
(test
   (f10-29-1 (1 2 4 5 7) (0 1 2 3 4 5 6 7))
   (f10-29-2 (1 2 4 5 7) (0 1 2 3 4 5 6 7)) )

#10.30
(de f10-30 (L1 L2)
   (uniq (append L1 L2)) )
(test
   '(a b c d)
   (f10-30 '(a b c) '(c b d)) )

#10.31
(de f10-31 (L1 L2)
   (filter atom (f10-30 L1 L2)) )
(test
   (1 2 5 6 7 11 12)
   (f10-31 '(1 2 (3 4) 5 6) '(7 (8 9 10) 11 12)) )

#10.32
(de f10-32 (L1 L2)
   (mapcar max L1 L2) )
(test
   (2 2 33 11 5)
   (f10-32 (1 2 3 4 5) (2 1 33 11 0)) )

#10.33
(de f10-33 (L1 L2)
   (diff L1 L2) )
(test
   (1 2)
   (f10-33 (1 2 3 4 5) (3 4 5 6 7 8)) )

#10.34
(de f10-34 (L1 L2)
   (sort (append L1 L2)) )
(test
   (1 2 3 4 4 5 5 6 12)
   (f10-34 (1 4 5 6 12) (2 3 4 5)) )

#10.35
(de f10-35 (L1 L2)
   (mapcan
      '((L1 L2) (if L2 (list L1 L2) (list L1)))
      L1
      L2 ) )
(test
   '(1 a 2 b 3 c 4 d)
   (f10-35 (1 2 3 4) '(a b c d)) )
(test
   '(1 a 2 b 3 c 4 5)
   (f10-35 (1 2 3 4 5) '(a b c)) )

#10.36
(de f10-36 (L1 L2)
   (mapcan
      '((A)
         (and
            (member A L2)
            (need
               (max
                  (cnt '((X) (= A X)) L1)
                  (cnt '((X) (= A X)) L2) )
               A ) ) )
      (uniq L1) ) )
(test
   (3 3 3 4 5)
   (f10-36 (1 2 3 3 4 5) (3 3 3 4 5 6 7)) )

#10.37
(de f10-37 (L1 L2)
   (make
      (for I (length L1)
         (link
            (get
               (if (bit? 1 I) L1 L2)
               I ) ) ) ) )
(test
   (1 3 3 1)
   (f10-37 (1 2 3 4) (4 3 2 1)) )
(test
   (1 6 3 8)
   (f10-37 (1 2 3 4) (5 6 7 8)) )

#10.38
(de f10-38 @
   (mini
      '((L) (length (fish atom L)))
      (rest) ) )
(test
   '((2 (3) (4 ((5)))))
   (f10-38 '((2 (3) (4 ((5))))) '(1 (2 (3) 4) 5)) )
 
#10.39
(de f10-39 @
   (mini
      '((L) (apply + (fish atom L)))
      (rest) ) )
(test
   '((2 (3) (4 ((5)))))
   (f10-39 '((2 (3) (4 ((5))))) '(1 (2 (3) 4) 5)) )

#10.40
(de f10-40 (L1 L2)
   (mapcar
      '((N) (get L1 N))
      L2 ) )
(test
   '(b d)
   (f10-40 '(a b c d e) (2 4)) )

#10.41
(de f10-41 (L1 L2)
   (uniq
      (append
         (fish atom L1)
         (fish atom L2) ) ) )
(test
   (1 3 4 5)
   (f10-41 '((1) 3 4 (3)) '((3 4) 5 3)) )

#10.42
(de f10-42 (L1 L2)
   (and
      (> (length L2) (length L1))
      (xchg 'L1 'L2) )
   (mapcar
      '((L1 L2)
         (+ L1 (or L2 0)) )
      L1
      L2 ) )
(test
   (2 2)
   (f10-42 (1 1) (1 1)) )
(test
   (2 2 1)
   (f10-42 (1 1 1) (1 1)) )
(test
   (2 2 1)
   (f10-42 (1 1) (1 1 1)) )

#10.43
(de f10-43 (L1 L2)
   (mapcar
      '((N) (get L2 N))
      L1 ) )
(test
   '(3 4 2 NIL)
   (f10-43 (3 2 1 0) (2 4 3 1)) )

#10.44
(de makesubs (L)
   (mapcon
      '((L)
         (let Len (length L)
            (make
               (for (I 2 (<= I Len) (inc I))
                  (link (head I L)) ) ) ) )
      L ) )
(de f10-44 (L1 L2)
   (let
      (L1 (makesubs L1)
         L2 (makesubs L2)
         L1 (filter '((L) (member L L2)) L1) )
      (maxi length L1)
      (filter '((L) (= @@ (length L))) L1) ) )
(test
   '((c d e))
   (f10-44 '(1 b c d e 2 3 4) '(0 c d e f g h)) )
(test
   '((c d e) (e f g))
   (f10-44 '(1 b c d e 2 3 4 e f g) '(0 c d e f g h)) )

#10.45
(de f10-45 (L1 . @)
   (let (L1 (makesubs L1)  Rest (mapcar makesubs (rest)))
      (setq L1
         (filter
            '((L)
               (fully '((Y) (member L Y)) Rest))
            L1 ) )
      (maxi length L1)
      (filter '((L) (= @@ (length L))) L1) ) )
(test
   '((c d e))
   (f10-45 '(b c d e f 2 e) '(0 c d e f g) '(b c d e)) )

#10.46
(de f10-46 (A L)
   (recur (L)
      (and 
         (pair L)
         (or 
            (= A (car L))
            (recurse (car L))
            (and (cdr L) (recurse @)) ) ) ) )
(test
   T
   (f10-46 '(1 2 (7)) '(1 2 2 (1 2 (7)) 1)) )
(test
   T
   (f10-46 (7) '(1 2 2 (1 2 (7)) 1)) )

#10.47
(def 'f10-47 f10-5)
(test
   '((a 1) (a 2) (a 3) (b 1) (b 2) (b 3) (c 1) (c 2) (c 3))
   (sort (f10-47 '(b c a) (3 2 1))) )

#10.48
(de f10-48 (L1 L2)
   (sort (append L1 L2)) )
(test
   (0 1 1 2 3 4 5)
   (f10-48 (1 1 2 5) (0 3 4)) )

#10.49 - ignored

#10.50
(de f10-50 (L1 L2)
   (let (L1 (fish atom L1)  L2 (fish atom L2))
      (mapcar
         '((N)
            (mapcar '((X) (* X N)) L2) )
         L1 ) ) )
(test
   '((11 22 33 44) (22 44 66 88) (33 66 99 132) (44 88 132 176))
   (f10-50 '((1 2) (3 4)) '((11 22) (33 44))) )

#10.51
(de f10-51 (L1 L2)
   (conc
      (by
         '((A) (index A L2))
         sort
         (filter sym? L1) )
      (filter num? L1) ) )
(test
   '(a a b b c c 1 2)
   (f10-51 '(1 2 c a b b a c) '(a b c)) )
(test
   '(c c a a a b b 1 7 8)  
   (f10-51 '(a 1 c a b 7 8 b a c) '(c a b)) )

#10.52
(de f10-52 (L1 L2)
   (mapcan
      '((L1 L2) (and L2 (cons (list L1 L2))))
      L1
      L2 ) )
(test
   '((1 a) (2 b) (3 c) (4 d))
   (f10-52 (1 2 3 4 5) '(a b c d)) )
(test
   '((1 a) (2 b) (3 c) (4 d) (5 e))
   (f10-52 (1 2 3 4 5) '(a b c d e)) )

