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
(de mono_poly (M K)
   (let (ML (length M)  R NIL)
      (native
         "libmonocypher.so"
         "crypto_poly1305"
         NIL
         '(R (16 B . 16))
         (ifn M 0 (cons NIL (cons ML) M))
         ML
         (cons NIL (32) K) )
      R ) )
(de sodium_poly (M K)
   (let (ML (length M)  R NIL)
      (native
         "libsodium.so"
         "crypto_onetimeauth_poly1305"
         'I
         '(R (16 B . 16))
         (ifn M 0 (cons NIL (cons ML) M))
         ML
         (cons NIL (32) K) )
      R ) )
(de sodium_init (S K)
   (native
      "libsodium.so"
      "crypto_onetimeauth_poly1305_init"
      'I
      S
      (cons NIL (32) K) ) )
(de sodium_update (S L)
   (let Len (length L)
      (native
         "libsodium.so"
         "crypto_onetimeauth_poly1305_update"
         'I
         S
         (cons NIL (cons Len) L)
         Len ) ) )
(de sodium_fin (S)
   (let R NIL
      (native
         "libsodium.so"
         "crypto_onetimeauth_poly1305_final"
         'I
         S
         '(R (16 B . 16)) )
      R ) )
(de mono_init (M K)
   (native
      "libmonocypher.so"
      "crypto_poly1305_init"
      NIL
      M
      (cons NIL (32) K) ) )
(de mono_update (M L)
   (let Len (length L)
      (native
         "libmonocypher.so"
         "crypto_poly1305_update"
         NIL
         M
         (cons NIL (cons Len) L)
         Len ) ) )
(de mono_fin (M)
   (let R NIL
      (native
         "libmonocypher.so"
         "crypto_poly1305_final"
         NIL
         M
         '(R (16 B . 16)) )
      R ) )
(setq D (randL 32))
(test (mono_poly NIL D) (sodium_poly NIL D))
(map
   '((L)
      (let A (car L)
         (for N (range 0 255)
            (set L N)
            (test (mono_poly NIL D) (sodium_poly NIL D)) )
         (set L A) ) )
   D )
(do 128
   (let (M (randL (rand 0 128))  K (randL 32))
      (test
         (mono_poly M K)
         (sodium_poly M K) ) ) )
(setq M (native "@" "malloc" 'N 88))
(setq S (native "@" "malloc" 'N 258))
(do 128
   (let K (randL 32)
      (mono_init M K)
      (sodium_init S K)
      (do (rand 64 128)
         (let D (randL (rand 8 64))
            (mono_update M D)
            (sodium_update S D) ) )
      (test
         (mono_fin M)
         (sodium_fin S) ) ) )
(do 128
   (let (K (randL 32)  Txt (randL 12345))
      (mono_init M K)
      (sodium_init S K)
      (for D Txt
         (mono_update M (cons D))
         (sodium_update S (cons D)) )
      (test
         (mono_fin M)
         (sodium_fin S) ) ) )
(do 128
   (let K (randL 32)
      (mono_init M K)
      (sodium_init S K)
      (test
         (mono_fin M)
         (sodium_fin S) ) ) )
(let D (need 32 0)
   (for X (1 2 4 8 16 32 64 128)
      (map
         '((L)
            (set L X)
            (test
               (mono_poly D D)
               (sodium_poly D D) )
            (set L 0) )
         D ) ) )
(in "tests/golang-crypto-poly1305-vectors.go"
   (until (eof)
      (test
         (mono_poly
            (prog1 (hex2L (till ":" T)) (char))
            (prog1 (hex2L (till ":" T)) (char)) )
         (hex2L (line T)) ) ) )
(native "@" "free" NIL S)
(native "@" "free" NIL M)
  
(msg 'ok-poly1305)
(bye)

