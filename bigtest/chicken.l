(seed (in "/dev/urandom" (rd 8)))
(de rnd NIL
   (let B
      (format
         (make
            (do (rand 240 320)
               (link (rand 0 9)) ) ) )
      (if (rand T) B (- B)) ) )
(de testme @
   (let (N (read)  X (eval (rest)))
      (unless (= N X)
         (println 'FAIL 'N: N 'X: X 'rest: (rest))
         (bye) ) ) )
(de op (A B C)
   (prinl "(" A " " B " " C ")") )
(pipe
   (out '(chicken-csi)
      (do 10000
         (setq N1 (rnd))
         (while (=0 (setq N2 (rnd))))
         (prinl N1)
         (prinl N2)
         (op "+" N1 N2)
         (op "-" N1 N2)
         (op "*" N1 N2)
         (at (0 . 1000) (wait 50))
      ))
   (do 6 (line))
   (do 10
      (do 1000
         (setq N1 (read)  N2 (read))
         (testme '+ N1 N2)
         (testme '- N1 N2)
         (testme '* N1 N2)
      )
      (prin ".")
      (flush) ) )
(prinl)

(msg 'OK-chicken)
(bye)
