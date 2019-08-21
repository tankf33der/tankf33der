#5.1
(de f5-1 (A B)
   (f/ (frac (+ A B) 1) (frac 2 1)) )
(test
   (5 . 2)
   (f5-1 2 3) )

#5.2
(de f5-2 (M N C)
   (default C 0)
   (if (< M N)
      C
      (f5-2 (- M N) N (inc C)) ) )
(test
   4
   (f5-2 27 6) )

#5.3
(de f5-3 (Str N)
   (pack (tail N (chop Str))) )
(test
   "cde"
   (f5-3 "abcde" 3) )

#5.4
(de f5-4 (P S)
   (let N 0
      (match
         (mapcar
            '((I)
               (if (member I '(? *)) (pack "@" (inc 'N)) I) )
            (chop P) )
         (chop S) ) ) )
(let P "L?*S**P"
   (test
      T
      (f5-4 P "LISP") )
   (test
      T
      (f5-4 P "LCISP") )
   (test
      T
      (f5-4 P "LISRP") )
   (test
      T
      (f5-4 P "LLISP") )
   (test
      T
      (f5-4 P "LISPP") )
   (test
      NIL
      (f5-4 P "CLISP") )
   (test
      NIL
      (f5-4 P "LISPC") )
   (test
      NIL
      (f5-4 P "") ) )

#5.5
(de f5-5 (R2 R1)
   (format (- (* pi R2 R2) (* pi R1 R1)) *Scl) )
(test
   "15.707965"
   (f5-5 3 2) )

#5.6
(de f5-6 (R2 R1)
   (format (*/ pi pi R1 (** (- R2 R1) 2) 2) 12) )
(test
   "9.869606577649"
   (f5-6 3 2) )
 
#5.7
(de f5-7 (A N)
   (if (=0 N)
      A
      (* A (inc (f5-7 (inc A) (dec N)))) ) )
(test
   33
   (f5-7 1 3) )

#5.8
(de f5-8 (L P N)
   (let
      (L (chop L)
         I
         (and
            (sub? P L)
            (+
               (index (car (chop P)) L)
               (dec (length P)) ) ) )
   (pack (head I L) N (tail (- I) L)) ) )
(test
   "abcdzze"
   (f5-8 "abcde" "bcd" "zz") )

#5.9 - ignored

#5.10
(def 'f5-10 gcd)
(test
   35
   (f5-10 70 105) )
(test
   23
   (f5-10 32453 345) )

#5.11
(de f5-11 (S C)
   (pack
      (mapcar
         '((I) (if (member I '(a e i o u)) C I))
         (chop S) ) ) )
(test
   "zbzrzkzdzbrz"
   (f5-11 "aberikodubra" "z") )

#5.12
(de f5-12 @
   (bool (=1 (f3-125 (rest)))) )
(test
   NIL
   (f5-12 10 15 25) )
(test
   T
   (f5-12 10 15 27) )

#5.13
(de f5-13 (N M)
   (let S 0
      (for (X N (>= M X) (inc X))
         (inc 'S (* X X X)) )
      S ) )
(test
   224
   (f5-13 2 5) )

#5.14
(de f5-14 (N M)
   (let S 0
      (for X N
         (inc 'S (** X M)) )
      S ) )
(test
   385
   (f5-14 10 2) )

#5.15
(de f5-15 (A B)
   (if (< A B) 0 (inc (f5-15 (- A B) B))) )
(test
   3
   (f5-15 10 3) )

#5.16
(de f5-16 (A B N)
   (default N 0)
   (if (< A B)
      (cons N A)
      (f5-16 (- A B) B (inc N)) ) )
(test
   (3 . 1)
   (f5-16 10 3) )

#5.17
(de f5-17 (M N)
   (if (=1 N) M (* M (f5-17 M (dec N)))) )
(test
   8
   (f5-17 2 3) )

#5.18 - ignored

#5.19
#5.20 - ignored

#5.21   
(def 'f5-21 f5-11)
(test
   "cangratalataans"
   (f5-21 "congratulations" "a") )

#5.22
(setq *F5-22-DIGIT
   (mapcar
      format
      (chop
         "73167176531330624919225119674426574742355349194934\
            96983520312774506326239578318016984801869478851843\
            85861560789112949495459501737958331952853208805511\
            12540698747158523863050715693290963295227443043557\
            66896648950445244523161731856403098711121722383113\
            62229893423380308135336276614282806444486645238749\
            30358907296290491560440772390713810515859307960866\
            70172427121883998797908792274921901699720888093776\
            65727333001053367881220235421809751254540594752243\
            52584907711670556013604839586446706324415722155397\
            53697817977846174064955149290862569321978468622482\
            83972241375657056057490261407972968652414535100474\
            82166370484403199890008895243450658541227588666881\
            16427171479924442928230863465674813919123162824586\
            17866458359124566529476545682848912883142607690042\
            24219022671055626321111109370544217506941658960408\
            07198403850962455444362981230987879927244284909188\
            84580156166097919133875499200524063689912560717606\
            05886116467109405077541002256983155200055935729725\
            71636269561882670428252483600823257530420752963450" ) ) )

(de f5-22 (Lst N) # XXX, too simpler
   (apply 
      *
      (maxi
         '((L) (apply * L))
         (make
            (for (L Lst L (cdr L))
               (link (head N L)) ) ) ) ) )
(test
   5832
   (f5-22 *F5-22-DIGIT 4) )
(test
   23514624000
   (f5-22 *F5-22-DIGIT 13) )

#5.23
(de f5-23 (N)
   (let (X 1  S 0)
      (while (gt0 N)
         (and
            (prime? (inc 'X))
            (inc 'S X)
            (dec 'N) ) )
      S ) )
(test
   3682913
   (f5-23 1000) )

#5.24
(de f5-24 (A B)
   (sum format (chop (** A B))) )
(test
   26
   (f5-24 2 15) )
(test
   1366
   (f5-24 2 1000) )

#5.25
(de f5-25 (A B)
   (sum 
      '((N) (sum '((A) (length A)) (numNm N)))
      (range A B)) )
(test
   19
   (f5-25 1 5) )
(test
   19171
   (f5-25 1 1000) )

#5.26
(de f5-26 (A B)
   (let S 0
      (for (N A (<= N B) (inc N))
         (inc 'S (* N N N)) ) ) )
(test
   2281600
   (f5-26 25 55) )

#5.27
(de f5-27 (N M)
   (if (=0 N) 0 (+ M (f5-27 (dec N) M))) )
(test
   136
   (f5-27 8 17) )

#5.28 - ignored









