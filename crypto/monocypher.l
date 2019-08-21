`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(load "blake2.l")

(de mono_blake2b (L)
   (let Len (length L)
      (use R
         (native
            "libmonocypher.so.2"
            "crypto_blake2b"
            NIL
            '(R (64 B . 64))
            (cons NIL (cons Len) L)
            Len )
         R ) ) )
(de mono_blake2b_key (L K O)
   (let (Len (length L)  Ken (length K))
      (use R
         (native
            "libmonocypher.so.2"
            "crypto_blake2b_general"
            NIL
            (cons 'R (cons (cons O 'B O)))
            O
            (cons NIL (cons Ken) K)
            Ken
            (cons NIL (cons Len) L)
            Len )
         R ) ) )
(de mblake2b_init (M)
   (native
      "libmonocypher.so.2"
      "crypto_blake2b_init"
      NIL
      M ) )
(de mblake2b_general (M O K)
   (let DK (length K)
      (native
         "libmonocypher.so.2"
         "crypto_blake2b_general_init"
         NIL
         M
         O
         (cons NIL (cons DK) K)
         DK ) ) )
(de mblake2b_update (M D)
   (let DL (length D)
      (native
         "libmonocypher.so.2"
         "crypto_blake2b_update"
         NIL
         M
         (cons NIL (cons DL) D)
         DL ) ) )
(de mblake2b_fin (M O)
   (default O 64)
   (use R
      (native
         "libmonocypher.so.2"
         "crypto_blake2b_final"
         NIL
         M
         (cons 'R (cons (cons O 'B O))) )
      R ) )
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(for X 256
   (let L (randL X)
      (test (mono_blake2b L) (blake2b L NIL 64)) ) )
(for X 64
   (let (L (randL X) O (rand 1 64))
      (for Y 64
         (let K (randL Y)
            (test (mono_blake2b_key L K O) (blake2b L K O)) ) ) ) )
(setq M (native "@" "malloc" 'N 224))
(test
   (blake2b (1))
   (prog
      (mblake2b_init M)
      (mblake2b_update M (1))
      (mblake2b_fin M) ) )
(let Txt (randL 1000000)
   (test
      (blake2b Txt)
      (prog
         (mblake2b_init M)
         (for D Txt
            (mblake2b_update M (cons D)) )
         (mblake2b_fin M) ) ) )
(mblake2b_init M)
(test
   (blake2b NIL NIL)
   (mblake2b_fin M) )
(mblake2b_general M 16 (mapcar char (chop "abc")))
(test
   (blake2b NIL (mapcar char (chop "abc")) 16)
   (mblake2b_fin M 16) )
(mblake2b_general M 32 (mapcar char (chop "abc")))
(test
   (blake2b NIL (mapcar char (chop "abc")) 32)
   (mblake2b_fin M 32) )
(mblake2b_general M 64 (mapcar char (chop "abc")))
(test
   (blake2b NIL (mapcar char (chop "abc")))
   (mblake2b_fin M 64) )
(mblake2b_general M 9)
(mblake2b_update M (mapcar char (chop "abc")))
(test
   (blake2b (mapcar char (chop "abc")) NIL 9)
   (mblake2b_fin M 9) )
(mblake2b_general M 33 (mapcar char (chop "abc")))
(mblake2b_update M (mapcar char (chop "abc")))
(test
   (blake2b
      (mapcar char (chop "abc"))
      (mapcar char (chop "abc"))
      33 )
   (mblake2b_fin M 33) )
(mblake2b_general M 10 (need 1 1))
(do 512
   (mblake2b_update M (need 2 1)) )
(test
   (blake2b (need 1024 1) (need 1 1) 10)
   (mblake2b_fin M 10) )
(for O 64
   (mblake2b_general M O)
   (test
      (mblake2b_fin M O)
      (blake2b NIL NIL O) ) )
(for K 64
   (mblake2b_general M K (need K 255))
   (test
      (mblake2b_fin M K)
      (blake2b NIL (need K 255) K) ) )
(for K 64
   (mblake2b_general M K (need K 255))
   (for X K
      (mblake2b_update M (need 222 255)) )
   (test
      (mblake2b_fin M K)
      (blake2b (need (* K 222) 255) (need K 255) K) ) )
(let D (need 64 0)
   (for X (0 1 2 4 8 16 32 64 128)
      (map
         '((L)
            (set L X)
            (for O 64
               (test
                  (blake2b D D O)
                  (mono_blake2b_key D D O) ) )
            (set L 0) )
         D ) ) )
(native "@" "free" NIL M)

(msg 'ok)
(bye)

