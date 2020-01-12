## go build -o big.go bigint.go

(seed (in "/dev/urandom" (rd 8)))
(de rnd NIL
   (let B
      (format
         (make
            (do (rand 20000 32000)
               (link (rand 0 9)) ) ) )
      (if (rand T) B (- B)) ) )
(de test1 (S N1)
   (let (N (read)  X (eval (list S N1)))
      (unless (= N X)
         (prinl "^J" N ": (" S " " N1 ") -> " X)
         (bye) ) ) )
(de test2 (S N1 N2)
   (let (N (read)  X (eval (list S N1 N2)))
      (unless (= N X)
         (prinl "^J" N ": (" S " " N1 " " N2 ") -> " X)
         (bye) ) ) )
(pipe
   (out '("./bigint")
      (do 1000
         (setq N1 (rnd))
         (while (=0 (setq N2 (rnd))))
         (setq N3 (rand 10 1024))
         (prinl N1)
         (prinl N2)
         (prinl N3)
         (prinl N1 " + " N2)
         (prinl N1 " - " N2)
         (prinl N1 " * " N2)
         (prinl (abs N1) " % " (abs N2)) # sick and tired
         (prinl (abs N1) " / " (abs N2))
         (prinl (abs N1) " & " (abs N2))
         (prinl (abs N1) " | " (abs N2))
         (prinl (abs N1) " xor " (abs N2))
         (prinl (abs N1) " << " N3)
         (prinl (abs N1) " >> " N3)
         (at (0 . 1000) (wait 50)) ) )
   (do 10
      (do 100
         (setq
            N1 (read)
            N2 (read)
            N3 (read) )
         (test2 '+ N1 N2)
         (test2 '- N1 N2)
         (test2 '* N1 N2)
         (test2 '% (abs N1) (abs N2))
         (test2 '/ (abs N1) (abs N2))
         (test2 '& (abs N1) (abs N2))
         (test2 '| (abs N1) (abs N2))
         (test2 'x| (abs N1) (abs N2))
         (test2 '>> (- N3) (abs N1))
         (test2 '>> N3 (abs N1))
         )
      (prin ".")
      (flush) )
   (prinl) )
(msg 'OK-go)
(bye)
