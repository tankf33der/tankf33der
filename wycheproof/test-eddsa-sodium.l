`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de L2hex (Lst)
   (lowc 
      (pack
         (mapcar '((B) (pad 2 (hex B))) Lst) ) ) )
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de check (Sig P M)
   (let ML (length M)
      (native
         "libsodium.so"
         "crypto_sign_verify_detached"
         'I
         (cons NIL (64) Sig)
         (if M (cons NIL (cons ML) M) 0)
         ML
         (cons NIL (32) P) ) ) )
# XXX, test valid library
(test
   0
   (check
      (hex2L "d80737358ede548acb173ef7e0399f83392fe8125b2ce877de7975d8b726ef5b1e76632280ee38afad12125ea44b961bf92f1178c9fa819d020869975bcbe109")
      (hex2L "7d4d0e7f6153a69b6242b522abbee685fda4420f8834b108c3bdae369ef549fa")
      (hex2L "78") ) )
(test
   -1
   (check
      (hex2L "edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7fedffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f")
      (hex2L "7d4d0e7f6153a69b6242b522abbee685fda4420f8834b108c3bdae369ef549fa")
      (hex2L "3f") ) )
# XXX, done

# Lets go
(one C)
(in "eddsa_test.csv"
   (until (eof)
      (let 
         (Pk (prog1 (hex2L (till "," T)) (char))
            Sk (prog1 (hex2L (till "," T)) (char))
            Msg (prog1 (hex2L (till "," T)) (char))
            Sig (prog1 (hex2L (till "," T)) (char))
            Result (format (line)) )
         # check pair, just in case
         (unless (= Result (setq @@ (check Sig Pk Msg)))
            (println
               C 
               (L2hex Pk)
               (L2hex Sig) 
               (L2hex Msg)
               Result
               @@ ) )
         (inc 'C) ) ) )
(test 111 (dec C)) # check EOF

(msg 'eddsa-OK)
