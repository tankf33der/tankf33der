#17.1
(de f17-1 (Lst K V)
   (mapcar
      '((I) (ifn (index I K) I (get V @)))
      Lst ) )
(test
   '(1 2 33 aa bb c)
   (f17-1 '(1 2 3 a b c) '(3 a b) '(33 aa bb)) )

#17.2
(de f17-2 (Lst1 Lst2 Cntr)
   (list
      (diff Lst1 Cntr)
      (diff Lst2 Cntr) ) )
(test
   '((4 3) (2 3 6))
   (f17-2 (4 5 3 8) (1 2 3 6 8) (1 5 7 8)) )

#17.3
(de f17-3 (L1 L2 L3)
   (let L1  (append (diff L1 L2) (diff L2 L1))
      (append (diff L1 L3) (diff L3 L1)) ) )
(test
   (1 2 4 6 7)
   (f17-3 (1 2 3) (3 4 5) (5 6 7)) )

#17.4
(de f17-4 (A B C)
   (list
      (cadr A)
      (cadr B)
      (caddr C) ) )
(test
   '(u g2 mm)
   (f17-4 '(y u i) '(g1 g2 g3) '(kk ll mm jjj)) )

#17.5
(de f17-5 (Lst A N)
   (cond
      ((not Lst))
      ((= A (car Lst))
         (cons N (f17-5 (cdr Lst) A N)) )
      ((pair (car Lst))
         (cons 
            (f17-5 (car Lst) A N)
            (f17-5 (cdr Lst) A N) ) )
      (T (cons (car Lst) (f17-5 (cdr Lst) A N))) ) )
(test
   '(a (1 2 3) ((b (((1 2 3))) d)))
   (f17-5 '(a c ((b ((c)) d))) 'c (1 2 3)) )
(test
   '(a c ((b ((c)) d)))
   (f17-5 '(a (1 2 3) ((b (((1 2 3))) d))) (1 2 3) 'c) )

#17.6
(be place ((@A . @X) @A (@B . @Y) @B))
(be place ((@ . @X) @A (@ . @Y) @B)
   (place @X @A @Y @B) )
(be f17-6 (@Name @Doing @City)
   (permute (Paris Rome Chicago) @City)
   (permute (Sing Ballet Cinema) @Doing)
   (not (place @Name Judith @City Paris))
   (not (place @Name Linda @City Rome))
   (not (place @City Paris @Doing Cinema))
   (place @City Rome @Doing Sing) 
   (not (place @Name Linda @Doing Ballet)) )
(test '(T)
   (solve
      (quote
         (f17-6
            (Iris Judith Linda) 
            (Ballet Sing Cinema) 
            (Paris Rome Chicago) ) ) ) )

#17.7
(de f17-7 (Lst K V)
   (mapcar
      '((L)
         (recur (L)
            (if2 (atom L) (index L K)
               (get V @)
               L
               NIL
               (mapcar recurse L) ) ) )
      Lst ) )
(test
   '((3 8) 3 (c (3 (3 d))))
   (f17-7 '((a b) a (c (a (a d)))) '(a b) (3 8)) )

