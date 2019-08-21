# 11.5
(de initials (L)
   (and
      L
      (cons 
         (intern (car (chop (car L))))
         (initials (cdr L)))) )
(let L '(alpha beta ceta)
   (test
      (mapcar '((L) (intern (car (chop L)))) L)
      (initials L) ) )
# 11.6
(de countdown (N)
   (if (=0 N)
      (cons 'BLASTOFF!)
      (cons N (countdown (dec N))) ) )
(test
   (conc
      (range 3 1)
      (cons 'BLASTOFF!) ) 
   (countdown 3) )
# 11.7
(de copies (N A)
   (and
      (gt0 N)
      (cons A (copies (dec N) A)) ) )
(test
   (need 3 'A)
   (copies 3 'A) )
# 12.5
(de exagg-help (A)
   (cond
      ((num? A) (+ A A))
      ((== 'good A) 'great)
      ((== 'bad A) 'terrible)
      (T A) ) )
(de exaggerate (L)
   (and
      L
      (cons
         (exagg-help (car L))
         (exaggerate (cdr L)) ) ) )
(test
   (6 mike 12)
   (exaggerate '(3 mike 6)) )
(test
   '(lisp is great)
   (exaggerate '(lisp is good)) )
# 12.6
(de gpa (L S N)
   (default S 0  N 0)
   (cond
      ((not L) (and (gt0 N) (/ S N)))
      (T
         (gpa 
            (cdr L) 
            (+ S (car L)) 
            (inc N)) ) ) )
(test 3 (gpa (1 2 3 4 5)))
(test NIL (gpa))
# 12.7
(de spell-help (N)
   (car
      (nth 
         '(zero one two three four five six seven eight nine)
         (inc N) ) ) )
(de spell-digit (N)
   (and
      (gt0 N)
      (conc 
         (spell-digit (/ N 10))
         (cons (spell-help (% N 10))) ) ) )
(test
   '(four five six six)
   (spell-digit 4566) )
(test NIL (spell-digit))
# 12.8
(de numbers (L)
   (cond
      ((not L))
      ((num? (car L)) 
         (cons (car L) (numbers (cdr L))) )
      (T (numbers (cdr L))) ) )
(let (L1 '(mike 3 mike 33)  L2 '(3 mike 33 mike))
   (test
      (filter num? L1)
      (numbers L1) )
   (test
      (filter num? L2)
      (numbers L2) ) )
# 12.9
(de real-word? (W)
   (member
      W 
      '(a the an in of and for to with) ) )
(de real-words (L)
   (cond
      ((not L))
      ((real-word? (car L)) (real-words (cdr L)))
      (T (cons (car L) (real-words (cdr L)))) ) )
(test
   (filter
      '((W) (not (real-word? W)))
      '(mike a mike) ) 
   (real-words '(mike a mike)) )
(test '(mike) (real-words '(a mike a)))
# 12.10
(de my-remove (A L)
   (cond
      ((not L))
      ((== A (car L)) (my-remove A (cdr L)))
      (T (cons (car L) (my-remove A (cdr L)))) ) )
(test
   '(song love of loved by beatles)
   (my-remove 'the '(the song love of the loved by the beatles)) )
# 12.11
(de my-count (L N)
   (default N 0)
   (cond
      ((not L) N)
      (T (my-count (cdr L) (inc N))) ) )
(test 4 (my-count '(a b b a)))
(test 4 (my-count (chop "abba")))
# 12.12
(de arabic-help (A)
   (cache 
      '(NIL)
      A
      (cdr 
         (assoc 
            A
            '((M . 1000) (D . 500) (C . 100)
               (L . 50) (X . 10) (V . 5) (I . 1) ) ) ) ) )
(de arabic (N L S)
   (default L (chop N)  S 0)
   (ifn (cdr L)
      (+ (arabic-help (car L)) S)
      (arabic
         N 
         (cdr L)
         ((if (>= (arabic-help (car L)) (arabic-help (cadr L))) + -)
            S
            (arabic-help (car L)) ) ) ) )
(test 1971 (arabic 'MCMLXXI))
(test 1066 (arabic 'MLXVI))
(test 1009 (arabic 'MIX))
# 12.13 - ignored
# 13.5
(de vowel? (A)
   (member A '(a e i o u y)) )
(de pigl (L C)
   (default C (length L))
   (cond
      ((=0 C) (intern (pack L '(a y)))) # no vowel loop detection
      ((vowel? (car L)) (intern (pack L '(a y))))
      (T (pigl (append (cdr L) (cons (car L))) (dec C))) ) )
(test 'awnpray (pigl (chop 'prawn)))
(test 'frzzmlptay (pigl (chop 'frzzmlpt)))
# 13.6 - ignored
# 14.1
(de remove-once (A L)
   (cond
      ((not L))
      ((== A (car L)) (cdr L))
      (T (cons (car L) (remove-once A (cdr L)))) ) )
(test
   (delete 'morning '(good morning good morning))
   (remove-once 'morning '(good morning good morning)) )
# 14.2
(de upup1 (L A B)
   (default A 1  B (length L))
   (and
      (<= A B)
      (conc
         (cons (intern (pack (head A L))))
         (upup1 L (inc A) B) ) ) )
(de upup2 (L Tail)
   (default Tail (cons (intern (pack (car L)))))
   (and
      L
      (conc 
         Tail 
            (upup2 
               (cdr L) 
               (cons 
                  (intern
                     (pack
                        (conc (chop (car Tail)) (cons (cadr L))) ) ) ) ) ) ) )
(test
   (upup2 (chop 'town))
   (upup1 (chop 'town)) )
# 14.3
(de remdup (L R)
   (cond
      ((not L) R)
      ((not (member (car L) R))
         (remdup (cdr L) (conc R (cons (car L)))) )
      (T (remdup (cdr L) R)) ) )
(test
   '(ob la di da)
   (remdup '(ob la di ob la da)) )
# 14.4
(de odds (L A)
   (default A 1)
   (cond
      ((not L))
      ((bit? 1 A) (cons (car L) (odds (cdr L) (inc A))))
      (T (odds (cdr L) (inc A))) ) )
(test
   '(i my girl)
   (odds '(i lost my little girl)) )
(test NIL (odds))
(test '(A) (odds '(A B)))
# 14.5
(de letter-count (L S)
   (default S 0)
   (if L
      (letter-count (cdr L) (+ (length (car L)) S))
      S ) )
(test 11 (letter-count '(fixing a hole)))
# 14.6
(de member? (A L)
   (cond
      ((not L))
      ((= A (car L)) @)
      (T (member? A (cdr L))) ) )
(test T (member? 1 (1 2 3)))
(test T (member? 1 (2 3 1)))
(test NIL (member? 1 (2 3)))
(test NIL (member? 1))
(test NIL (member?))
# 14.7
(de differences (L)
   (and
      (cdr L)
      (cons 
         (- (cadr L) (car L))
         (differences (cdr L)) ) ) )
(test
   (19 -14 78 -81 6)
   (differences (4 23 9 87 6 12)) )
# 14.8
(de expand (L)
   (cond
      ((not L))
      ((num? (car L))
         (conc 
            (need (car L) (cadr L))
            (expand (cddr L)) ) )
      (T (conc (cons (car L)) (expand (cdr L)))) ) )
(test
   '(mike mike mike mike birds french french french hens)
   (expand '(4 mike birds 3 french hens)) )
# 14.9
(de location (A L B)
   (default B 1)
   (cond
      ((not L))
      ((= A (car L)) B)
      (T (location A (cdr L) (inc B))) ) )
(test 1 (location 1 (1 2 3)))
(test 2 (location 1 (2 1 3)))
(test 3 (location 1 (2 3 1)))
(test NIL (location 1 (2 3 4)))
(test NIL (location 1))
(test NIL (location))
# 14.10
(de count-adjacent-duplicates (L)
   (cond
      ((not L) 0)
      ((= (car L) (cadr L))
         (+ 1 (count-adjacent-duplicates (cdr L))) )
      (T (+ 0 (count-adjacent-duplicates (cdr L)))) ) )
(test 
   3
   (count-adjacent-duplicates '(y a b b a d a b b a d o o)) )
(test
   2
   (count-adjacent-duplicates '(yeah yeah yeah)) )
# 14.11
(de remove-adjacent-duplicates (L)
   (cond
      ((not L))
      ((= (car L) (cadr L))
         (remove-adjacent-duplicates (cdr L))) 
      (T (cons (car L) (remove-adjacent-duplicates (cdr L)))) ) )
(test
   '(y a b a d a b a d o)
   (remove-adjacent-duplicates '(y a b b a d a b b a d o o)) )
(test
   '(yeah)
   (remove-adjacent-duplicates '(yeah yeah yeah)) )
# 14.12
(de progressive-squares? (L)
   (cond
      ((not (cdr L)) T)
      ((= (* (car L) (car L)) (cadr L))
         (progressive-squares? (cdr L)) ) ) )
(test 
   T
   (progressive-squares? (3 9 81 6561)) )
(test
   NIL
   (progressive-squares? (25 36 49 64)) )
# 14.13 - see 13.5
# 14.14
(de same-shape? (L1 L2)
   (cond
      ((and (not L1) (not L2)) T)
      ((= (length (car L1)) (length (car L2)))
         (same-shape? (cdr L1) (cdr L2)) ) ) )
(test
   T
   (same-shape? '(the fool on the hill) '(you like me too much)) )
(test
   NIL
   (same-shape? '(the fool on the hill) '(and your bird can sing)) )
(test T (same-shape?))
(test NIL (same-shape? (1)))
(test NIL (same-shape? (1 2 3 2) (2 5)))
# 14.15
(de merge (L1 L2)
   (cond
      ((not L1) L2)
      ((not L2) L1)
      ((> (car L1) (car L2)) 
         (cons (car L2) (merge L1 (cdr L2))) )
      (T (cons (car L1) (merge (cdr L1) L2))) ) )
(test
   (3 4 6 7 9 12 18 24 36 40 50 99)
   (merge (4 7 18 40 99) (3 6 9 12 24 36 50)) ) 
# 14.16 - ignored
# 15.1
(de to-binary (N)
   (cond
      ((=0 N) (cons 0))
      ((=1 N) (cons 1))
      (T (conc (to-binary (/ N 2)) (cons (% N 2)))) ) )
(test (bin 9) (pack (to-binary 9)))
(test (bin 999) (pack (to-binary 999)))

(msg 'OK-SimplyScheme)

