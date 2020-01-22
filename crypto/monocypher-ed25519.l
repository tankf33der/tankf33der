`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de public_key (S)
   (use P
      (native
         "libmonocypher.so"
         "crypto_sign_public_key"
         NIL
         '(P (32 B . 32))
         (cons NIL (32) S) )
      P ) )
(de public_key_donna (S)
   (use P
      (native
         "libdonna.so.0"
         "ed25519_publickey"
         NIL
         (cons NIL (32) S)
         '(P (32 B . 32)) )
      P ) )
(de sign (S P M)
   (let (ML (length M)  Sign)
      (native
         "libmonocypher.so"
         "crypto_sign"
         NIL
         '(Sign (64 B . 64))
         (cons NIL (32) S)
         (cons NIL (32) P)
         (if M (cons NIL (cons ML) M) 0)
         ML )
      Sign ) )
(de sign_init1 (C Prv Pub)
   (native
      "libmonocypher.so"
      "crypto_sign_init_first_pass"
      NIL
      C
      (cons NIL (32) Prv)
      (cons NIL (32) Pub) ) )
(de sign_init2 (C)
   (native
      "libmonocypher.so"
      "crypto_sign_init_second_pass"
      NIL
      C ) )
(de sign_update (C M)
   (let ML (length M)
      (native
         "libmonocypher.so"
         "crypto_sign_update"
         NIL
         C
         (if M (cons NIL (cons ML) M) 0)
         ML ) ) )
(de sign_final (C)
   (let Sign NIL
      (native
         "libmonocypher.so"
         "crypto_sign_final"
         NIL
         C
         '(Sign (64 B . 64)) )
      Sign ) )
(de check (Sig P M)
   (let ML (length M)
      (native
         "libmonocypher.so"
         "crypto_ed25519_check"
         'I
         (cons NIL (64) Sig)
         (cons NIL (32) P)
         (if M (cons NIL (cons ML) M) 0)
         ML ) ) )
(de check_init (C Sig P)
   (native
      "libmonocypher.so"
      "crypto_check_init"
      NIL
      C
      (cons NIL (64) Sig)
      (cons NIL (32) P) ) )
(de check_update (C M)
   (let ML (length M)
      (native
         "libmonocypher.so"
         "crypto_check_update"
         NIL
         C
         (if M (cons NIL (cons ML) M) 0)
         ML ) ) )
(de check_final (C)
   (native
      "libmonocypher.so"
      "crypto_check_final"
      'I
      C ) )
(de check_soda (Sig P M)
   (let ML (length M)
      (native
         "libsodium.so"
         "crypto_sign_verify_detached"
         'I
         (cons NIL (64) Sig)
         (if M (cons NIL (cons ML) M) 0)
         ML
         (cons NIL (32) P) ) ) )
(de check_donna (Sig P M)
   (let ML (length M)
      (native
         "libdonna.so.0"
         "ed25519_sign_open"
         'I
         (if M (cons NIL (cons ML) M) 0)
         ML
         (cons NIL (32) P)
         (cons NIL (64) Sig) ) ) )
(de check_donnaB (Sig P M)
   (let ML (length M)
      (native
         "libdonnab.so.0"
         "ed25519_sign_open"
         'I
         (if M (cons NIL (cons ML) M) 0)
         ML
         (cons NIL (32) P)
         (cons NIL (64) Sig) ) ) )

(let Prv (randL 32)
   (println (public_key Prv))
   (println 'Prv Prv)
   (println (public_key_donna Prv))
   (println 'Prv Prv)
)
(bye)

#{
(let P (randL 32)
   (do 1000
      (at (0 . 100) (prin ".") (flush))
      (map
         '((L)
            (inc L 2)
            (and
               (>= (car L) 256)
               (set L 0) )
            (test
               (public_key P)
               (public_key_donna P) ) )
         P ) ) )
}#


#{
# donna-1K-pubkey
# LONG
(setq Donna (rc "tests/donna-pubkey.rc" 'D))
(for D Donna
   (let L (need 32 0)
      (set L (car D))
      (do 1000
         (setq L (public_key L)) )
      (test L (cdr D)) ) )
(msg 'donna)

# tinyssh/crypto-tests
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
      (in "tests/precomp_ed25519.data"
         (while (line)
            (link (str2L @)) ) ) ) )
(mapc
   '((A B)
      (test B (public_key A)) )
   Sk
   Tst )

(msg 'precomp)
}#


# XXX
(let
   (Prv (randL 32)
      Pub (public_key_donna Prv)
      Pub2 (public_key Prv)
      Sig (sign Prv Pub)
      S (native "@" "malloc" 'N 984)
      C (native "@" "malloc" 'N 952) )
   (test Pub Pub2)
   (println 'Sig Sig)
   (sign_init1 S Prv Pub)
   (sign_init2 S)
   (println (sign_final S))
(bye)



   (test
      (check Sig Pub)
      (check_donna Sig Pub) )
   (check_init C Sig Pub)
   (test 0 (check_final C))
   (native "@" "free" NIL S)
   (native "@" "free" NIL C) )
(msg 'incr-1)
(let
   (Prv (randL 32)
      Pub (public_key_donna Prv)
      Txt (randL 123456)
      Sig (sign Prv Pub Txt)
      S (native "@" "malloc" 'N 984)
      C (native "@" "malloc" 'N 952) )
   (sign_init1 S Prv Pub)
   (for D Txt
      (sign_update S (cons D)) )
   (sign_init2 S)
   (for D Txt
      (sign_update S (cons D)) )
   (test Sig (sign_final S))
   (test
      (check Sig Pub Txt)
      (check_donna Sig Pub Txt) )
   (check_init C Sig Pub)
   (for D Txt
      (check_update C (cons D)) )
   (test 0 (check_final C))
   (native "@" "free" NIL S)
   (native "@" "free" NIL C) )

(msg 'incr-2)
(bye)


# check low order only
# https://github.com/jedisct1/libsodium/blob/master/src/libsodium/crypto_scalarmult/curve25519/ref10/x25519_ref10.c#L17
# https://crypto.stackexchange.com/questions/55632/libsodium-x25519-and-ed25519-small-order-check
(setq
   Z1 (conc (cons 1) (need 31 0))
   Z32 (need 32 0)
   Z64 (need 64 0)
   Z123 (conc (range 1 5) (need 27 0))
   L2 (hex2L "e0eb7a7c3b41b8ae1656e3faf19fc46ada098deb9c32b1fd866205165f49b800")
   L3 (hex2L "5f9c95bca3508c24b1d0b1559c83ef5b04445cc4581c8e86d8224eddd09f1157")
   L4 (hex2L "ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f")
   L5 (hex2L "edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f")
   L6 (hex2L "eeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f") )
(do 64
   (let D (randL 3)
      (test
         (check_donna Z123 Z32 D)
         (check       Z123 Z32 D) )
      (test
         (check_donna Z123 Z1 D)
         (check       Z123 Z1 D) )
      (test
         (check_donna Z123 L2 D)
         (check       Z123 L2 D) )
      (test
         (check_donna Z123 L3 D)
         (check       Z123 L3 D) )
       (test
         (check_donna Z123 L4 D)
         (check       Z123 L4 D) )
       (test
         (check_donna Z123 L5 D)
         (check       Z123 L5 D) )
       (test
         (check_donna Z123 L6 D)
         (check       Z123 L6 D) )

      # flip
      (test
         (check_donna Z123 D Z32)
         (check       Z123 D Z32) )
      (test
         (check_donna Z123 D Z1)
         (check       Z123 D Z1) )
      (test
         (check_donna Z123 D Z2)
         (check       Z123 D Z2) )
      (test
         (check_donna Z123 D Z3)
         (check       Z123 D Z3) )
       (test
         (check_donna Z123 D L4)
         (check       Z123 D L4) )
       (test
         (check_donna Z123 D L5)
         (check       Z123 D L5) )
       (test
         (check_donna Z123 D L6)
         (check       Z123 D L6
      ) )
   )
)
(msg 'boom1)
(use L
   (in "tests/sign.input"
      (until (eof)
         (setq L (mapcar hex2L (split (line) ":")))
         (test (cadr L) (public_key (car L)))
         (test
            (head 64 (cadddr L))
            (sign (car L) (cadr L) (caddr L)) )
         (test
            0
            (check (cadddr L) (cadr L) (caddr L)) ) ) ) )
# Also, i want this too:
# https://github.com/golang/crypto/blob/master/ed25519/ed25519_test.go#L162
(test
   -1
   (check
      (hex2L "7c38e026f29e14aabd059a0f2db8b0cd783040609a8be684db12f82a27774ab067654bce3832c2d76f8f6f5dafc08d9339d4eef676573336a5c51eb6f946b31d")
      (hex2L "7d4d0e7f6153a69b6242b522abbee685fda4420f8834b108c3bdae369ef549fa")
      (hex2L "54657374") ) )

(msg 'boom2)

# check mono understands brothers
# -DED25519_SHA512
(do 64
   (let
      (Prv (randL 32)
         Pub (public_key_donna Prv)
         Sig (sign Prv Pub Prv) )
      (test
         T
         (=
            (check Sig Pub Prv)
            (check_soda Sig Pub Prv)
            (check_donna Sig Pub Prv) ) ) ) )
(setq
   Z (need 64 0)
   M (randL 3) )
(let Pub (need 32 0)
   (for X (1 2 4 8 16 32 64 128)
      (map
         '((L)
            (set L X)
            (test
               (check Z Pub M)
               (check_donna Z Pub M) )
            (set L 0) )
         Pub ) ) )

(msg 'boom3)

# you are ill.
(do 64
   (let Pub (randL 32)
      (test
         (check Z Pub Pub)
         (check_donna Z Pub Pub) ) ) )
(do 64
   (let Pub (randL 32)
      (test
         (check Pub Pub Pub)
         (check_donna Pub Pub Pub) ) ) )
(let Prv (need 32 0)
   (for X (1 2 4 8 16 32 64 128)
      (map
         '((L)
            (set L X)
            (test
               (public_key Prv)
               (public_key_donna Prv) )
            (set L 0) )
         Pub ) ) )
# Z above.
(for N (range 0 255)
   (let Pub (need 32 N)
      (for X (range 0 255)
         (map
            '((L)
               (let M (randL (rand 0 64))
                  (set L X)
                  (test
                     (check_donna Z Pub M)
                     (check Z Pub M) )
                  (set L N) ) )
            Pub ) ) ) )

(msg 'boom4)

(setq S (need 64 0))
(for A (1 2 4 8 16 32 64 128)
   (map
      '((SL)
         (set SL A)
         (let P (need 32 0)
            (for B (1 2 4 8 16 32 64 128)
               (map
                  '((PL)
                     (set PL B)
                     (let M (need 1 0)
                        (for C (1 2 4 8 16 32 64 128)
                           (set M C)
                           (test
                              (check S P M)
                              (check_donna S P M) ) ) )
                     (set PL 0) )
                  P ) ) )
         (set SL 0) )
      S ) )
(let Prv (need 32 0)
   (for X (1 2 4 8 16 32 64 128)
      (map
         '((L)
            (set L X)
            (test
               (public_key Prv)
               (public_key_donna Prv) )
            (set L 0) )
         Prv ) ) )
(setq
   Prv (randL 32)
   Pub (public_key Prv)
   Sig (sign Prv Pub (1)) )
(for A (1 2 4 8 16 32 64 128)
   (map
      '((SL)
         (let Z (car SL)
            (set SL A)
            (for B (1 2 4 8 16 32 64 128)
               (map
                  '((PL)
                     (let Z (car PL)
                        (set PL B)
                        (test
                           (check_donna Sig Pub (1))
                           (check Sig Pub (1)) )
                        (set PL Z) ) )
                  Pub ) )
            (set SL Z) ) )
      Sig ) )
(for N 32
   (let Pub (need 32 0)
      (for X (range 1 255)
         (map
            '((L)
               (set L X)
               (test
                  -1
                  (check (append Pub Pub) Pub Pub) )
               (set L 0) )
            (nth Pub N) ) ) ) )
(msg 'ok)
(bye)
