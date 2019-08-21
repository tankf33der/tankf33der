#11.1
(de f11-1 (A B E)
   (recur (A B)
      (if2 (> B E) (evenp? B)
         0
         0
         (+ B (recurse B (+ A B)))
         (recurse B (+ A B)) ) ) )
(test
   4613732
   (f11-1 1 2 4000000) )

#11.2
(de f11-2 (L1 L2)
   (nor (diff L1 L2) (diff L2 L1)) )
(test
   T
   (f11-2 '(a b c) '(c b a)) )
(test
   NIL
   (f11-2 '(a b c) '(c b b)) )
(test
   NIL
   (f11-2 '(c b b) '(a b c)) )

#11.3
(de f11-3 (X A B)
   (<= A X B) )
(test
   T
   (f11-3 1 1 3) )
(test
   NIL
   (f11-3 1 2 13) )

#11.4
(de f11-4 (N) # rosetta
   (cache '(NIL) N
      (if (>= 2 N)
         N
         (+ (f11-4 (dec N)) (f11-4 (- N 2))) ) ) )
(test
   14930352
   (f11-4 35) )

#11.5 - ignored
#11.6 - ignored

#11.7
(de f11-7 (N)
   (sum f11-4 (range 1 N)) )
(test
   1500520536206896083275
   (f11-7 100) )

#11.9 - ignored
#11.10 - ignored

(de f11-11 (A B C)
   (= (** A B) C) )
(test
   T
   (f11-11 2 3 8) )
(test
   NIL
   (f11-11 2 3 3) )

#11.12
(de f11-12 (A B C D) # without test
   (and
      (rand A B)
      (<= C @ D) ) )

#11.13
(de f11-13 (A B C)
   (< (abs (- A B)) C (+ A B)) )
(test
   T
   (f11-13 2 2 3) )
(test
   NIL
   (f11-13 1 2 3) )

#11.14
(de f11-14 (A B N)
   (let P 1
      (for (X A (<= X B) (inc X))
         (and
            (=0 (% X N))
            (setq P (* P X)) ) )
      P ) )
(test
   5457521857125853405570201949306880000
   (f11-14 12 96 4) )

#11.15
(de f11-15 (N A B)
   (sum
      '((X)
         (when (or (=0 (% X A)) (=0 (% X B)))
            X ) )
      (range 0 N) ) )
(test
   23
   (f11-15 9 3 5) )
(test
   233168
   (f11-15 999 3 5) )

#11.16 - ignored

#11.17
(de f11-17 (A B C)
   (and
      (> (+ A B) C)
      (> (+ A C) B)
      (> (+ B C) A) ) )
(test
   NIL
   (f11-17 1 2 3) )
(test
   T
   (f11-17 2 3 4) )

#11.18
(def 'f11-18 f11-14)
(test
   5457521857125853405570201949306880000
   (f11-18 10 99 4) )

#11.19
(de f11-19 (A B N)
   (make
      (for (X A (<= X B) (inc X))
         (or (=0 (% X N)) (link X)) ) ) )
(test
   (1 2 3 5 6 7 9 10 11 13 14 15 17 18 19 21 22 23 25 26 27 29 30)
   (f11-19 1 30 4) )

#11.20 - ignored



