# Print the elements a doubly-linked list
(de 2print (DLst)
   (for (L (car DLst) L (cddr L))
      (printsp (car L)) )
   (prinl) )

# Print the elements a doubly-linked list in reverse order
(de 2printReversed (DLst)
   (for (L (cdr DLst) L (cadr L))
      (printsp (car L)) )
   (prinl) )

# Build a doubly-linked list
(de 2list @
   (let Prev NIL
      (let 
         L
            (make
               (while (args)
                  (setq Prev (chain (list (next) Prev))) ) ) 
         (cons L Prev) ) ) )
(setq *D (2list 0))
#(println *D)

# 'cons' an element to a doubly-linked list
(de 2cons (X DLst)
   (let L (car DLst)                  # Get current data list
      (set DLst (cons X NIL L))       # Prepend two new cons pairs
      (if L                           # Unless DLst was empty
         (set (cdr L) (car DLst))     # set new 'prev' link
         (con DLst (car DLst)) ) ) )  # otherwise set 'end' link
(2cons 777 *D)

(de 2tail (X DLst)
   (let L (cdr DLst)
      (con DLst (cons X L NIL))
      (if L
         (con (cdr L) (cdr DLst))
         (set DLst (cdr DLst)) ) ) )
(2tail 666 *D)
#(2print *D)

# Insert an element X at position Pos
(de 2insert (X Pos DLst)
   (let (Lst (nth (car DLst) (dec (* 2 Pos)))  New (cons X (cadr Lst) Lst))
      (if (cadr Lst)
         (con (cdr @) New) 
         (set DLst New) )
      (if (cdr Lst)
         (set @ New)
         (con DLst New) ) )
 )

(2insert 222 1 *D)
(2insert 333 1 *D)

#(2print *D)
#(2printReversed *D)

(setq *T '((0 NIL) 0 NIL))
(setq *L (car *T))

(de right NIL
   (if (cddr *L)
      (setq *L @)
      (con *T (cons 0 *L NIL))
      (con (cdr *L) (cdr *T))
      (setq *L (cdr *T)) ) )
(de left NIL
   (if (cadr *L)
      (setq *L @)
      (set *T (cons 0 NIL *L))
      (set (cdr *L) (car *T))
      (setq *L (car *T)) ) )
(de count1 NIL
   (let C 0
      (for (L (car *T) L (cddr L))
         (and (=1 (car L)) (inc 'C)) )
      C ) )

#{
(do 60
   (state '(A)
      (A
         'B
         (if (=0 (car *L))
            (prog (set *L 1) (right))
            (set *L 0)
            (left) ) )
      (B
         'A
         (if (=0 (car *L))
            (prog (set *L 1) (left))
            (set *L 1)
            (right) ) ) ) )
(test 21 (count1))
}#
(bench

(do 12134527 
   (state '(A)
      (A (if (=0 (car *L)) 'B 'C)
         (case @
            (B (set *L 1) (right))
            (T (set *L 0) (left)) ) )
      (B (if (=0 (car *L)) 'A 'C)
         (case @
            (A (set *L 1) (left))
            (T (right)) ) )
      (C (if (=0 (car *L)) 'A 'D)
         (case @
            (A (set *L 1) (right))
            (T (set *L 0) (left)) ) )
      (D (if (=0 (car *L)) 'E 'C)
         (case @
            (E (set *L 1) (left))
            (T (left)) ) )
      (E (if (=0 (car *L)) 'F 'A)
         (case @
            (F (set *L 1) (right))
            (T (right)) ) )
      (F (if (=0 (car *L)) 'A 'E)
         (case @
            (A (set *L 1) (right))
            (T (right)) ) )
   )
)
(println (count1))

)



(msg 'ok)
(bye)
