# MUM-PRNG
#
(seed (in "/dev/urandom" (rd 8)))
(setq
   *MUM-COUNT 16
   *MUM-PRIMES NIL
   *MUM-STATE NIL )
(de mod64 (N)
   (& N `(hex "FFFFFFFFFFFFFFFF")) )
(de mum-mult (V P)
   (let R (* V P)
      (mod64 (+ R (>> 64 R))) ) )
(de mum-start (S)
   (default S 0)
   (setq 
      *MUM-STATE (apply circ (need 16 (mod64 (inc S))))
      *MUM-PRIMES
      (make
         (do 16
            (link (| (>> -32 (rand)) (rand))) ) ) ) )
(de mum-next NIL
   (when (= 16 *MUM-COUNT)
      (zero *MUM-COUNT)
      (map
         '((P S)
            (set S
               (x| (car S) (mum-mult (car S) (car P))) ) )
         *MUM-PRIMES
         *MUM-STATE ) )
   (inc '*MUM-COUNT)
   (pop '*MUM-STATE) )
