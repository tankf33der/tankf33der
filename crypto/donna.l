`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de check_donna (Sig P M)
   (let (ML (length M) R
      (native
         "libdonna.so.0"
         "ed25519_sign_open"
         'I
         (if M (cons NIL (cons ML) M) 0)
         ML
         (cons NIL (32) P)
         (cons NIL (64) Sig) ) )
      (if (=0 R) 1 0) ) )
(de check (Sig P M)
   (let (ML (length M) R
      (native
         "libmonocypher.so"
         "crypto_check"
         'I
         (cons NIL (64) Sig)
         (cons NIL (32) P)
         (if M (cons NIL (cons ML) M) 0)
         ML ) )
      (if (=0 R) 1 0) ) )
(de check_soda (Sig P M)
   (let (ML (length M) R
      (native
         "libsodium.so"
         "crypto_sign_verify_detached"
         'I
         (cons NIL (64) Sig)
         (if M (cons NIL (cons ML) M) 0)
         ML
         (cons NIL (32) P) ) )
      (if (= -1 R) 0 1) ) )
(de check_tweetnacl (Sig P M)
   (let (ML (length M)  R
      (native
         "libtweet.so.0"
         "crypto_sign_ed25519_tweet_open"
         'I
         (cons NIL (128) S)
         #'(S (128 B . 128))
         NIL
         (if M (cons NIL (cons ML) M) 0)
         ML
         (cons NIL (32) P) )
       )
      (if (= -1 R) 0 1) ) ) 
      
(setq P (need 32 0))
(setq Z (need 64 0))
(set (nth P 32) 128)


(for N (range 130 135)
   (let M (list N)
      (println
         N
         (check Z P M)
         (check_donna Z P M) 
         (check_soda Z P M)
         (check_tweetnacl Z P M)
         )
      (test Z (need 64 0))
      #(println N (check_donna Z P M))
   )
)


(off M)
(loop
   (setq M (randL 3))
   (T (=1 (check Z P M))) )
(println Z P M)

(println 'monoo (check Z P M))
(println 'donna (check_donna Z P M))
(println 'sodiu (check_soda Z P M))
(println 'twwet (check_tweetnacl Z P M))



(msg 'ok)
(bye)
