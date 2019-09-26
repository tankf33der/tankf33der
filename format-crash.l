(seed (in "/dev/urandom" (rd 8)))

(de boom (N)
   (let S (chop N)
      (format S) ) )
(do 4096
   (let
      N
      (>>
         (- (rand 50 200))
         (rand 123456789 123456789123456789) )
      (let (A1 (boom N)  B1 N)
         (println 'A A1 'B B1)
         (test A1 B1)
      )
   )
)
(msg 'ok)
(bye)
   
