#{
(let P '(S (+ - .) (10 11 12 .))
   (do 10
      (println
         (cons
            (pop (cdr P))
            (pop (cddr P)) ) ) ) )

(let P '((1 2) (3 4))
   (for (L P L)
      (inc (car L) 100)
      (dec (cdar L))
      (pop 'L) )
   (println 'P P) )
}#

(let P '((Z (1 2) (30 40)) (X (10 20) (100 200)))
   (for (Lst P Lst)
      (for (L (cdar Lst) L)
         (inc (car L) 100)
         (dec (cdar L))
         (pop 'L) )
      (pop 'Lst) )
   (println 'P P)
)

(bye)
