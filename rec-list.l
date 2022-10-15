# https://www.covingtoninnovations.com/mc/LispNotes/RecursiveListProcessingAlgorithmsInLisp.pdf
(setq L1 '(1 2))
(setq L2 '(1 "(" 2 3 ")"))
(setq L3 '(1 2 "(" 3 4 ")" 5))

(de mike22 (L)
   (ifn L
      NIL
      (if (num? (car L))
         (cons (car L) (mike22 (cdr L)))
         (mike22 (cdr L))
      )
   )
)

(de mike (L)
   (cond
      ((or (= ")" (car L)) (not L)))
      ((num? (car L)) (cons (car L) (mike (cdr L))))
      ((= "(" (car L)) (list (mike (cdr L))))
   )
)


# (println 'fin (mike L1))
# (println 'fin (mike L2))
(trace 'mike)
(println 'fin (mike L3))

(msg 'ok)
(bye)
