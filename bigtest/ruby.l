(seed (in "/dev/urandom" (rd 8)))
#  Random patterns:
#  cnt
#     xxx0000000000000000000000000xxxx0000000000000000000000000xxx
#        (| 7 (>> -28 15) (>> -57 7))
#
#     xxx1111111111111111111111111xxxx1111111111111111111111111xxx
#        1FFFFFF0FFFFFF8
#
#
#  dig
#     xxx000000000000000000000000000xxxx000000000000000000000000000xxx
#        (| 7 (>> -30 15) (>> -61 7))
#
#     xxx111111111111111111111111111xxxx111111111111111111111111111xxx
#        1FFFFFFC3FFFFFF8

(de rnd ()
   (let Big (| (rand 0 28) (>> -56 (rand 0 60)) (>> -100 (rand 0 14)))
      (when (rand T)
         (setq Big (| Big `(hex "1FFFFFF0FFFFFF8"))) )
      (do (rand 0 4)
         (let Dig (| (rand 0 28) (>> -60 (rand 0 60)) (>> -120 (rand 0 17)))
            (when (rand T)
               (setq Dig (| Dig `(hex "1FFFFFFC3FFFFFF8"))) )
            (setq Big (| Dig (>> -128 Big))) ) )
      (if (rand T) Big (- Big)) ) )
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
   (out '(ruby bigint.rb)
      (do 1000000
         (setq N1 (rnd))
         (while (=0 (setq N2 (rnd))))
         (prinl N1)
         (prinl N2)
         (prinl N1 " + " N2)
         (prinl N1 " - " N2)
         (prinl N1 " * " N2)
         (prinl (abs N1) " % " (abs N2)) # sick and tired
         (prinl (abs N1) " / " (abs N2))
         (prinl (abs N1) " & " (abs N2))
         (prinl (abs N1) " | " (abs N2))
         (prinl (abs N1) " xor " (abs N2))
         (prinl (abs N1) " << " 1024)
         (prinl (abs N1) " >> " 64)
         (at (0 . 1000) (wait 50)) ) )
   (do 10
      (do 100000
         (setq
            N1 (read)
            N2 (read) )
         (test2 '+ N1 N2)
         (test2 '- N1 N2)
         (test2 '* N1 N2)
         (test2 '% (abs N1) (abs N2))
         (test2 '/ (abs N1) (abs N2))
         (test2 '& (abs N1) (abs N2))
         (test2 '| (abs N1) (abs N2))
         (test2 'x| (abs N1) (abs N2))
         (test2 '>> -1024 (abs N1))
         (test2 '>> 64 (abs N1))
      )
      (prin ".")
      (flush) )
   (prinl) )
(msg 'OK-ruby)
(bye)
