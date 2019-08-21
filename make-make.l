(de mike1 (Lst R)
   (let X (tail 3 Lst)
      (make
         (do R
            (setq X
               (chain
                  (mapcar x| X (range 1 64)) ) ) ) ) ) )
(de mike2 (Lst N R)
   (let (L NIL  X2 Lst)
      (setq L
         (make
            (do N
               (println 'len (length X2) 'X2 X2)
               (link X2)
               (setq X2 (mike1 X2 R)) ) ) ) ) )
   
(println
   (mike2 (range 1 4) 2 2) )

(msg 'ok)
(bye)
