#8.1 - ignored

#8.2
(de anyoddp (L)
   (cond
      ((not L))
      ((bit? 1 (car L)) T)
      (T (anyoddp (cdr L))) ) )
(de anyoddp-if (L)
   (when L
      (if (bit? 1 (car L)) 
         T
         (anyoddp-if (cdr L)) ) ) )
(test
   (anyoddp)
   (anyoddp-if) )
(test
   (anyoddp (2 2))
   (anyoddp-if (2 2)) )
(test
   (anyoddp (2 2 3))
   (anyoddp-if (2 2 3)) )

#8.3 - ignored

#8.4
(de laugh (N)
   (cond
      ((le0 N))
      (T (cons 'HA (laugh (dec N)))) ) )
(de laugh-v2 (N)
   (if (le0 N)
      NIL
      (cons 'HA (laugh-v2 (dec N))) ) )
(test
   T
   (=
      (laugh 3)
      (laugh-v2 3) ) )

#8.5
(de add-up (L)
   (if L
      (+ (car L) (add-up (cdr L)))
      0 ) )
(test
   12
   (add-up (2 3 7)) )

#8.6
(de alloddp (L)
   (or
      (not L)
      (and (bit? 1 (car L)) (alloddp (cdr L))) ) )
(test
   T
   (alloddp (1 3 33)) )

#8.7
(de member- (I L)
   (cond
      ((not L))
      ((= I (car L)) L)
      (T (member- I (cdr L))) ) )
(test
   NIL
   (member- 9 (1 2 3 4 5 6)) )
(test
   (3 4 5 6)
	   (member- 3 (1 2 3 4 5 6)) )

#8.8
(de assoc- (I L)
   (cond
      ((not L))
      ((= I (caar L)) (car L))
      (T (assoc- I (cdr L))) ) )
(let L '((999 1 2 3) ("b" . 7) ("ok" "Hello"))
   (test
      '("b" . 7)
      (assoc- "b" L) )
   (test
      NIL
      (assoc- 'u L) ) )

#8.9
(de nth- (L N) ## without range fast stop
   (cond
      ((not L))
      ((= 1 N) L)
      (T (nth- (cdr L) (dec N))) ) )
(let L (1 2 3)
   (test
      NIL
      (nth- L -1) )
   (test
      NIL
      (nth- L 0) )
   (test
      L
      (nth- L 1) )
   (test
      (cdr L)
      (nth- L 2) )
   (test
      NIL
      (nth- L 12) ) )

#8.10 - ignored

#8.11
(de fib (N)
   (if (> 2 N)
      1
      (+
         (fib (- N 1))
         (fib (- N 2)) ) ) )
(test
   8
   (fib 5) )

#8.12
(de any-7-p (L)
   (cond
      ((= (car L) 7) T)
      (T (any-7-p (cdr L))) ) )
# correct = (1 2 7)
# infitum = (1 2)

#8.13
(de fact (N)
   (cond
      ((=0 N) 1)
      (T (* N (fact (dec N)))) ) )
# (fact 5) -> 120
# (fact -5) -> infitum

#8.14
(de f ()
   (f) )

#8.15
# picture = (x .)
# count-slices will be in infitum 

#8.16
# didnt find difference in picolisp while testing switch

#8.17
(de find-first-odd (L)
   (cond
      ((not L))
      ((bit? 1 (car L)) (car L))
      (T (find-first-odd (cdr L))) ) )
(test
   (find '((I) (bit? 1 I)) (2 2 33))
   (find-first-odd (2 2 33)) )

#8.18
(de last-element (L)
   (if (atom (cdr L))
      (car L)
      (last-element (cdr L)) ) )
(test
   (last (1 2 3))
   (last-element (1 2 3)) )

#8.19
# infitum is no odd in list

#8.20 - ignored

#8.21
(de add-nums (N)
   (if (=0 N)
      0
      (+ N (add-nums (dec N))) ) )
(test
   (apply + (range 0 5))
   (add-nums 5) )

#8.22
(de f8-22 (L) # non-recursive
   (for (I L (cdr I) (cdr I))
      (NIL (= (car I) (cadr I)))
      @ ) )
(de all-equal (L) # recursive
   (cond
      ((or (not L) (not (cdr L)))
         T )
      (T 
         (and
            (= (car L) (cadr L)) 
            (all-equal (cdr L)) ) ) ) )
(test
   (f8-22 (1 1 2))
   (all-equal (1 1 2)) )
(test
   (f8-22 (1 1 1 1))
   (all-equal (1 1 1 1)) )

#8.23 - ignored

#8.24
(de count-down (N)
   (cond
      ((=0 N))
      (T (cons N (count-down (dec N)))) ) )
(test
   (range 5 1)
   (count-down 5) )

#8.25 - ignored

#8.26
(de count-down0 (N)
   (cond
      ((lt0 N))
      (T (cons N (count-down0 (dec N)))) ) )
(test
   (range 5 0)
   (count-down0 5) )

#8.27
(de square-list (L)
   (cond
      ((not L))
      (T
         (cons
            (* (car L) (car L))
            (square-list (cdr L)) ) ) ) )
(test
   (mapcar '((N) (* N N)) (3 4 5 6))
   (square-list (3 4 5 6)) )

#8.28
(de my-nth (N L)
   (cond
      ((not L)) # added for faster stop
      ((=1 N) (car L))
      (T (my-nth (dec N) (cdr L))) ) )
(test
   'C
   (my-nth 3 '(A B C D E)) )

#8.29 = 8.7

#8.30 = 8.8

#8.31
(de compare-length (X Y)
   (cond
      ((and (not X) (not Y)) 'same)
      ((and X (not Y)) 'first)
      ((and Y (not X)) 'second)
      (T (compare-length (cdr X) (cdr Y))) ) )
(test
   'first
   (compare-length
      (1 2 4 5)
      (1 2 3) ) )
(test
   'same
   (compare-length
      (1 2 3)
      '(A B C) ) )
(test
   'second
   (compare-length NIL (1 2 3)) )

#8.32
(de sum-numeric-elements (L)
   (cond
      ((not L) 0)
      ((num? (car L))
         (+ @ (sum-numeric-elements (cdr L))) )
      (T (sum-numeric-elements (cdr L))) ) )
(test
   (sum num? '(3 A 3 B C 1))
   (sum-numeric-elements '(3 A 3 B C 1)) )

#8.33
# remove is delete in picolisp
# 
(de my-delete (I L)
   (cond
      ((not L))
      ((= I (car L)) (cdr L))
      (T (cons (car L) (my-delete I (cdr L)))) ) )
(test
   (delete 2 (1 2 3 4))
   (my-delete 2 (1 2 3 4)) )

#8.34
# intersection is sect in picolisp
(de my-sect (L1 L2)
   (cond
      ((not L1))
      ((member (car L1) L2)
         (cons (car @) (my-sect (cdr L1) L2)) )
      (T (my-sect (cdr L1) L2)) ) )
(test
   (sect (1 2 3 4) (2 3 4 5))
   (my-sect (1 2 3 4) (2 3 4 5)) )

#8.35
# set-difference is diff in picolisp
(de my-diff (L1 L2)
   (cond
      ((not L1))
      ((member (car L1) L2) (my-diff (cdr L1) L2))
      (T (cons (car L1) (my-diff (cdr L1) L2))) ) )
(test
   (diff (1 2 3 4 5) (2 4))
   (my-diff (1 2 3 4 5) (2 4)) )

#8.36
(de count-odd-v1 (L)
   (cond
      ((not L) 0)
      ((bit? 1 (car L))
         (+ 1 (count-odd-v1 (cdr L))) )
      (T (count-odd-v1 (cdr L))) ) )
(de count-odd-v2 (L)
   (cond
      ((not L) 0)
      (T 
         (+
            (if (bit? 1 (car L)) 1 0)
            (count-odd-v2 (cdr L)) ) ) ) )
(let L (4 5 6 7 8)
   (test
      T
      (=
         (cnt '((N) (bit? 1 N)) L)
         (count-odd-v1 L)
         (count-odd-v2 L) ) ) )

#8.37 - ignored

#8.38 
# additional Q for every NIL as atom

#8.39
(de count-atoms (L)
   (cond
      ((atom L) 1)
      (T (+ (count-atoms (car L)) (count-atoms (cdr L)))) ) )
(test
   5
   (count-atoms '(a (b) c)) )

#8.40
(de count-cons (L)
   (cond
      ((atom L) 0)
      (T (+ 1 (count-cons (car L)) (count-cons (cdr L)))) ) )
(test
   1
   (count-cons '(a)) )
(test
   2
   (count-cons '(a 2)) )
(test
   2
   (count-cons '((a))) )

#8.41
(de sum-tree (L)
   (cond
      ((num? L) @)
      ((atom L) 0)
      (T (+ (sum-tree (car L)) (sum-tree (cdr L)))) ) )
(let L '((3 B) (((100))) (3 B) (1 G))
   (test
      (sum num? (fish atom L))
      (sum-tree L) ) )

#8.42
# subst is replace in picolisp
(de my-replace (L S D)
   (cond
      ((= L S) D)
      ((atom L) L)
      (T 
         (cons 
            (my-replace (car L) S D)
            (my-replace (cdr L) S D) ) ) ) )
(test
   '(A b b A)
   (my-replace '(a b b a) 'a 'A) )
(test
   '(1 (1 two) (1 two 3) (1 two 3 4))
   (my-replace '(1 (1 2) (1 2 3) (1 2 3 4)) 2 'two) )

#8.43
(de flatten (L)
   (cond
      ((not L))
      ((atom L) (cons L))
      (T (append (flatten (car L)) (flatten (cdr L)))) ) )
(let L '((a) (((b))))
   (test
      (fish atom L)
      (flatten L) ) )

#8.44
(de tree-depth (L)
   (cond
      ((atom L) 0)
      (T 
         (+ 
            1
            (max (tree-depth (car L)) (tree-depth (cdr L))) ) ) ) )
(test
   1
   (tree-depth '(a . b)) )
(test
   5
   (tree-depth '((a b c d))) )
(test
   2
   (tree-depth '((a . b) . (c . d))) )

#8.45
(de paren-depth (L)
   (cond
      ((atom L) 0)
      (T
         (max
            (+ 1 (paren-depth (car L)))
            (paren-depth (cdr L)) ) ) ) )
(test
   1
   (paren-depth '(a b c)) )
(test
   3
   (paren-depth '(A B ((C) D) E)) ) 
      
#8.46
(de count-up (N)
   (cond
      ((=0 N))
      (T (append (count-up (dec N)) (cons N))) ) )
(test
   (1 2 3 4)
   (count-up 4) )

#8.47
# and is beautiful
(de make-loaf (N)
   (and
      (gt0 N)
      (cons 'X (make-loaf (dec N))) ) )
(test
   '(X X X X)
   (make-loaf 4) )

#8.48
(de bury (S N)
   (if (=0 N)
      S
      (cons (bury S (dec N))) ) )
(test
   '(((Mike)))
   (bury 'Mike 3) )

#8.49
(de pairings (L1 L2)
   (and
      L1
      (cons
         (list (car L1) (car L2))
         (pairings (cdr L1) (cdr L2)) ) ) )
(test
   (mapcar list '(A B C) (1 2 3))
   (pairings '(A B C) (1 2 3)) )

#8.50
(de sublists (L)
   (and L (cons L (sublists (cdr L)))) )
(test
   (maplist prog '(A B C))
   (sublists '(A B C)) )

#8.51
# no helper, picolisp is pure dynamic
(de my-reverse (L R)
   (cond
      ((not L) R)
      (T (my-reverse (cdr L) (cons (car L) R))) ) )
(test
   (flip (1 2 3))
   (my-reverse (1 2 3)) )

#8.52
# no helper, anonymous recursion now
(de my-union (L1 L2)
   (append
      L1
      (recur (L2)
         (cond
            ((not L2))
            ((member (car L2) L1) (recurse (cdr L2)))
            (T (cons (car L2) (recurse (cdr L2)))) ) ) ) )
(let (L1 (1 2 3)  L2 (1 2 3 4 5))
   (test
      (uniq (append L1 L2))
      (my-union L1 L2) ) )
         
#8.53
(de largest-even (L)
   (cond
      ((not L))
      ((bit? 1 (car L)) (largest-even (cdr L)))
      (T (max (car L) (largest-even (cdr L)))) ) )
(test # 10
   (maxi '((N) (or (bit? 1 N) N)) (range 0 10))
   (largest-even (range 0 10)) ) 

#8.54
# no helper, default!
(de huge (N C)
   (default C N)
   (cond
      ((=0 C) 1)
      (T (* N (huge N (dec C)))) ) )
# anonymous recursion
(de huge-anon (N)
   (let C N
      (recur (C)
         (if (=0 C) 
            1
            (* N (recurse (dec C))) ) ) ) )
(let N 4
   (test
      T
      (=
         (** N N)
         (apply * (need N N))
         (huge N)
         (huge-anon N) ) ) )

#8.55 - ignored

#8.56
(de every-other (L)
   (cond
      ((not L))
      (T (cons (car L) (every-other (cddr L)))) ) )
(let L '(A B C D E F G)
   (test
      (make
         (for (I L I (cddr I))
            (link (car I)) ) ) 
      (every-other L) ) )
     
#8.57
(de half (N)
   (/ 
      (+ (if (bit? 1 N) 1 0) N)
      2 ) )
(de left-half (L Len)
   (default Len (half (length L)))
   (and
      (gt0 Len)
      (cons (car L) (left-half (cdr L) (dec Len))) ) )
(test
   '(A B C)
   (left-half '(A B C D E)) )
(test
   (1 2 3 4)
   (left-half (range 1 8)) )

#8.58
(de merge-list (L1 L2)
   (cond
      ((not L1) L2)
      ((not L2) L1)
      ((> (car L1) (car L2))
         (cons (car L2) (merge-list L1 (cdr L2))) )
      (T (cons (car L1) (merge-list (cdr L1) L2))) ) )
(test
   (1 2 2 3 5 6 8 9 10 12 13)
   (merge-list
      (1 2 6 8 10 12)
      (2 3 5 9 13) ) )

#8.59 - ignored

#8.60 - non-recursive freedom. (i) - ignored
(setq *FAMILY
   '((colin NIL NIL)
      (deirdre NIL NIL)
      (arthur NIL NIL)
      (kate NIL NIL)
      (frank NIL NIL)
      (linda NIL NIL)
      (suzanne colin deirdre)
      (bruce arthur kate)
      (charles arthur kate)
      (david arthur kate)
      (ellen arthur kate)
      (george frank linda)
      (hillary frank linda)
      (andre NIL NIL)
      (tamara bruce suzanne)
      (vincent bruce suzanne)
      (wanda NIL NIL)
      (ivan george ellen)
      (julie george ellen)
      (marie george ellen)
      (nigel andre hillary)
      (frederick NIL tamara)
      (zelda vincent wanda)
      (joshua ivan wanda)
      (quentin NIL NIL)
      (robert quentin julie)
      (olivia nigel marie)
      (peter nigel marie)
      (erica NIL NIL)
      (yvette robert zelda)
      (diane peter erica) ) )
(de father (X)
   (cadr (assoc X *FAMILY)) )
(de mother (X)
   (caddr (assoc X *FAMILY)) )
(de parents (X)
   (conc
      (and (father X) (cons @))
      (and (mother X) (cons @)) ) )
(de children (X)
   (extract
      '((L)
         (and
            (or (= X (cadr L)) (= X (caddr L)))
            (car L) ) )
      *FAMILY) )
(de siblings (X)
   (delete
      X
      (uniq
         (conc
            (children (father X)) 
            (children (mother X)) ) ) ) )
(de mapunion (F L)
   (uniq (mapcan F L)) )
(de grandparents (X)
   (mapunion parents (parents X)) )
(de cousins (X)
   (mapunion
      children
      (mapunion
         siblings
         (parents X) ) ) )
(de descended-from (P1 P2)
   (cond
      ((not P1))
      ((member P2 (parents P1)) T)
      (T
         (or
            (descended-from (father P1) P2)
            (descended-from (mother P1) P2) ) ) ) )
(de ancestors (X)
   (and
      X
      (my-union
         (parents X)
         (my-union (ancestors (father X)) (ancestors (mother X))) ) ) )
(de generation-gap (X Y N)
   (default N 0)
   (cond
      ((not X))
      ((= X Y) N)
      (T 
         (or
            (generation-gap (father X) Y (inc N))
            (generation-gap (mother X) Y (inc N)) ) ) ) )
(test
   1
   (generation-gap 'suzanne 'colin) )
(test
   3
   (generation-gap 'frederick 'colin) )
(test
   NIL
   (generation-gap 'frederick 'linda) )
(test
   '(george ellen frank linda arthur kate)
   (ancestors 'marie) )
(test
   T
   (descended-from 'tamara 'arthur) )
(test
   NIL
   (descended-from 'tamara 'linda) )
(test
   '(nigel tamara vincent)
   (cousins 'julie) )
(test
   '(arthur kate colin deirdre)
   (grandparents 'vincent) )
(test
   '(charles david ellen)
   (siblings 'bruce) )
(test
   '(joshua)
   (siblings 'zelda) )
(test
   '(bruce charles david ellen)
   (children 'arthur) )
(test
   'colin
   (father 'suzanne) )
(test
   'deirdre
   (mother 'suzanne) )
(test
   '(colin deirdre)
   (parents 'suzanne) )
(test
   '(tamara)
   (parents 'frederick) )

