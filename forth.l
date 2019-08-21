(setq *CODE
   (quote
      (+ (push 'S (+ (++ S) (++ S))))
      (- (let @@ (++ S)
            (push 'S (- (++ S) @@)) ) )
      (* (push 'S (* (++ S) (++ S))))
      (drop (++ S))
      (swap (xchg S (cdr S)))
      (dup (push 'S (car S)))
      (over (push 'S (cadr S)))
      (:
         (push 'U
            (list
               (fword)
               (make
                  (until (= ";" (setq @@ (fword)))
                     (link @@) ) ) ) ) ) ) )
(de fword ()
   (and
      (loop
         (T (eof))
         (T
            (lst?
               (case (peek)
                  ("(" (till ")") (char))
                  ("\\" (line T))
                  (" " (skip))
                  ("^J" (char))
                  (T (setq @@ (till " ^J"))) ) )
            @@ ) )
      (setq @@ @)
      ((if (fully format @@) format intern) (pack @@)) ) )
(de feval (A)
   (cond
      ((not A))
      ((num? A) (push 'S A))
      ((setq @@ (assoc A *CODE)) (run (cdr @@)))
      ((setq @@ (assoc A U)) (feval (cdr @@)))
      (T (feval (car A)) (feval (cdr A))) ) ) 
(de frun (F)
   (let (S NIL U)
      (in F (while (setq @@ (fword)) (feval @@)))
      S ) )

(test (922) (frun "exercism-io/demo0.f"))
(test (20) (frun "exercism-io/demo1.f"))

(msg 'OK-forth)

