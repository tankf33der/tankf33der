`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
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
         "crypto_ed25519_sign"
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
      "crypto_ed25519_sign_init_first_pass"
      NIL
      C
      (cons NIL (32) Prv)
      (cons NIL (32) Pub) ) )
(de sign_init2 (C)
   (native
      "libmonocypher.so.3"
      "crypto_ed25519_sign_init_second_pass"
      NIL
      C ) )
(de sign_final (C)
   (let Sign NIL
      (native
         "libmonocypher.so"
         "crypto_ed25519_sign_final"
         NIL
         C
         '(Sign (64 B . 64)) )
      Sign ) )
(let
   (Prv (randL 32)
      Pub (public_key_donna Prv)
      Pub2 (public_key Prv)
      Sig (sign Prv Pub)
      S (native "@" "malloc" 'N 984)
      C (native "@" "malloc" 'N 952) )
   (test Pub Pub2) # assert mono-SHA512 == donna-SHA512
   (sign_init1 S Prv Pub)
   (sign_init2 S)
   (test Sig (sign_final S))
)
(msg 'ok)

