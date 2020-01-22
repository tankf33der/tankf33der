`(== 64 64)

# XXX, compile library with ed25519-sha512
# modify makefile:
# o) add -DED25519_SHA512 to CFLAGS
# o) add lib/sha512.o to lib/libmonocypher.so.2 goal
# o) make install
# done
# should be failed (aug 2018): 33, 34, 37

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
(de public_key (S)
   (use P
      (native
         "libmonocypher.so"
         "crypto_ed25519_public_key"
         NIL
         '(P (32 B . 32))
         (cons NIL (32) S) )
      P ) )
(de sign (S P M)
   (let (ML (length M)  Sign)
      (native
         "libmonocypher.so"
         "crypto_ed25519_sign"
         NIL
         '(Sign (64 B . 64))
         (cons NIL (32) S)
         (cons NIL (32) P)
         (cons NIL (cons ML) M)
         ML )
      Sign ) )
(de check (Sig P M)
   (let ML (length M)
      (native
         "libmonocypher.so"
         "crypto_ed25519_check"
         'I
         (cons NIL (64) Sig)
         (cons NIL (32) P)
         (cons NIL (cons ML) M)
         ML ) ) )
# XXX, test valid library
(test
   "2362bac514d5fad33802642e979a1e82de6eb6f1bcbf6a5b304f2bb02b9e57fe"
   (L2hex
      (public_key
         (hex2L "f2d3023b9c19e241748bc4039a7a43c595701f23675505015213a8a2a0274c1b") ) ) )
(test
   "d4fbdb52bfa726b44d1786a8c0d171c3e62ca83c9e5bbe63de0bb2483f8fd6cc1429ab72cafc41ab56af02ff8fcc43b99bfe4c7ae940f60f38ebaa9d311c4007"
   (L2hex
      (sign
         (hex2L "add4bb8103785baf9ac534258e8aaf65f5f1adb5ef5f3df19bb80ab989c4d64b")
         (hex2L "7d4d0e7f6153a69b6242b522abbee685fda4420f8834b108c3bdae369ef549fa")
         NIL ) ) )
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
         (test Pk (public_key Sk))
         (unless (= Result (setq @@ (check Sig Pk Msg)))
            (println
               C
               (L2hex Pk)
               (L2hex Sig)
               (L2hex Msg)
               Result
               @@ ) )
         (inc 'C) ) ) )
(test 145 (dec C)) # check EOF

(msg 'eddsa-OK)
