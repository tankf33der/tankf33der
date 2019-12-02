`(== 64 64)
(load "sha512.l")
(load "../rosetta/sha256.l")
(load "hmac.l")
(de mono-hmac (M K)
   (let (ML (length M)  KL (length K)  R)
      #(println 'M M 'K K 'ML ML 'KL KL)
      (native
         "libmonocypher.so"
         "crypto_hmac"
         NIL
         '(R (64 B . 64))
         (cons NIL (cons KL) K)
         KL
         (cons NIL (cons ML) M)
         ML )
      R ) )
#{
#(println (chop "Hi There"))
#(println (mapcar '((C) (hex (char C))) (chop "Hi There")))

#(println (sha256 (range 1 3)))
#(println (sha512 (mapcar char (chop "mike"))))

(msg 'pico)
(println (hmac 'sha512 (mapcar char (chop "Hi There")) (need 20 11)))

(println (hmac 'sha512 (mapcar char (chop "mike")) (mapcar char (chop "mike"))))
(msg 'next)
(println (mono-hmac (mapcar char (chop "mike")) (mapcar char (chop "mike"))))
(println (mono-hmac (mapcar char (chop "Hi There")) (need 20 11)))
}#

(let D (range 1 200)
   (println (hmac 'sha512 D D))
   (println (mono-hmac D D))
)
         
         
(msg 'ok)
(bye)
