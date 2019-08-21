(seed (in "/dev/urandom" (rd 8)))

(de setme ("L" R)
   (map
      '((L) (inc L 100))
      "L" ) )


(setq L (range 1 16))
(println 'L L)
(do 2
   (setme (nth L 10)) )
(println 'L L)


(setq L (range 1 16))
(de mike (L)
   (let
      (Tr NIL
         B
         (make
            (for (I . X) L
               (link (cons (dec I) X)) ) ) )
      (balance 'Tr B)
      (do 4
         (for I 16
            (con (lup Tr (dec I)) (rand 0 255)) ) )
      (for I 16
         (println (lup Tr (dec I))) )
      (map
         '((D S) (set D (cdr (lup Tr (car S)))))
         L
         (range 0 15) )
))

(println 'L L)
(mike L)
(println 'L L)



(msg 'ok)
(bye)
