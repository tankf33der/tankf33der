# based on test files from libsodium:
# test/default/scalarmult.c
# test/default/scalarmult_ed25519.c

`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de L2hex (Lst)
   (lowc
      (pack
         (mapcar '((B) (pad 2 (hex B))) Lst) ) ) )
(de crypto_scalarmult_base (S)
   (use P
      (native
         "libmonocypher.so"
         "crypto_x25519_public_key"
         NIL
         '(P (32 B . 32))
         (cons NIL (32) S) )
      P ) )
(de crypto_scalarmult_base_soda (S)
   (use P
      (native
         "libsodium.so"
         "crypto_scalarmult_base"
         NIL
         '(P (32 B . 32))
         (cons NIL (32) S))
      P ) )
(de crypto_scalarmult (S P)
   (use R
      (native
         "libmonocypher.so"
         "crypto_x25519"
         NIL
         '(R (32 B . 32))
         (cons NIL (32) S)
         (cons NIL (32) P) )
         R ) )
(de crypto_loworder (S P)
   (use R
      (native
         "libmonocypher.so"
         "crypto_x25519"
         'I
         '(R (32 B . 32))
         (cons NIL (32) S)
         (cons NIL (32) P) )
      R ) )
(de crypto_scalarmult_soda (S P)
   (use R
      (and
         (=0
            (native
               "libsodium.so"
               "crypto_scalarmult"
               'I
               '(R (32 B . 32))
               (cons NIL (32) S)
               (cons NIL (32) P) ) )
         R ) ) )
# soda-1K-pubkey
(setq Soda (rc "tests/soda-pubkey.rc" 'D))
(for S Soda
   (let L (need 32 0)
      (set L (car S))
      (do 1000
         (setq L (crypto_scalarmult_base L)) )
      (test L (cdr S)) ) )
# check low order only
# https://github.com/jedisct1/libsodium/blob/master/src/libsodium/crypto_scalarmult/curve25519/ref10/x25519_ref10.c#L17
# https://crypto.stackexchange.com/questions/55632/libsodium-x25519-and-ed25519-small-order-check
(setq Z (need 32 0))
(test
   Z
   (crypto_loworder (randL 32) Z) )
(set Z 1)
(test
   (need 32 0)
   (crypto_loworder (randL 32) Z) )
(test
   (need 32 0)
   (crypto_loworder
      (randL 32)
      (hex2L "e0eb7a7c3b41b8ae1656e3faf19fc46ada098deb9c32b1fd866205165f49b800") ) )
(test
   (need 32 0)
   (crypto_loworder
      (randL 32)
      (hex2L "5f9c95bca3508c24b1d0b1559c83ef5b04445cc4581c8e86d8224eddd09f1157") ) )
(test
   (need 32 0)
   (crypto_loworder
      (randL 32)
      (hex2L "ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f") ) )
(test
   (need 32 0)
   (crypto_loworder
      (randL 32)
      (hex2L "edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f") ) )
(test
   (need 32 0)
   (crypto_loworder
      (randL 32)
      (hex2L "eeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f") ) )

(setq
   AliceSK
   (hex2L "77076d0a7318a57d3c16c17251b26645df4c2f87ebc0992ab177fba51db92c2a")
   BobSK
   (hex2L "5dab087e624a8a4b79e17f8b83800ee66f3bb1292618b6fd1c2f8b27ff88e0eb")
   SmallOrder
   (hex2L "e0eb7a7c3b41b8ae1656e3faf19fc46ada098deb9c32b1fd866205165f49b800")
   AlicePK NIL
   BobPK NIL )
(test
   "8520f0098930a754748b7ddcb43ef75a0dbf3a0d26381af4eba4a98eaa9b4e6a"
   (L2hex (setq AlicePK (crypto_scalarmult_base AliceSK))) )
(test
   "de9edb7d7b7dc1b4d35b61c2ece435373f8343c85b78674dadfc7e146f882b4f"
   (L2hex (setq BobPK (crypto_scalarmult_base BobSK))) )
(test
   T
   (=
      "4a5d9d5ba4ce2de1728e3bf480350f25e07e21c947d19e3376f09b3c1e161742"
      (L2hex (crypto_scalarmult BobSK AlicePK))
      (L2hex (crypto_scalarmult AliceSK BobPK)) ) )
(test
   NIL
   (crypto_scalarmult BobSK SmallOrder) )

# Next
# scalarmult_ed25519.c
(setq
   N (randL 32)
   P (hex2L "5866666666666666666666666666666666666666666666666666666666666666")
   NonCan (hex2L "f6ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f")
   NonCanInv (hex2L "f5ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f")
   MaxCan (hex2L "e4ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f") )
(test
   NIL
   (=
      (crypto_scalarmult_base N)
      (crypto_scalarmult N P) ) )

# 1
(setq N (need 32 0))
(test
   T
   (lst? (crypto_scalarmult_base N)) )
(test
   T
   (lst? (crypto_scalarmult N P)) )
# 2
(set N 1)
(test
   T
   (lst? (crypto_scalarmult_base N)) )
(test
   T
   (lst? (crypto_scalarmult N P)) )
#(println 1 (crypto_scalarmult N NonCan))
#(println 2 (crypto_scalarmult N NonCanInv))
(test
   T
   (lst? (crypto_scalarmult N MaxCan)) )

# 3
(setq P (need 32 0))
(test NIL (crypto_scalarmult N P))
(set N 8)
(test NIL (crypto_scalarmult N P))

(test
   (crypto_scalarmult_base (range 0 31))
   (crypto_scalarmult_base_soda (range 0 31)) )
(let Prv (need 32 0)
   (for X (range 0 255)
      (map
         '((L)
            (set L X)
            (test
               (crypto_scalarmult_base Prv)
               (crypto_scalarmult_base_soda Prv) )
            (set L 0) )
         Prv ) ) )
(let
   (Sk1 (randL 32)
      Pk1 (crypto_scalarmult_base Sk1)
      Sk2 (randL 32)
      Pk2 (crypto_scalarmult_base_soda Sk2)
      Shr1 (crypto_scalarmult Sk1 Pk2)
      Shr2 (crypto_scalarmult_soda Sk2 Pk1) )
   (test Shr1 Shr2) )
(let Sk1 (need 32 0)
   (for X (range 0 255)
      (map
         '((L)
            (set L X)
            (let
               (Pk1 (crypto_scalarmult_base Sk1)
                  Sk2 (randL 32)
                  Pk2 (crypto_scalarmult_base_soda Sk2)
                  Shr1 (crypto_scalarmult Sk1 Pk2)
                  Shr2 (crypto_scalarmult_soda Sk2 Pk1) )
               (test Shr1 Shr2) )
            (set L 0) )
         Sk1 ) ) )
(msg 'ok)
(bye)
