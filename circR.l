(de circR ("Var" Lst)
   (set "Var" (cons (apply circ Lst) 0 (length Lst))) )
(de popR ("Var")
   (inc (cdr (val "Var")))
   (pop (car "Var")) )
(de resetR ("Var")
   (let "L" (cddr (val "Var"))
      (and
         (gt0 (% (cadr (val "Var")) "L"))
         (do (- "L" @)
            (pop (car "Var")) ) )
      (set (cdr (val "Var")) 0) ) )

# version from Alex
(de circA ("Var" Lst)
   (set "Var" (cons (apply circ Lst) Lst)) )
# (pop L) - next item
# (circA 'L (cdr L)) - reset

