`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(load "blake2b-nokey.l")
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de mono_blake2b (L O)
   (let Len (length L)  
      (use R
         (native
            "libmonocypher.so"
            "crypto_blake2b_general"
            NIL
            (cons 'R (cons (cons O 'B O)))
            O
            0
            0
            (cons NIL (cons Len) L)
            Len )
         R ) ) )
(for (N 0 (> 1024 N) (inc N))
   (for O 64
      (let L (randL N)
         (test
            (mono_blake2b L O)
            (blake2b L O) ) ) ) ) 
(msg 'ok)
(bye)
