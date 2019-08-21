#13.1
(de f13-1 (L N M)
   (let S 0
      (for (X N (<= X M) (inc X))
         (inc 'S (get L X)) ) ) )
(test
   12
   (f13-1 (1 2 3 4 5 6 7) 3 5) )

#13.2
(de f13-2 (L A B)
   (let (A (inc (index A L))  B (index B L))
      (fully
         =0
         (head
            (- B A)
            (nth L A) ) ) ) )
(test
   T
   (f13-2 (1 2 3 0 0 7) 3 7) )
(test
   NIL
   (f13-2 (1 2 3 100 7) 3 7) )

#13.3
(de f13-3 (S L Z)
   (intern
      (pack
         (mapcar
            '((A) (if (member A L) Z A))
            (chop S) ) ) ) )
(test
   'cangratalataans
   (f13-3 "congratulations" '(a e i o u) 'a) )

#13.4
(de f13-4 (Z I L)
   (= Z (get L I)) )
(test
   T
   (f13-4 'z 3 '(a b z)) )
(test
   NIL
   (f13-4 'z 2 '(a b c)) )



