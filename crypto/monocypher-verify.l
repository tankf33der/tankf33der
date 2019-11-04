`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de verify16 (A B)
   (native
      "libmonocypher.so"
      "crypto_verify16"
      'I
      (cons NIL (16) A)
      (cons NIL (16) B) ) )
(de sodium-verify16 (A B)
   (native
      "libsodium.so"
      "sodium_memcmp"
      'I
      (cons NIL (16) A)
      (cons NIL (16) B)
      16 ) )
(de verify64 (A B)
   (native
      "libmonocypher.so"
      "crypto_verify64"
      'I
      (cons NIL (64) A)
      (cons NIL (64) B) ) )
(de sodium-verify64 (A B)
   (native
      "libsodium.so"
      "sodium_memcmp"
      'I
      (cons NIL (64) A)
      (cons NIL (64) B)
      64 ) )
(for (N 0 (>= 255 N) (inc N))
   (let
      (A (need 64 N)
         B (copy A)
         D (need 64 0)
         Z (randL 64)
         Z1 (copy Z)
         A16 (randL 16)
         B16 (randL 16)
         C16 (conc (need 8 0) (randL 8)) )
      (test 
         (= -1 (verify16 C16 (reverse C16)))
         (= -1 (verify16 (reverse C16) C16)) )
      (test 
         (= -1 (sodium-verify16 C16 (reverse C16)))
         (= -1 (sodium-verify16 (reverse C16) C16)) )
      (test
         (= -1 (verify16 A16 (reverse A16))) 
         (= -1 (verify16 A16 B16)) )
      (test
         (= -1 (sodium-verify16 A16 (reverse A16))) 
         (= -1 (sodium-verify16 A16 B16)) )
      (test
         (=0 (verify64 A B))
         (=0 (verify64 Z (copy Z))) ) 
      (test
         (=0 (sodium-verify64 A B))
         (=0 (sodium-verify64 Z (copy Z))) )
      (test -1 (verify64 (copy Z) (prog (dec Z) Z)))
      (inc Z)
      (test -1 (sodium-verify64 (copy Z) (prog (dec Z) Z)))
      (inc Z)
      (for X (1 2 4 8 16 32 64 128)
         (map
            '((L)
               (set L X)
               (test -1 (verify64 D A))
               (test -1 (sodium-verify64 D A))
               (set L 0) )
            D ) )
      (map
         '((L)
            (inc L)
            (test -1 (verify64 A B))
            (test -1 (sodium-verify64 A B))
            (dec L)
            (dec L)
            (test -1 (verify64 A B))
            (test -1 (sodium-verify64 A B))
            (inc L) )
         A )
      (map
         '((L)
            (let N (car L)
               (set L (inc N))
               (test -1 (verify64 Z Z1))
               (test -1 (sodium-verify64 Z Z1))
               (set L N) ) )
         Z ) ) )
(msg 'ok-verify)
(bye)`
