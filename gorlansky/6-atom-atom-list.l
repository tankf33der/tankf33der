#6.1
(de f6-1 (A B)
   (sect (str A) (str B)) )
(test
   '(b c)
   (f6-1 "a b c" "b c d") )

#6.2
(def 'f6-2 f5-16)
(test
   (1 . 2)
   (f6-2 5 3) )

#6.3
(de f6-3 (A B)
   (make
      (do (rand 2 10)
         (link (rand A B)) ) ) )
(let (A 40  B 50)
   (test
      T
      (fully '((N) (<= A N B)) (f6-3 A B)) ) )

#6.4
(de f6-4 (A N)
   (recur (A N)
      (if (=0 N) A (recurse (list A) (dec N))) ) )
(test
   '((((0))))
   (f6-4 0 4) )

#6.5
(de f6-5 (A B)
   (make
      (for (N A (<= N B) (inc N))
         (and (prime? N) (link N)) ) ) )
(test
   (2 3 5 7 11 13 17 19 23 29)
   (f6-5 1 30) )
(test
   (7 11 13 17 19 23 29)
   (f6-5 6 30) )

#6.6
(de f6-6 (A B) # pertly
   (make
      (for (N (dec A) (< N B) (link (inc N)))) ) )
(test
   (range 4 8)
   (f6-6 4 8) )

#6.7 - ignored

#6.8
(de numd (N)
   (let C 0
      (for (X 2 (<= X (/ N 2)) (inc X))
         (and (=0 (% N X)) (inc 'C)) )
      C ) )
(de f6-8 (N)
   (cdr
      (maxi
         car
         (group
            (make
               (for (X 2 (<= X N) (inc X))
                  (link (cons (numd X) X)) ) ) ) ) ) )
(test
   (60 72 84 90 96)
   (f6-8 100) )
(test
   (840)
   (f6-8 1000) )

#6.9
(de f6-9 (A N)
   (make (do N (link A))) )
(test
   (need 4 'x)
   (f6-9 'x 4) )

#6.10
(de f6-10 (A N)
   (if (=1 N)
      (list A)
      (list A (f6-10 A (dec N))) )) 
(test
   '(a (a (a (a (a (a (a)))))))
   (f6-10 'a 7) )

#6.11
(de randNC (N C)
   (make
      (do C (link (rand 1 N))) ) )
(de f6-11 (N C)
   (mapcar + (randNC N C) (randNC N C)) )
(test
   T
   (fully '((N) (<= 2 N 200)) (f6-11 100 5)) )

#6.12
(de f6-12 (N C)
   (filter evenp? (randN 10 20)) )
(test
   T
   (fully evenp?  (f6-12 10 20)) )

#6.13
(def 'f6-13 f6-9)
(test
   (need 5 10)
   (f6-13 10 5) )

#6.14
(de f6-14-1 (Lst X)
   (mapcar
      '((N) (+ N X))
      Lst ) )
(de f6-14-2 (Lst X) # destructivly
   (while Lst
      (inc Lst X)
      (pop 'Lst) ) )
(let L (1 2 3)
   (test
      (11 12 13)
      (f6-14-1 L 10) )
   (f6-14-2 L 10)
   (test (11 12 13) L) )

#6.15
(de f6-15 (W V)
   (let V (chop V)
      (make
         (for ((I . L) (chop W) L (cdr L))
            (and (= V (head 2 L)) (link I) ) ) ) ) )
(test
   (3 10 14)
   (f6-15 "abrakadabramaram" "ra") )

#6.16
(de f6-16 ()
   (maxi
      '((L)
         (let 
            (N (* (car L) (cadr L))
               C (chop N) )
            (and (= C (reverse C)) N) ) )
      (subsets 2 (range 1 999)) ) )
(test (913 993) (f6-16))

#6.17
(de f6-17 (S1 S2)
   (let S2 (str S2)
      (filter
         '((A) (not (member A S2)))
         (str S1) ) ) )
(test
   '(aa b-b)
   (f6-17 "aa b-b cc" "cc dd") )

#6.18
(de f6-18 (C N)
   (let R NIL
      (for I (chop N)
         (accu 'R I 1) )
      (sort 
         (extract
            '((L)
               (and (= (cdr L) C) (format (car L))) )
            R ) ) ) )
(test
   (1)
   (f6-18 3 1112) )
(test
   (1 2)
   (f6-18 3 1112223) )

