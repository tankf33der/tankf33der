(load "crypto/blake2.l")

(de hexify (L)
   (lowc
      (pack
         (mapcar
            '((B) (pad 2 (hex B)))
            L ) ) ) )
(let
   (C
      (blake2b 
         (need 32 0)
         (need 32 0) 
         32 )
      D (blake2b C NIL 64)
      C (blake2b C C 32)
      D (blake2b C NIL 64) )

   (println (hexify C)) 
   (println (hexify D)) )
(msg 'ok)
(bye)
