# https://github.com/agl/curve25519-donna/blob/master/test-curve25519.c
# https://github.com/agl/curve25519-donna/blob/master/test-noncanon.c
# https://github.com/golang/crypto/blob/master/curve25519/curve25519_test.go
`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de xor! (A B)
   (set A (x| (car A) (car B))) )
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de crypto_x25519 (S P)
   (use R
      (native
         "libmonocypher.so"
         "crypto_x25519"
         NIL
         '(R (32 B . 32))
         (cons NIL (32) S)
         (cons NIL (32) P) ) 
      R ) )
(de crypto_x25519_public_key (S)
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
(let P (conc (range 15 0) (range 0 15))
   (do 241
      (test (crypto_x25519_public_key P) (crypto_scalarmult_base_soda P))
      (map inc P) ) )
(let P (conc (range 0 15) (range 15 0))
   (do 241
      (test (crypto_x25519_public_key P) (crypto_scalarmult_base_soda P))
      (map inc P) ) )
(let P (randL 32)
   (do 10000
      (at (0 . 1000) (prin ".") (flush))
      (map
         '((L)
            (inc L 2)
            (and
               (>= (car L) 256)
               (set L 0) )
            (test
               (crypto_x25519_public_key P)
               (crypto_scalarmult_base_soda P) ) )
         P ) ) )
# tinyssh/crypto-tests/crypto_scalarmult_curve25519test.c
(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de str2L (H)
   (mapcan
      '((N)
         (and (cdr N) (cons (hex (pack N)))) )
      (split (chop H) "," "x", "{", "}", " ") ) )
(setq 
   Sk
   (make
      (in "tests/precomp.txt"
         (while (line)
            (link (hex2L @)) ) ) )
   Tst
   (make
      (in "tests/precomp_curve25519.data"
         (while (line)
            (link (str2L @)) ) ) ) )
# test_base()
(mapc
   '((A B)
      (test B (crypto_x25519_public_key A)) )
   Sk
   Tst )
# test_scalarmult()
(setq Pub (need 32 0))
(set Pub 9)
(mapc
   '((Prv)
      (set (nth Pub 32) (| (get Pub 32) 128))
      (setq Pub (crypto_x25519 Prv Pub)) )     
   Sk )
(test
   (234 44 179 133 33 247 110 115 107 108 119 150 135 5 31 74 219 127 65 131 138 154 227 120 123 191 238 40 63 97 69 3)
   Pub )
# curve25519_test.go
(setq
   S (randL 32)
   U (randL 32)
   R1 NIL
   R2 NIL )
(set (nth S 32) (& `(hex "7f") (get U 32)))
(test
   T
   (= 
      (crypto_x25519 S U)
      (prog
         (set (nth S 32) (| `(hex "80") (get U 32)))
         (crypto_x25519 S U) ) ) )
# test-noncanon.c
(setq
   P1 (conc (cons 37) (need 31 0))
   P2 (need 32 255)
   Scalar (conc (cons 1) (need 31 0)) )
(test
   NIL
   (= (crypto_x25519 Scalar P1) (crypto_x25519 Scalar P2)) )
# test-curve25519.c
(setq 
   E1 (need 32 0)
   E2 (need 32 0)
    K (need 32 0)
   R1 NIL
   R2 NIL
   R3 NIL )
(set E1 3)
(set E2 5)
(set K 9)

(do (** 10 6)
   (at (0 . 10000) (prin ".") (flush))
   (at (0 . 100000) (prin "!") (flush))
   (setq
      R 
      (crypto_x25519
         E2
         (setq R1 (crypto_x25519 E1 K)) ) 
      R3
      (crypto_x25519
         E1
         (setq R2 (crypto_x25519 E2 K)) ) )
   (test R R3)
   (map xor! E1 R2)
   (map xor! E2 R1)
   (map xor! K R3) ) 
(test 
   R3 
   (199 62 28 19 192 34 248 94 208 137 42 208 172 140 88 102 31 155 139 99 56 18 47 247 205 211 74 184 51 114 21 111) )
(msg 'ok-x25519)
(bye)
