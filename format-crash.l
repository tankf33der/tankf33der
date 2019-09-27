(seed (in "/dev/urandom" (rd 8)))
(de boom (N)
   (let S (chop N)
      #(println 'S S)
      (format S) 
      # (format (pack S)) # always ok
      ) )
(loop
   (let
      N
      (>>
         (- (rand 100 200))
         (rand 123456789 123456789123456789) )
      (test N (boom N)) ) )
(msg 'ok)
(bye)
