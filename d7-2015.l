(setq *D
   (quote
      (a lx) (lx plus lw lv) (lv 122)
      (lw minus lc 2) (lc plus 1 b)
      (b plus 1 2) ) )

(de d7 (Lst)
   (if2 (atom Lst) (num? Lst)
      Lst
      (d7 (cdr (assoc Lst *D)))
      NIL
      (case (car Lst)
         (plus
            #(+ (d7 (cadr Lst)) (d7 (caddr Lst))) )
            (apply + (mapcar d7 (cdr Lst)))
         )
         (minus
            #(- (d7 (cadr Lst)) (d7 (caddr Lst))) 
            (apply - (mapcar d7 (cdr Lst)))
         )
         #(T (d7 (car Lst))) 
         (T (apply prog (mapcar d7 Lst)))
      ) 
   ) 
)
(test 124 (d7 'a))

(setq 
   PLUS +
   MINUS -
   XOR x| )
(setq *D22
   (quote
      (a "lx") (lx PLUS lw lv) (lv 122)
      (lw MINUS lc 2) (lc PLUS 1 b)
      (b PLUS 1 z) (z XOR 12 33) ) )
(setq *F22 '(PLUS MINUS XOR))
(off *R)

(de d72 (Lst)
   (cond
      ((num? Lst) Lst)
      ((atom Lst) 
         (if (assoc Lst *R)
            (cdr @)
            (cdr (accu 'R Lst (d72 (cdr (assoc Lst *D22)))) ) ))
      (T
         (if (memq (car Lst) *F22)
            (apply (car Lst) (mapcar d72 (cdr Lst)))
            (d72 (car Lst)) ) ) ) )
(test 167 (d72 'a))
(println 'R R)
                  
                  
(msg 'ok)
(bye)
