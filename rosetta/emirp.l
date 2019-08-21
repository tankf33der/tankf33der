(de prime? (N)
   (and
      (bit? 1 N)
      (let S (sqrt N)
         (for (D 3  T  (+ D 2))
            (T (> D S) N)
            (T (=0 (% N D)) NIL) ) ) ) )
(de palindr? (A)
   (and
      (<>
         (setq A (chop A)) 
         (setq @@ (reverse A)) )
      (format @@) ) )
(de emirp? (N)
   (and (palindr? N) (prime? @) (prime? N)) )
(de take1 (N)
   (let I 11
      (make
         (for (X 1 (>= 20 X))
            (and
               (emirp? (inc 'I 2)) 
               (link @)
               (inc 'X) ) ) ) ) )
(de take2 (NIL)
   (make
      (for (I 7701 (> 8000 I) (+ I 2))
         (and (emirp? I) (link @)) ) ) )
(de take3 (NIL)
   (let I 11
      (for (X 1 (>= 10000 X))
         (and (emirp? (inc 'I 2)) (inc 'X)) )
      I ) )

(println (take1 20))
(println (take2))
(println (take3))

#{
(test
   (13 17 31 37 71 73 79 97 107 113 149 157 167 179 199 311 337 347 359 389)
   (take1 20) )
(test
   (7717 7757 7817 7841 7867 7879 7901 7927 7949 7951 7963)
   (take2) )
(test 948349 (take3))
}#

(msg 'ok)
(bye)

