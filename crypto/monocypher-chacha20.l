`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de randN NIL
   (rand `(>> -50 1) (dec `(>> -60 1))) )
(de mocha20_init (C K N)
   (native
      "libmonocypher.so"
      "crypto_chacha20_init"
      NIL
      C
      (cons NIL (32) K)
      (cons NIL (8) N) ) )
(de mocha20_enc (C P)
   (let (PL (length P)  R)
      (native
         "libmonocypher.so"
         "crypto_chacha20_encrypt"
         NIL
         C
         (if P (list 'R (cons PL 'B PL)) 0)
         (cons NIL (cons PL) P)
         PL )
      R ) )
# just for fun.
(de mocha20_ctr (C N)
   (native
      "libmonocypher.so"
      "crypto_chacha20_set_ctr"
      NIL
      C
      N ) )
(de chacha20_enc (K N P Ctr)
   (let (PL (length P)  R)
      (native
         "libsodium.so"
         "crypto_stream_chacha20_xor_ic"
         NIL
         (if P (list 'R (cons PL 'B PL)) 0)
         (cons NIL (cons PL) P)
         PL
         (cons NIL (8) N)
         Ctr
         (cons NIL (32) K) )
      R ) )
(setq
   M (native "@" "malloc" 'N 136) )
(let
   (K (randL 32)
      N (randL 8)
      Txt (randL 8)
      Ctr (randN) )
   (mocha20_init M K N)
   (mocha20_ctr M Ctr) 
   (test
      (mocha20_enc M Txt)
      (chacha20_enc K N Txt Ctr) ) )
(let
   (K (randL 32)
      N (randL 8)
      Txt (need 1024 0)
      Ctr (randN) )
   (for X (1 2 4 8 16 32 64 128)
      (map
         '((L)
            (set L X)
            (mocha20_init M K N)
            (mocha20_ctr M Ctr)
            (test
               (mocha20_enc M Txt)
               (chacha20_enc K N Txt Ctr) )
            (set L 0) )
         Txt ) ) )
(let
   (K (randL 32)
      N (randL 8)
      Txt (randL 1024)
      Ctr (randN) )
   (map
      '((L)
         (let N (car L)
            (set L 0)
            (mocha20_init M K N)
            (mocha20_ctr M Ctr)
            (test
               (mocha20_enc M Txt)
               (chacha20_enc K N Txt Ctr) )
            (set L N) ) )
      Txt ) )
(native "@" "free" NIL M)
(msg 'ok)
(bye)
