#9.1
(de f9-1 (L1 L2)
   (cnt
      '((L) (= L L1))
      L2 ) )
(test
   2
   (f9-1 '(a 1) '((a 1) (a 1))) )

#9.2
(de f9-2 (L1 L2)
   (nor (diff L1 L2) (diff L2 L1)) )
(test
   T
   (f9-2 (1 1 2 3) (1 2 2 3)) )
(test
   NIL
   (f9-2 (1 1 2 3) (1 2 4 2 3)) )

#9.3
(de f9-3 (L1 L2)
   (fully
      '((X)
         (fully
            '((Y)
               (< Y X))
            L2 ) )
      L1 ) )
(test
   T
   (f9-3 (4 5 6 7) (1 2 3)) )
(test
   NIL
   (f9-3 (4 1 6 7) (1 2 3)) )

#9.4
(de f9-4 (L1 L2)
   (cond
      ((not L1) T)
      ((or
            (member (car L1) (cdr L2))
            (member (car L2) (cdr L1)) )
         NIL )
      ((f9-4 (cdr L1) (cdr L2)) T) ) )
(test
   T
   (f9-4 (1 2 3 4) (1 7 8 5)) )
(test
   NIL
   (f9-4 (1 2 3 4) (7 1 8 5)) )
(test
   NIL
   (f9-4 (1 2 3 4) (1 7 1 5)) )
(test
   (f9-4 (1 2 3 4) (2 5 6 7)) )

#9.5
(de f9-5 (L1 L2)
   (fully
      >
      (fish atom L1) 
      (fish atom L2) ) )
(test
   T
   (f9-5 '(5 6 (7) 8) '(1 2 (3) 4)) )
(test
   NIL
   (f9-5 '(5 6 (3) 8) '(1 2 (7) 4)) )

#9.6
(de f9-6 (L1 L2)
   (catch NIL 
      (map 
         '((A B)
            (or
               (= (car A) (car B))
               (not (member (car A) B)) 
               (throw) ) 
            T ) 
         L1 
         L2 ) ) )
(test
   T
   (f9-6 '(a b) '(a c)) )

#9.7
(de f9-7 (P L)
   (cond
      ((not P))
      ((= L (car P)) T)
      ((atom (car P)) (f9-7 (cdr P) L))
      (T (or (f9-7 (car P) L) (f9-7 (cdr P) L))) ) )
(test
   T
   (f9-7 '(((j k) c (r p)) (u (r (m t) (a z) d) z)) '(a z)) )
(test 
   NIL
   (f9-7 '(1 (7 7) a) (7 1 7)) )

#9.8
(de f9-8 (L1 L2)
   (cond
      ((and L1 (not L2)) 'first)
      ((and (not L1) L2) 'second)
      ((not L1) 'equal)
      (T (f9-8 (cdr L1) (cdr L2))) ) )
(test
   'second
   (f9-8 (1) (1 2)) )

#9.9
(de f9-9 (L1 L2)
   (let (L1 (fish atom L1)  L2 (fish atom L2))
      (recur (L1 L2)
         (cond
            ((and L1 (not L2)) 'first)
            ((and (not L1) L2) 'second)
            ((not L1) 'equal)
            (T (recurse (cdr L1) (cdr L2))) ) ) ) )
(test
   'second
   (f9-9 (1 2) '((1 2) 2)) )

#9.10
(de f9-10 (L1 L2)
   (if (index L1 L2)
      (cadr (nth L2 @))
      'no ) )
(test
   'd
   (f9-10 '(b c) '(a (b c) d)) )
(test
   'no
   (f9-10 '(z c) '(a (b c) d)) )

#9.11
(de f9-11 @
   (maxi
      '((L) (apply + L))
      (rest) )
   @@ )
(test
   NIL
   (f9-11) )
(test
   1 
   (f9-11 NIL (1)) )
(test
   2
   (f9-11 (1 1) (1)) )

#9.12
(de f9-12 (L1 L2)
   (find = L1 L2) )
(test
   2
   (f9-12 '(1 2) (0 2)) )

#9.13
(de f9-13 (L1 L2)
   (= (reverse L1) L2) )
(test
   T
   (f9-13 (1 2 3) (3 2 1)) )
(test
   NIL
   (f9-13 (1 2 3) (1 2 3)) )

#9.14
(de f9-14 (L1 L2)
   (maxi + L1 L2)
   @@ )
(test
   4
   (f9-14 (1 2 3) (1 1 1)) )
(test
   2
   (f9-14 (0 1) (1 1)) )

#9.15
(de f9-15 @
   (car
      (mini
         '((L) (date (cdr L)))
         (rest) ) ) )
(test
   'ann
   (f9-15 '(ann 1990 1 1) '(rob 1991 1 1)) )

#9.16 - ignored

#9.17
(de f9-17 (L1 L2)
   (cond
      ((not L1))
      ((and L1 (not L2)) T)
      (T (f9-17 (cdr L1) (cdr L2))) ) )
(test
   T
   (f9-17 '(a b) '(a)) )
   
#9.18
(de f9-18 (L1 L2)
   (sum
      '((N) (** N (cadr L2)))
      L1 ) )
(test
   14
   (f9-18 (1 2 3) (1 2)) )

#9.19
(de f9-19 (L1 L2)
   (= (head 2 L1) (head 2 L2)) )
(test
   T
   (f9-19 '(a b c) '(a b c)) )
(test
   NIL
   (f9-19 '(a c c) '(a b c)) )

#9.20
(de f9-20 (L1 L2)
   (sum
      '((L1 L2) (* L1 L2))
      L1
      L2 ) )
(test
   14
   (f9-20 (1 2 3) (1 2 3)) )

#9.21
(de f9-21 (L)
   (or (apply <= L) (apply >= L)) )
(test
   NIL
   (f9-21 (1 3 2)) )
(test
   T
   (f9-21 (1 3 3)) )
(test
   T
   (f9-21 (3 2 2)) )

