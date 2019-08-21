# Common part
(de prime? (N)
   (or
      (= N 2)
      (and
         (> N 1)
         (bit? 1 N)
         (let S (sqrt N)
            (for (D 3  T  (+ D 2))
               (T (> D S) T)
               (T (=0 (% N D)) NIL) ) ) ) ) )
(de evenp? (N)
   (not (bit? 1 N)) )
(de oddp? (N)
   (bit? 1 N) )

#1.1
(de f1-1 (N)
   (+ 1 N) )
(test
   101
   (f1-1 100) )
(test
   101
   (let N 100
      (inc 'N)
      N ) )

#1.2
(de f1-2 (N)
   (- N 1) )
(test
   99
   (f1-2 100) )
(test
   99
   (let N 100
      (dec 'N) ) )

#1.3
(de f1-3 (M N)
   (+ M N) )
(test
   1010
   (f1-3 1000 10) )

#1.4
(de f1-4-1 (N)
   (* 3 N) )
(de f1-4-2 (N)
   (+ N N N) )
(test
   (f1-4-1 1000)
   (f1-4-2 1000) )

#1.5
(de f1-5 (N)
   (* 31556926 N) )

# Rosetta code, modified
(de numNm (N)
   (cond
      ((=0 N))
      ((> 14 N)
         (cons
            (get
               '(one two three four five six seven 
                  eight nine ten eleven twelve thirteen ) 
               N ) ) )
      ((= 15 N) (cons 'fifteen))
      ((= 18 N) (cons 'eighteen))
      ((> 20 N)
         (cons (intern (pack (numNm (% N 10)) "teen"))) )
      ((> 100 N)
         (cons 
            (intern 
               (pack
                  (get 
                     '("twen" "thir" "for" "fif" "six" "seven" "eigh" "nine") 
                     (dec (/ N 10)) )
                  "ty"
                  (and
                     (gt0 (% N 10))
                     (pack "-" (numNm @)) ) ) ) ) )
      ((rank
         N 
         '((100 . (hundred)) (1000 . (thousand)) 
            (1000000 . (million)) (1000000000 . (billion)) ) )
         (append
            (numNm (/ N (car @)))
            (cdr @)
            (numNm (% N (car @))) ) ) ) )
(test
   31556926
   (f1-5 1) )
(test
   3155692600
   (f1-5 100) )
(test
   63555648964
   (f1-5 2014) )
(test
   (quote
      three billion one hundred fifty-five million six
         hundred ninety-two thousand six hundred )
   (numNm (f1-5 100)) )

#1.6
(de f1-6 (N)
   (* 31557600 N) )
(test
   31557600
   (f1-6 1) )
(test
   3155760000
   (f1-6 100) )
(test
   63557006400
   (f1-6 2014) )

#1.7
(de f1-7 (N)
   (/ (* N 3652425 24 60 60) 10000) )
(test
   31556952
   (f1-7 1) )
(test
   3155695200
   (f1-7 100) )
(test
   63555701328
   (f1-7 2014) )

#1.8
(de f1-8 (N M)
   (length (chop (** N M))) )
(test
   210
   (f1-8 125 100) )

#1.9 roman numerals validation
(de roman (N)
   # Roman numeral, encode
   (pack
      (make
         (mapc
            '((C D)
               (while (>= N D)
                  (dec 'N D)
                  (link C) ) )
            '(M CM D CD C XC L XL X IX V IV I)
            (1000 900 500 400 100 90 50 40 10 9 5 4 1) ) ) ) )
(de create (S)
   (let V 
      '((I . 1) 
         (V . 5)
         (X . 10)
         (L . 50)
         (C . 100)
         (D . 500)
         (M . 1000) )
      (make
         (for (I (chop S) I (cdr I))   
            (let
               (A (assoc (car I) V)
                  B (assoc (cadr I) V) )
               (link
                  (cons
                     (car A)
                     (if (>= (cdr A) (cdr B))
                        (cdr A)
                        (- (cdr A)) ) ) ) ) ) ) ) )
(de vld? (Lst)
   # non-NIL if invalid
   (find
      '((I)
         (or
            (lt0 (cdr (assoc I Lst)))
            (<
               1
               (cnt
                  '((J)
                     (= I (car J)) )
                  Lst ) ) ) )
      '(V L D) ) )
(de inrow (E Lst)
   (make
      (let Last
         (for I Lst
            (and
               (= E (car I))
               (if (= E Last)
                  (inc (made))
                  (yoke 1) ) )
            (setq Last (car I)) ) ) ) )
(de ixcm? (Lst)
   # non-NIL if invalid
   (find
      '((I)
         (let? L (inrow I Lst)
            (or
               (caddr L)
               (< 3 (maxi prog L))
               (and 
                  (cadr L)
                  (< 1 (mini prog L)) ) ) ) )
      '(I X C M) ) )
(de chars? (Lst)
   # non-NIL if invalid
   (asoq NIL Lst) )
(de positions (Lst)
   # non-NIL if invalid
   (let Lst (mapcar cdr Lst)
      (find
         '((L)
            (for (I Lst I (cdr I))
               (T
                  (when (= (car I) (car L))
                     (or
                        (nor
                           (= (cadr I) (cadr L)) 
                           (= (cadr I) (caddr L)) )
                        (= (abs (car I)) (abs (caddr I)))
                        (gt0 
                           (cnt
                              '((J) (> (abs J) (abs (car I))))
                              (cddr I) ) ) ) )
                  T ) ) )
         '((-1 5 10) (-10 50 100) (-100 500 1000)) ) ) )
(de gap (Lst)
   # non-NIL if invalid
   (let Lst (mapcar cdr Lst)
      (mapcon
         '((L)
            (and
               (< (car L) (apply max (cdr L)))
               (>= (car L) (cadr L))
               (cons (car L)) ) )
         Lst ) ) )
(de roman? (S)
   # core validation
   (let? L (create S)
      (nor
         (chars? L)
         (vld? L)
         (ixcm? L)
         (gap L)
         (positions L) ) ) )
(test
   NIL
   (create) )
(test
   '((M . 1000) (NIL) (NIL) (NIL))
   (create 'Mike))
(test
   '((C . -100) (D . 500) (X . -10) (L . 50))
   (create 'CDXL) )
(test
   NIL
   (vld? (create 'II) ) )
(test
   'L
   (vld? (create 'LL)) )
(test
   'D
   (vld? (create 'LIMMDDI)) )
(test
   'V
   (vld? (create 'VX)) )
(test
   NIL
   (inrow 'M (create 'XLIII)) )
(test
   (2 2)
   (inrow 'I (create 'IIMII)) )
(test
   (3 1)
   (inrow 'M (create 'MiMMM)) )
(for I '(C CCI CCIM CCIMC CCCIMC)
   (test
      NIL
      (ixcm? (create I)) ) )
(for I '(CCIMCC CCCCCM CCMCCMCC CMMMCCCC)
   (test
      'C
      (ixcm? (create I)) ) )
(test
   '(NIL)   
   (chars? (create 'i)) )
(test
   NIL
   (chars? (create 'MMM)) )
(test
   '(NIL)   
   (chars? (create 'MMiXL)) )
(test
   NIL
   (chars? (create 'CDMXI)) )
(test
   '(NIL)   
   (chars? (create 'iMMM)) )
(test
   NIL
   (positions (create 'CCXL)) )
(test
   (-10 50 100)
   (positions (create 'CCXLX)) )
(test
   (-10 50 100)
   (positions (create 'CCXLM)) )
(test
   NIL
   (positions (create 'CCXCII)) )
(test
   (-1 5 10)
   (positions (create 'CCXCIIM)) )
(test
   (-10 50 100)
   (positions (create 'XCXC)) )
(for I 3999
   (test
      NIL
      (gap (create (roman I)))) )
(for I 3999 
   (test
      T
      (roman? (roman I)) ) )
(for 
   I 
   '(MMMM DD CCCC LL XXXX VV IIII CMCM CDCD IVIV LXC VIX
      IIMXCC VX CMM IXIV MCMC XCX IVI LM LD LC DCM IIV )
   (test
      NIL
      (roman? I) ) )

#1.10
(de f1-10-1 (N)
   (apply
      *
      (make
         (for A (/ N 3)
            (T
               (for B (/ N 2)
                  (T
                     (let C (- N A B)
                        (and
                           (=
                              (+ (* A A) (* B B))
                              (* C C) )
                           (link A B (- N A B)) ) )
                     T ) ) ) ) ) ) )
(de f1-10-2 (N)
   (let S (sqrt N)
      (apply
         *
         (make
            (for X S
               (T
                  (for Y S
                     (T
                        (let
                           (A (- (* Y Y) (* X X))
                              B (* 2 Y X)
                              C (+ (* Y Y) (* X X)) )
                           (and
                              (=
                                 N
                                 (+ A B C) )
                              (link A B C) ) )
                        T ) ) ) ) ) ) ) )
(test
   T
   (=
      (f1-10-1 1000)
      (f1-10-2 1000) ) )

#1.11
(de f1-11 (Str)
   (glue
      " "
      (mapcar
         '((L)
            (pack (tail -1 L)) )
         (split (chop Str) " ") ) ) )
(test
   "BC BC BC"
   (f1-11 "ABC ABC ABC") )

#1.12
(de f1-12-1 (Str)
   (glue
      " "
      (mapcan
         '((L)
            (and L (cons (pack L))) )
         (split (chop Str) " ") ) ) )
(de f1-12-2 (Str)
   (glue
      NIL
      (mapcon
         '((L)
            (unless (= " " (car L) (cadr L))
               (cons (car L)) ) )
         (chop Str) ) ) )
(test
   (f1-12-1 "a ab  abc")
   (f1-12-2 "a ab  abc") )

#1.13
(de f1-13 (Str)
   (maxi length (mapcar pack (split (chop Str) " "))) )
(test
   "abc"
   (f1-13 "a ab abc") )

#1.14
(de f1-14-1 (Lst)
   (make
      (for I Lst
         (or
            (member I (made))
            (link I) ) ) ) )
(de f1-14-2 (Lst)
   (cond
      ((not Lst))
      ((member (car Lst) (cdr Lst))
         (f1-14-2 (cdr Lst)) )
      (T (cons (car Lst) (f1-14-2 (cdr Lst)))) ) )
(test
   (f1-14-1 (1 2 3 4 5 1 2))
   (let @ (f1-14-2 (1 2 3 4 5 1 2))
      (do 2 (rot @)) ) )

#1.15
(de f1-15 (N)
   (dec (** 2 N)) )
(test
   18446744073709551615
   (f1-15 64) )

#1.16
(de f1-16 (Str)
   (glue
      " "
      (mapcar
         pack
         (by
            '((L)
               (cnt
                  '((I) (member I '(a e i o u)))
                  L ) )
            sort
            (split (chop Str) " ") ) ) ) )
(test
   "w aww aaw aaaw"
   (f1-16 "aaaw aaw aww w") )

#1.17
(de f1-17 (D Str)
   (glue
      " "
      (filter
         '((I) (sub? D I))
         (mapcar pack (split (chop Str) " ") ) ) ) )
(test
   "abc bcd"
   (f1-17 "bc" "abc bcd cde") )

#1.18
(de f1-18 (F Str)
   (glue
      " "
      (mapcar 
         F
         (mapcar
            pack (split (chop Str) " ") ) ) ) )
(de capt (Str)
   (let Str (chop Str)
      (set Str (uppc (car Str)))
      (pack Str) ) )
(test
   (f1-18 uppc "ab cd")
   (f1-18 
      uppc
      (f1-18 lowc "AB CD") ) )
(test
   "Abc"
   (capt "abc") )

#1.19
(de f1-19 (N)
   (& N (dec N)) )
(for I 10
   (test
      0
      (f1-19 (** 2 I)) ) )

#1.20
(de f1-20 (Str)
   (let Str (str Str "")
      ((intern (cadr Str)) (car Str) (caddr Str)) ) )
(test
   T
   (=
      (f1-20 "  10 + 90")
      (f1-20 "10 * 10")
      (f1-20 "110 -  10 ") ) )

#1.21
(de f1-21 (N)
   (sum
      '((X)
         (apply * (range 1 X)) )
      (range 1 N) ) )
(test
   33
   (f1-21 4) )
(test
   53652269665821260313
   (f1-21 21) )

#1.22 - ignored

#1.23
(scl 2)
(de f1-23-1 (N)
   (sum
      '((N) (*/ (inc N) 1.0 N))
      (range 1 N) ) )
(test
   "3.50"
   (round (f1-23-1 2)) )
(test
   "24.65"
   (round (f1-23-1 21)) )
(scl 0)

(de f1-23-2 (N)
   (let R (frac 2 1)
      (for (I 2 (>= N I) (inc I))
         (setq R (f+ R (frac (inc I) I))) )
      R ) )
(test
   (7 . 2)
   (f1-23-2 2) )
(test
   (127494581 . 5173168)
   (f1-23-2 21) )

#1.24
(de f1-24 (X)
   (let C 0
      (for (N 0 (>= X N) (inc N))
         (let S (mapcar format (chop (pad 4 N)))
            (and
               (=
                  (+ (car S) (cadr S))
                  (+ (caddr S) (cadddr S)) )
               (inc 'C) ) ) )
      C ) )
(test
   670
   (f1-24 9999) )

#1.25
(de f1-25 (X)
   (let (C 0)
      (for N X
         (and
            (bit? 1 N)
            (inc 'C N) ) )
      C ) )
(test
   2500
   (f1-25 100) )
(test
   25000000
   (f1-25 10000) )

#1.26
(de f1-26 (Lst)
   (maxi
      '((L)
         (let L (chop L)
            (and
               (= L (reverse L))
               (length L) ) ) )
      Lst ) )
(test
   'hannah
   (f1-26 '(anna mike hannah xamax)) )

#1.27
(de f1-27 (Lst)
   (mapcon
      '((L)
         (unless (= (car L) (cadr L))
            (cons (car L)) ) )
      Lst ) )
(test
   '(aa bb)
   (f1-27 '(aa aa aa bb bb)) )

#1.28
(de f1-28 (Str)
   (length (uniq (chop Str))) )
(test
   3
   (f1-28 "aabbc") )

#1.29
(de f1-29 (Name)
   (in Name
      (while (line)
         (prinl @) ) ) )
# (f1-29 "f1-29.txt") # interactive tasks disabled

#1.30
(de f1-30-1 (L Lst)
   (let C 0
      (for I Lst
         (and
            (sub? L I)
            (inc 'C) ) )
      C ) )
(de f1-30-2 (L Lst)
   (let (C 0  L (chop L))
      (for I Lst
         (for (J (chop I) J (cdr J))
            (and
               (sub? L J)
               (inc 'C) ) ) )
      C ) )
(test
   T
   (=
      (f1-30-1 'jar '(jar jar))
      (f1-30-1 'ja '(jar jar))
      (f1-30-1 'r '(jar jar)) ) )
(test
   T
   (=
      (f1-30-2 'ja '(jar jar))
      (f1-30-2 'aa '(aaa)) ) )
(test
   3
   (f1-30-2 'aa '(aaaa)) )

#1.31
(de f1-31 (N)
   (let C 0
      (for I (/ N 2)
         (and
            (=0 (% N I))
            (inc 'C I) ) )
      C ) )
(test
   117
   (f1-31 100) )
(test
   57
   (f1-31 99) )

#1.32
(de f1-32 (N)
   (format
      (mini
         format
         (permute (chop N)) ) ) )
(test
   33444455
   (f1-32 34544534) )

#1.33 - ignored

#1.34
(de f1-34 (N)
   (hex N) )
(test
   "A"
   (hex 10) )
(test
   "FF"
   (hex 255) )

#1.35 - ignored

#1.36 - ignored

#1.37
(de f1-37 (Str)
   (glue
      " "
      (filter
         num?
         (str Str) ) ) )
(test
   "1 44"
   (f1-37 "  a 1 b 2c 44") )

#1.38
(de f1-38 (N)
   (let C 0
      (for I (/ N 2)
         (and
            (=0 (% N I))
            (inc 'C) ) )
      C ) )
(test
   8
   (f1-38 100) )
(test
   5
   (f1-38 99) )

#1.39 - ignored

#1.40
(de encode (Lst)
   (mapcar
      '((X) (cons (car X) (length X)))
      (make
         (let Last NIL
            (mapc 
               '((X)
                  (if (= X (car Last))
                     (conc Last (cons X))
                     (link (setq Last (cons X))) ) )
               Lst ) ) ) ) )
(de f1-40 (Lst)
   (pack
      (make
         (map
            '((I)
               (and
                  (format (caar I))
                  (or
                     (<= 2 (cdar I))
                     (and
                        (= "#" (caadr I))
                        (<= 2 (cdadr I)) ) )
                  (link (format (caar I))) ) )
            (encode (chop Lst)) ) ) ) )
(test
   T
   (=
      (f1-40 "4434###552222311333661")
      (f1-40 "4434###552222311333661")
      (f1-40 "###4434###552222311333661") ) )
(test
   "54452136"
   (f1-40 "5###4434###552222311333661") )

#1.41
(de f1-41 (N)
   (format (reverse (chop N))) )
(test
   4321
   (f1-41 1234) )
(test
   76543
   (f1-41 34567) )

#1.42
(de f1-42 (Str)
   (glue " " (str Str) ) )
(test
   "aa bb"
   (f1-42 "aa   bb") )
(test
   "mike p"
   (f1-42 "  mike  p ") )

#1.43
(de f1-43 (Lst)
   (mapcar
      '((J)
         (let J (chop J)
            (xchg
               (nth J 1)
               (nth J (length J)) )
            (or (format J) (intern (pack J))) ) )
      Lst ) )
(test
   '(a cba eikm 52341)
   (f1-43 '(a abc mike 12345)) )

#1.44
(de f1-44 (N)
   (let (C 0  X 0)
      (loop
         (T
            (>
               (setq X (apply * (range 1 (inc 'C))))
               N )
            NIL )
         (T (= X N) C) ) ) )
(test
   6
   (f1-44 720) )
(test
   T
   (= (f1-44 721) (f1-44 719)) )

#1.45 - ignored

#1.46
(de f1-46 (N)
   (cache '(NIL) N
      (if (>= 2 N)
         N
         (+ (f1-46 (dec N)) (f1-46 (- N 2))) ) ) )
(test
   89
   (f1-46 10) )
(test
   144
   (f1-46 11) )

#1.47
(scl 6)
(de f1-47 (N)
   (format (*/ 1.0 1.0 (tan (* 1.0 90))) *Scl) )
(test
   "-0.501203"
   (f1-47 90) )

#1.48
(de f1-48 (N)
   (format (*/ 1.0 (*/ 1.0 N N 4) pi) *Scl) )
(test
   "7.957746"
   (f1-48 10) )

#1.49
(de f1-49 (Lst)
   (let C 0
      (map
         '((I)
            (and
               (= "." (car I))
               (low? (cadr I))
               (inc 'C) ) )
         Lst )
      C ) )
(test
   10
   (f1-49 (chop "a.bc.defg.h.i.j.k.Lm.nopq.Rs.tuvwx.y.z")) )

#1.50
(de f1-50 (N)
   (if (=0 N)
      0
      (+ N (f1-50 (dec N))) ) )
(test
   55
   (f1-50 10) )

#1.51
(de f1-51 (N)
   (cond
      ((=0 N) 0)
      ((not (bit? 1 N))
         (+ N (f1-51 (dec N))) )
      (T (f1-51 (dec N))) ) )
(test
   30
   (f1-51 10) )

#1.52
(de f1-52 (N M)
   (default M 0)
   (if (<= 1 N)
      (f1-52 (/ N 2) (inc M))
      M ) )
(test
   7
   (f1-52 70) )
(test
   10
   (f1-52 700) )

#1.53
(de factor (N)
   (make
      (let (D 2  L (1 2 2 . (4 2 4 2 4 6 2 6 .))  M (sqrt N))
         (while (>= M D)
            (if (=0 (% N D))
               (setq M (sqrt (setq N (/ N (link D)))))
               (inc 'D (pop 'L)) ) )
         (link N) ) ) )
(de f1-53 (N)
   (apply max (factor N)) )
(test
   6857
   (f1-53 600851475143) )

#1.54
(de f1-54 (N)
   (let (S 0  K 0)
      (for I N
         (inc 'S (* I I))
         (inc 'K I) )
      (- (* K K) S) ) )
(test
   2640
   (f1-54 10) )
(test
   25164150
   (f1-54 100) )

#1.55
(de f1-55 (Str)
   (length (str Str)) )
(test
   3
   (f1-55 "aa aa  aa") )

#1.56
(de f1-56 (Str)
   (glue
      ""
      (mapcar
         '((I)
            (if (> 4 (cdr I))
               (need (cdr I) (car I))
               (pack "!" (cdr I) (car I)) ) )
         (encode (chop Str)) ) ) )
(test
   "aabbaaabbbcsdk!4A!5b"
   (f1-56 "aabbaaabbbcsdkAAAAbbbbb") )
 
#1.57 - ignored

#1.58 - ignored

#1.59
(de f1-59 (N Q)
   (if (< N Q)
      N
      (+ (* (f1-59 (/ N 10) Q) Q)
         (% N 10) ) ) )
(test
   10
   (f1-59 1010 2) )
(test
   1263
   (f1-59 2357 8) )

#1.60
(de f1-60 (N)
   (let C 0
      (for I N 
         (case (% I 4)
            ((0 2)
               (setq C
                  (+ 
                     C
                     (* 20 (** 30 (- (/ I 2) 1))) ) ) )
            (1
               (setq C
                  (+ 
                     C 
                     (* 100 (** 500 (- (/ I 4) 1))) ) ) ) ) )
      C ) )
(test
   20
   (f1-60 3) )
(test
   608720
   (f1-60 9) )

#1.61
(de f1-61 (Str)
   (glue
      " "
      (reverse (str Str)) ) )
(test
   "aa 33 12"
   (f1-61 "12 33 aa") )
(test
   "cd ab"
   (f1-61 "ab cd") )

#1.62
(de f1-62 (N)
   (let S 0
      (for I N
         (or
            (bit? 1 I)
            (inc 'S I) ) )
      S ) )
(test
   30
   (f1-62 11) )

#1.63
(de word (Str)
   (use (@A @B)
      (or
         (and
            (match '(@A "i" "n" "g" @B) Str)
            (list @A "ed" @B) )
         Str) ) )
(de f1-63 (Str)
   (glue " " (mapcar word (split (chop Str) " "))) )
(test
   "edlewood laughed, and danced."
   (f1-63 "inglewood laughing, and dancing.") )

#1.64
(de f1-64 (N)
   (let S 1
      (for I N
         (or
            (bit? 1 I)
            (setq S (* S I)) ) )
      S ) )
(test
   8
   (f1-64 5) )

#1.65
(de f1-65 (N)
   (+
      (apply * (range 1 N))
      (** N 20) ) )
(test
   4274883284060025564298013753389399680275971079215018641463848989276401
   (f1-65 53) )

#1.66
(de f1-66 (Str)
   (pick
      format
      (flip (chop Str)) ) )
(test
   2
   (f1-66 "ab1cd2e") )

#1.67
(de f1-67-1 (Str)
   (bool
      (find
         '((L) (and (caddr L) (not (cdddr L))))
         (by format group (chop Str)) ) ) )
(de f1-67-2 (Str)
   (bool
      (find 
         =
         (mapcar length (by format group (chop Str))) 
         (3 .) ) ) )
(test
   (f1-67-1 "1234")
   (f1-67-2  "1234") )
(test
   (f1-67-1 "1112")
   (f1-67-2 "1112") )

