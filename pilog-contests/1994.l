(load "common.l")


# Triplets
(be triplets (@X @Y @Z)
   (for @X 0 9)
   (for @Y 0 9)
   (for @Z 0 9)
   (^ @ (gt0 (-> @Z)))
   (different @X @Y)
   (different @X @Z)
   (different @Y @Z)
   (^ @
      (let (X (-> @X)  Y (-> @Y)  Z (-> @Z))
         (=
            (* Z (+ Y (* 10 X)))
            (* X (+ Z (* 10 Y))) ) ) ) )
(test
   (quote
      ((@X . 1) (@Y . 6) (@Z . 4)) ((@X . 1) (@Y . 9) (@Z . 5)) 
      ((@X . 2) (@Y . 6) (@Z . 5)) ((@X . 4) (@Y . 9) (@Z . 8)) ) 
   (solve '((triplets @X @Y @Z))) )


# Spiral
(be distance (@ @ 1 @J @D)
   T
   (^ @D (inc (dec (-> @J)))) ) # XXX
(be distance (@ @M @I @M @D)
   T
   (^ @D (dec (+ (-> @M) (-> @I)))) )
(be distance (@N @M @N @J @D)
   T
   (^ @D 
      (dec 
         (- 
            (+ 
               (-> @N) 
               (* 2 (-> @M) ) )
            (-> @J) ) ) ) )
(be distance (@N @M @I 1 @D)
   T
   (^ @D
      (- 
         (-
            (+
               (* 2 (-> @N))
               (* 2 (-> @M)) )            
            (-> @I) )
         2 ) ) )
(be distance (@N @M @I @J @D)
   (^ @N1 (- (-> @N) 2))
   (^ @M1 (- (-> @M) 2))
   (^ @I1 (dec (-> @I)))
   (^ @J1 (dec (-> @J)))
   (distance @N1 @M1 @I1 @J1 @D1)
   (^ @D 
      (-
         (+
            (* 2 (-> @N))
            (* 2 (-> @M))
            (-> @D1) )
         4 ) ) )
(be spiral (@N @M)
   (^ @NM (* (-> @N) (-> @M)))
   (int_width @NM @Width)
   (^ @Width1 (inc (-> @Width)))
   (for @I @N)
   (nl)
   (for @J @M)
   (distance @N @M @I @J @Distance) 
   (write_int @Distance @Width1)
   (fail) )
(be spiral (@ @))

#(? (solve 5 5)) # run to display


# Domino
# once, select, findall

(be stones (2 2))
(be stones (4 6))
(be stones (1 2))
(be stones (2 4))
(be stones (6 2))



#(msg 'ok)
#(bye)
