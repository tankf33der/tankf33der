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
   (let Big (| (rand 0 14) (>> -56 (rand 0 30)) (>> -100 (rand 0 14)))
      (when (rand T)
         (setq Big (| Big `(hex "1FFFFFF0FFFFFF8"))) )
      (do (rand 0 4)
         (let Dig (| (rand 0 14) (>> -60 (rand 0 30)) (>> -120 (rand 0 17)))
            (when (rand T)
               (setq Dig (| Dig `(hex "1FFFFFFC3FFFFFF8"))) )
            (setq Big (| Dig (>> -128 Big))) ) )
      (if (rand T) Big (- Big)) ) )
(de rand32 NIL
   (make
      (do 32
         (link (rand 0 255)) ) ) )
(de bigint (L)
   (apply
      |
      (mapcar
         >>
         (-248 -240 -232 -224 -216 -208 -200 -192 -184 -176 -168 -160 -152 -144 -136 -128 -120 -112 -104 -96 -88 -80 -72 -64 -56 -48 -40 -32 -24 -16 -8 0)
         (rand32) ) ) )
(de test2 (S N1 N2)
   (let (N (read)  X (eval (list S N1 N2)))
      (unless (= N X)
         (prinl "^J" N ": (" S " " N1 " " N2 ") -> " X)
         (bye) ) ) )
(de cmp2 (S N1 N2)
   (let (N (read)  X (if (eval (list S N1 N2)) 'true 'false))
      (unless (= N X)
         (prinl "^J" N ": (" S " " N1 " " N2 ") -> " X)
         (bye) ) ) )
(de bits (N1)
   (let (N (read)  X (length (bin N1)))
      (unless (= N X)
         (prinl "^J" N ": bits (" S " " N1 " " N2 ") -> " X)
         (bye) ) ) )
(pipe
   (out '("./bigint")
      (do 1000000
         (setq N1 (rnd))
         (while (=0 (setq N2 (rnd))))
         (setq N3 (rand 0 1024))
         (prinl N1)
         (prinl N2)
         (prinl N3)
         (prinl N1 " + " N2)
         (prinl N1 " - " N2)
         (prinl N1 " * " N2)
         (prinl (abs N1) " % " (abs N2))
         (prinl (abs N1) " & " (abs N2))
         (prinl (abs N1) " | " (abs N2))
         (prinl N1 " > " N2)
         (prinl N1 " > " N1)
         (prinl N1 " >= " N2)
         (prinl N1 " >= " N1)
         (prinl N1 " < " N2)
         (prinl N1 " < " N1)
         (prinl N1 " <= " N2)
         (prinl N1 " <= " N1)
         (prinl (abs N2) " ! " 0)
         (prinl N1 " / " N2)
         (prinl (abs N1) " << " N3)
         (prinl (abs N1) " >> " N3)
         (at (0 . 1000) (wait 50)) ) ) 
   (do 100
      (do 10000
         (setq
            N1 (read)
            N2 (read)
            N3 (read) )
         (test2 '+ N1 N2)
         (test2 '- N1 N2)
         (test2 '* N1 N2)
         (test2 '% (abs N1) (abs N2))
         (test2 '& (abs N1) (abs N2))
         (test2 '| (abs N1) (abs N2))
         (cmp2 '> N1 N2)
         (cmp2 '> N1 N1)
         (cmp2 '>= N1 N2)
         (cmp2 '>= N1 N1)
         (cmp2 '< N1 N2)
         (cmp2 '< N1 N1)
         (cmp2 '<= N1 N2)
         (cmp2 '<= N1 N1)
         (bits (abs N2))
         (test2 '/ N1 N2)
         (test2 '>> (- N3) (abs N1))
         (test2 '>> N3 (abs N1))
      )
      (prin ".")
      (flush) )
   (prinl) )
(msg 'OK-myrrdin)
(bye)
