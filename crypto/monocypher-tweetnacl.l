`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
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
         "crypto_check"
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
(de tweet_keys (NIL) 
   (use (Pub  Prv)
      (native
         "libtweetb.so.0"
         "crypto_sign_ed25519_tweet_keypair"
         NIL
         '(Pub (32 B . 32))
         '(Prv (64 B . 64)) )
      Prv ) )
(de check_tweetnacl (Sig P M)
   (let (ML (length M)  S)
      (native
         "libtweet.so.0"
         "crypto_sign_ed25519_tweet_open"
         'I
         #(cons NIL (128) S)
         '(S (128 B . 128))
         NIL
         (if M (cons NIL (cons ML) M) 0)
         ML
         (cons NIL (32) P) )
      S ) ) 
# XXX, check interface first
(let 
   (Prv (randL 64)
   )

   (println (tweet_keys))

)


(msg 'ok)
(bye)

