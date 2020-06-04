`(== 64 64)

# List variation
(de mono-hmac (M K)
   (let (ML (length M)  KL (length K)  R)
      (native
         "libmonocypher.so"
         "crypto_hmac_sha512"
         NIL
         '(R (64 B . 64))
         (if K (cons NIL (cons KL) K) 0)
         KL
         (if M (cons NIL (cons ML) M) 0)
         ML )
      R ) )
(de h2l (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de l2hex (Lst)
   (lowc
      (pack
         (mapcar '((B) (pad 2 (hex B))) Lst) ) ) )
# $ echo -n "alex" | openssl dgst -sha512 -mac HMAC -macopt "hexkey:ef"
# (stdin)= 8d117ea9c46abe448d806cf45178c41b9617033b94585d6b688fa74314bb012665029053047494c3e2cd5f33fba939cb604af8575228f62ea67b86b3a3f961e0
(test
   "8d117ea9c46abe448d806cf45178c41b9617033b94585d6b688fa74314bb012665029053047494c3e2cd5f33fba939cb604af8575228f62ea67b86b3a3f961e0"
   (l2hex
      (mono-hmac
         (mapcar char (chop "alex"))
         (h2l "ef") ) ) )

#
# Byte implementation
(de mono-hmac-byte (M K KL)
   (let (ML (length M)  R)
      (native
         "libmonocypher.so"
         "crypto_hmac_sha512"
         NIL
         '(R (64 B . 64))
         K
         KL
         (if M (cons NIL (cons ML) M) 0)
         ML )
      R ) )


(setq *P (native "@" "malloc" 'N 1))
(byte *P (hex "ef"))
(test
   "8d117ea9c46abe448d806cf45178c41b9617033b94585d6b688fa74314bb012665029053047494c3e2cd5f33fba939cb604af8575228f62ea67b86b3a3f961e0"
   (l2hex
      (mono-hmac-byte
         (mapcar char (chop "alex"))
         *P
         1 ) ) )
(msg 'ok)
(bye)
