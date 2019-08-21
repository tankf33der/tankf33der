(seed (in "/dev/urandom" (rd 8)))
(de randL (A B)
   (let R NIL
      (do A
         (while (and (setq @@ (rand 1 B)) (member @@ R)))
         (push 'R @@) )
      (sort R) ) ) 
(do 6
   (println (randL 5 50) '+ (randL 2 10)) )
(bye)
