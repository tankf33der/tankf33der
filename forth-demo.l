(setq *CODE
   (quote
      (+ (push 'S (+ (++ S) (++ S))))
      (-
         (let @@ (++ S)
            (push 'S (- (++ S) @@)) ) )
      (drop (++ S))
      (dup (push 'S (car S))) ) )
(setq *USER
   (quote
      (dec (1 inc 1 - -))
      (inc (1 dup drop +)) ) )
(de inner (A)
   (cond
      ((not A))
      ((num? A) (push 'S A))
      ((setq @@ (assoc A *CODE)) (run (cdr @@)))
      ((setq @@ (assoc A *USER)) (inner (cdr @@)))
      (T (inner (car A)) (inner (cdr A))) ) )
(de outter (A)
   (let S NIL
      (for I A
         (inner I) )
      S ) )
# TOS is left most
(test (3 2 1) (outter (1 2 3)))
(test (1) (outter '(1 dup drop)))
(test (777 776) (outter '(776 dup inc)))
(test (100) (outter (100 dec inc)))

(msg 'ok)
(bye)
