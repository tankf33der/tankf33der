#14.1
(de f14-1 (Z A Lst)
   (make
      (for I Lst
         (link (if (= I A) Z I)) ) ) )
(test
   (1 2 2)
   (f14-1 2 3 (1 2 3)) )

#14.2
(de f14-2 (A B Lst)
   (mapcan
      '((L)
         (recur (L)
            (if2 (atom L) (<= A L B)
               NIL
               (cons L)
               NIL
               (cons (mapcan recurse L)) ) ) )
      Lst ) )
(test
   '((1 2 a 8) (NIL b (u) 2))
   (f14-2 3 5 '((1 2 a 4 8) ((3) b (u) 2))) )

#14.3
(de f14-3 (N P Lst)
   (filter
      '((L)
         (and
            (= N (car L))
            (= P (cadddr L)) ) )
      Lst ) )
(test
   '((terminal samsung 17 7000))
   (f14-3
      'terminal
      7000
      (quote
         (terminal acer 15 4500)
         (terminal samsung 17 7000)
         (motherboard intel 238 2500)
         (processor intel 25 3000) ) ) )

#14.4
(de f14-4 (Lst A B)
   (head
      (inc (- B A))
      (nth Lst A) ) )
(test
   (1 2 3)
   (f14-4 '(a 1 2 3 4) 2 4) )

#14.5
(de f14-5 (A B Lst)
   (mapcan
      '((L)
         (recur (L)
            (if2 (atom L) (= L B)
               (list A B A)
               (cons L)
               NIL
               (cons (mapcan recurse L)) ) ) )
      Lst ) )
(test
   '((1 5 8 5 2) (3 (5 8 5 4)))
   (f14-5 5 8 '((1 8 2) (3 (8 4)))) )

#14.6
(de f14-6 (F N Lst)
   (make
      (while Lst
         (link (apply F (cut N 'Lst)) ) ) ) )
(test
   (5 9 13)
   (f14-6 + 2 (2 3 4 5 6 7)) )
(test
   (24 210)
   (f14-6 * 3 (2 3 4 5 6 7)) )
(test
   (24 30)
   (f14-6 * 3 (2 3 4 5 6)) )

#14.7
(de f14-7 (Lst A N)
   (mapcar
      '((I) 
         (if (= I A)
            (intern (pack I N))
            I ) )
      Lst ) )
(test
   '(ab abc12 ac abd)
   (f14-7 '(ab abc ac abd) 'abc 12) )

#14.8
(de f14-8 (A B Lst)
   (place
      (index B Lst)
      Lst
      A ) )
(test
   '(z a)
   (f14-8 'z 'a '(a a)) )

#14.9
(de f14-9 (Lst)
   (by cadr '((L) (sort L >)) Lst) )
(test
   '((c 5) (a 3) (b 2))
   (f14-9 '((a 3) (b 2) (c 5))) )

#14.10
(de f14-10 (A B Lst)
   (insert
      (inc (index A Lst))
      Lst
      B ) )
(test
   (1 2 3 100 4 5)
   (f14-10 3 100 (1 2 3 4 5)) )

#14.11
(de f14-11 (Lst S N)
   (mapcar
      '((I) (if (num? I) (* I N) S))
      Lst ) )
(test
   '(2 a 6 a 10 a)
   (f14-11 '(1 b 3 c 5 f) 'a 2) )

#14.12
(de f14-12 (A B Lst)
   (let (N -1  C 0)
      (recur (Lst N)
         (if2
            (atom Lst)
            (and
               (num? Lst)
               (or (= 1 N) (= 3 N)) )
            (inc 'C)
            NIL
            NIL
            (recurse (car Lst) (inc N))
            (and (cdr Lst) (recurse @ N)) ) )
      C ) )
(test
   2
   (f14-12 1 3 '(a (b (c (1)) d e) f ((2 (g)) 3))) )

#14.13
(de f14-13 (Lst N P)
   (let X -1
      (mapcar
         '((L)
            (recur (L)
               (if (atom L)
                  L
                  (inc 'X)
                  (mapcar
                     recurse
                     (if (= X N)
                        (remove P L)
                        L ) ) ) ) )
         Lst ) ) )
(let L '(a b (1 2 3 (1 2 3 (1 2 3))) c d)
   (test
      '(a b (1 3 (1 2 3 (1 2 3))) c d)
      (f14-13 L 0 2) )
   (test
      '(a b (1 2 3 (1 3 (1 2 3))) c d)
      (f14-13 L 1 2) )
   (test
      '(a b (1 2 3 (1 2 3 (1 3))) c d)
      (f14-13 L 2 2) )
   (test
      '(a b (1 2 3 (1 2 3 (1 2 3))) c d)
      (f14-13 L 3 2) ) )

#14.14
(de f14-14 (Lst A B)
   (let N -1
      (make
         (recur (Lst N)
            (if (atom Lst) 
               (and (<= A N B) (link Lst))
               (recurse (car Lst) (inc N))
               (and (cdr Lst) (recurse @ N)) ) ) ) ) )
(test
   '(a b c d e f)
   (f14-14 '(a b (((c d)) e f)) 0 3) )
(test
   '(c d e f)
   (f14-14 '(a b (((c d)) e f)) 1 3) )

#14.15
(de f14-15 (Lst N M)
   (do (inc (- M N))
      (setq Lst (remove N Lst)) ) )
(test
   '(a f g h)
   (f14-15 '(a b c d e f g h) 2 5) )

#14.16
(de f14-16 (Lst N F)
   (cnt
      '((L) (apply F L))
      (make
         (while (cut N 'Lst)
            (chain (subsets 2 @)) ) ) ) )
(test
   4
   (f14-16 (1 1 3 5 4 5 2 3 2 2 1 1 1) 3 =) )
         
#14.17
(de f14-17 (Lst F A)
   (mapcan
      '((I) (if (F I) (list I A) (cons I)))
      Lst ) )
(test
   '(1 2 a 3 4 a 5)
   (f14-17 (1 2 3 4 5) evenp? 'a) )

#14.18
(de f14-18 (N M Lst)
   (mapcan
      '((I)
         (let? A (get Lst I)
            (and (evenp? A) (cons A)) ) )
      (range N M) ) )
(test
   (2 4)
   (f14-18 2 7 (1 2 3 4)) )
(test
   (4 2)
   (f14-18 7 2 (1 2 3 4)) )

#14.19
(de f14-19 (A B Lst)
   (mapcar
      '((I) (if (= I B) A I))
      Lst ) )
(test
   '(a a)
   (f14-19 'a 'b '(b b)) )
(test
   '(a (b b) a)
   (f14-19 'a 'b '(b (b b) b)) )

#14.20
(de f14-20 (A B Lst)
   (place
      (index B Lst)
      Lst
      A ) )
(test
   '(a b)
   (f14-20 'a 'b '(b b)) )

#14.21
(de f14-21 (F N Lst)
   (mapcan
      '((L)
         (recur (L)
            (if2 (atom L) (F L)
               (need N L)
               (cons L)
               NIL
               (cons (mapcan recurse L)) ) ) )
      Lst ) )
(test
   '(1 -2 -2 -2 3 (4 -5 -5 -5) 6 ((-8 -8 -8)) 7)
   (f14-21 lt0 3 '(1 -2 3 (4 -5) 6 ((-8)) 7)) )

#14.22
(de f14-22 (N Lst A)
   (let N 0
      (make
         (recur (Lst N)
            (unless (atom Lst)
               (and
                  (= (car Lst) A)
                  (link (cadr Lst)) )
               (recurse (car Lst) (inc N))
               (and (cdr Lst) (recurse @ N)) ) ) ) ) )
(let L '(a 1 (b 10 (c 100)) (b 10 (c 100 (d 1000)) e))
   (test
      (1)
      (f14-22 0 L 'a) )
   (test
      (10 10)
      (f14-22 1 L 'b) )
   (test
      (100 100)
      (f14-22 2 L 'c) )
   (test
      (1000)
      (f14-22 3 L 'd) ) )

#14.23 - ignored

