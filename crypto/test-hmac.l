(load "../rosetta/md4.l")
(load "../rosetta/ripemd160.l")
(load "../rosetta/sha1.l")
(load "../rosetta/sha256.l")
(load "../md5.l")
(load "tiger.l")
(load "hmac.l")
(de h2l (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de l2h (Lst)
   (lowc
      (pack
         (mapcar '((B) (pad 2 (hex B))) Lst) ) ) )
(de s2l (Str)
   (mapcar char (chop Str)) )
(setq Tests
   (quote
      (md4 (90 . 82))
      (md5 (94 . 97))
      (tiger192 (251 . 194))
      (ripemd160 (191 . 9))
      (sha1 (227 . 61))
      (sha256 (57 . 128)) ) )
(for A Tests
   (let @@
      (hmac
         (car A)
         (65 66 67)
         (append (128) (need 63 0)) )
      (test
         T
         (and
            (= (car @@) (caadr A))
            (= (last @@) (cdadr A)) ) ) ) )

# RFC2202
(use (L)
   (setq
      L
      (hmac
         'sha1
         (mapcar char (chop "what do ya want for nothing?"))
         (mapcar char (chop "Jefe")) ) )
   (test T (and (= 239 (car L)) (= 121 (last L))))
   (setq
      L
      (hmac
         'sha1
         (mapcar char (chop "Test Using Larger Than Block-Size Key - Hash Key First"))
         (need 80 `(hex "AA")) ) )
   (test T (and (= 170 (car L)) (= 18 (last L)))) )
(msg 'OK-HMAC)

