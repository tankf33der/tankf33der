#7.1
(de add1 (Lst)
   (mapcar inc Lst) )
(de add1-destr (Lst) # Destructive
   (for (L Lst L)
      (set L (inc (pop 'L))) )
   Lst )
(test
   (2 4 6 8 10)
   (add1 (1 3 5 7 9)) )

#7.2
(setq *DAILY-PLANET
   (quote
      (Olsen Jimmy 123-76-4535 cub-reporter)
      (Kent  Clark 089-52-6787 reporter)
      (Lane  Lois  951-26-1438 reporter)
      (White Perry 355-16-7439) ) )
(de 7-2 (L)
   (mapcar caddr L) )
(test
   '(123-76-4535 089-52-6787 951-26-1438 355-16-7439)
   (7-2 *DAILY-PLANET) )

#7.3
(de 7-3 (L)
   (mapcar '((I) (bool (=0 I))) L) )
(test
   '(NIL T NIL NIL T NIL NIL)
   (7-3 (2 0 3 4 0 -5 -6)) )

#7.4
(de 7-4 (L)
   (mapcar
      '((I) (< 5 I))
      L ) )
(test
   '(NIL NIL NIL T T)
   (7-4 '(3 4 5 6 7)) )

#7.5
(test
   93
   ('((X) (- X 7)) 100) )

#7.6
(test
   T
   ('((X) (=T X)) T) )
(test
   NIL
   ('((X) (=T X)) 123) )

#7.7
(de 7-7 (L)
   (mapcar
      '((I) (if (== 'UP I) 'DOWN 'UP))
      L ) )
(test
   '(DOWN UP DOWN DOWN)
   (7-7 '(UP DOWN UP UP)) )

#7.8
(de 7-8 (X K)
   (let (Kmin (- K 10)  Kmax (+ K 10))
      (find
         '((I) (<= Kmin I Kmax))
         X ) ) )
(test
   200
   (7-8 (100 200 343) 210) )
(test
   NIL
   (7-8 (100 200 343) 211) )
(test
   1
   (7-8 (1 2 3) 1) )

#7.9
(de 7-9 (L)
   (find prog L) )
(test
   (1)
   (7-9 '(NIL (1) NIL (2 2))) )

#7.10
# a
(setq *NOTE-TABLE # not dotted pairs
   (quote
      (C       1)
      (C-SHARP 2)
      (D       3)
      (D-SHARP 4)
      (E       5)
      (F       6)
      (F-SHARP 7)
      (G       8)
      (G-SHARP 9)
      (A       10)
      (A-SHARP 11)
      (B       12) ) )

# b
(de numbers (L)
   (mapcar
      '((N)
         (cadr (assoc N *NOTE-TABLE)) )
      L ) )
(test
   (5 3 1 3 5 5 5)
   (numbers '(E D C D E E E)) )

# c
(de notes (Lst) # memoization
   (mapcar
      '((N)
         (cache
            '(NIL)
            N
            (car
               (find '((L) (= N (cadr L))) *NOTE-TABLE) ) ) )
      Lst ) )
(test
   '(E D C D E E E)
   (notes (5 3 1 3 5 5 5)) )

# d - ignored

# e
(de raise (X Lst)
   (mapcar
      '((N) (+ X N))
      Lst ) )
(test
   (10 8 6 8 10 10 10)
   (raise 5 (5 3 1 3 5 5 5)) )

# f
(de normalize (Lst)
   (mapcar
      '((N) (% N 12))
      Lst ) )
(test
   (6 10 1)
   (normalize (6 10 13)) )

# g
(de transpose (N Lst)
   (notes (normalize (raise N (numbers Lst)))) )
(test
   '(A G F G A A A)
   (transpose 5 '(E D C D E E E)) )

# 7.11
(de 7-11 (Lst)
   (filter
      '((N) (< 1 N 5))
      Lst ) )
(test
   (2 3 4)
   (7-11 (range 1 10)) )

#7.12
(de 7-12-1 (Lst)
   (cnt '((I) (== 'the I)) Lst) )
(de 7-12-2 (Lst)
   (let C 0
      (mapc
         '((I) (and (== 'the I) (inc 'C)))
         Lst )
      C ) )
(test
   (7-12-1 '(a the b the))
   (7-12-2 '(a the b the)) )

#7.13
(de 7-13 (Lst)
   (filter
      '((L) (and (cdr L) (not (cddr L))))
      Lst ) )
(test
   '((1 2) (2 3))
   (7-13
      (quote
         (1 2 3)
         (1 2)
         (a)
         (2 3) ) ) )

#7.14 - ignored

#7.15
(setq *MY-HAND
   (quote
      (3 hearts)
      (5 clubs)
      (2 diamonds)
      (4 diamonds)
      (ace spades) ) )
(setq *COLORS
   (quote
      (clubs black)
      (diamonds red)
      (hearts red)
      (spades black) ) )
(setq *ALL-RANKS
   '(2 3 4 5 6 7 8 9 10
      jack queen king ace ) )
# a
(def 'rank2 car)
(def 'suit cadr)
(test 2 (rank2 '(2 clubs)))
(test 'clubs (suit '(2 clubs)))

# b
(de count-suit (H L)
   (cnt
      '((I) (== H (suit I)))
      L ) )
(test
   2
   (count-suit 'diamonds *MY-HAND) )

# c
(de color-of (L)
   (cadr (asoq (suit L) *COLORS)) )
(test
   'black
   (color-of '(2 clubs)) )
(test
   'red
   (color-of '(6 hearts)) )

# d
(de first-red (H)
   (find
      '((L)
         (== 'red (color-of L)) )
      H ) )
(test
   '(3 hearts)
   (first-red *MY-HAND) )

# e
(de black-cards (H)
   (filter
      '((L)
         (== 'black (color-of L)) )
      H ) )
(test
   '((5 clubs) (ace spades))
   (black-cards *MY-HAND) )

# f
(de what-ranks (S H)
   (extract
      '((L)
         (and
            (== S (suit L))
            (rank2 L) ) )
      H ) )
(test
   (2 4)
   (what-ranks 'diamonds *MY-HAND) )
(test
   '(ace)
   (what-ranks 'spades *MY-HAND) )

# g
(de higher-rank-p (A B)
   (>
      (index (rank2 A) *ALL-RANKS)
      (index (rank2 B) *ALL-RANKS) ) )
(test
   NIL
   (higher-rank-p '(2 clubs) '(6 hearts)) )
(test
   T
   (higher-rank-p '(6 clubs) '(2 hearts)) )

# h
(de high-card (H)
   (maxi
      '((L)
         (index (rank2 L) *ALL-RANKS) )
      H ) )
(test
   '(ace spades)
   (high-card *MY-HAND) )

#7.16 - ignored

#7.17
(de 7-17 (Lst)
   (sum length Lst) )
(test
   6
   (7-17 '((1) (2 3) (4 5 6))) )

#7.18 - ignored

#7.19
(de all-odd (L)
   (fully oddp L) )
   
(test T (all-odd (1 1 3)))
(test NIL (all-odd (1 2 3)))

#7.20
(de none-odd (L)
   (fully evenp L) )
(test
   NIL
   (none-odd (1 1 3)) )
(test
   T
   (none-odd (2 4 44)) )

#7.21
(de not-all-odd (L)
   (bool (find evenp L)) )
(test
   T
   (not-all-odd (1 2 3)) )
(test
   NIL
   (not-all-odd (1 1 11)) )

#7.22
(de not-none-odd (L)
   (bool (find oddp L)) )
(test
   T
   (not-none-odd (1 2 3)) )
(test
   NIL
   (not-none-odd (2 2 2)) )

#7.23-7.30 - ignored

