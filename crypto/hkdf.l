(de ceil (A B)
   (+
      (/ A B)
      (if (and (gt0 A) (n0 (% A B)))
         1
         0 ) ) )
(de hkdf (Hfun Ikm Salt Info Len)
   (let (Prk (hmac Hfun Ikm Salt)  Tr NIL  Okm)
      (setq Okm
         (make
            (for I (ceil Len (length Prk))
               (chain 
                  (setq Tr
                     (hmac Hfun (append Tr Info (cons I)) Prk) ) ) ) ) )
      (head Len Okm) ) )

