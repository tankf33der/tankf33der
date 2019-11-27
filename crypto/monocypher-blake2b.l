`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))

(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
# blake2b-IV 
(setq *D
   (hex2L "6A09E667F3BCC908BB67AE8584CAA73B3C6EF372FE94F82BA54FF53A5F1D36F1510E527FADE682D19B05688C2B3E6C1F1F83D9ABFB41BD6B5BE0CD19137E2179") )
(de mono_blake2b (L K O)
   (default O 64)
   (let (Len (length L)  Ken (length K))
      (use R
         (native
            "libmonocypher.so"
            "crypto_blake2b_general"
            NIL
            (cons 'R (cons (cons O 'B O)))
            O
            (cons NIL (cons Ken) K)
            Ken
            (cons NIL (cons Len) L)
            Len )
         R ) ) )
(de soda_blake2b (L K O)
   (let (Len (length L)  Ken (length K))
      (use R
         (native
            "libsodium.so"
            "crypto_generichash"
            NIL
            (cons 'R (cons (cons O 'B O)))
            O
            (cons NIL (cons Len) L)
            Len
            (cons NIL (cons Ken) K)
            Ken )
         R ) ) )
(test
   T
   (=
      # all L K O
      (mono_blake2b (range 1 4) (range 1 3) 3)
      (soda_blake2b (range 1 4) (range 1 3) 3) ) )
(for N (length *D)
   (for O 64
      (let L (head N *D)
         (test
            T
            (=
               (mono_blake2b L L O)
               (soda_blake2b L L O) ) ) ) ) )
(map
   '((L)
      (for O 64
         (test
            T
            (=
               (mono_blake2b L L O)
               (soda_blake2b L L O) ) ) ) )
   *D )
(for O (range 1 64)
   (for K (range 0 64)
      (for N (range 0 256)
         (let (K (randL K)  N (randL N))
            (test (mono_blake2b N K O) (soda_blake2b N K O)) ) ) ) )
(use (D K)
   (in "tests/blake2b-kat.txt"
      (until (eof)
         (and
            (from "in:")
            (char)
            (setq D (hex2L (line)))
            (from "key:")
            (char)
            (setq K (hex2L (line)))
            (from "hash:")
            (char)
            (test (hex2L (line)) (mono_blake2b D K)) ) ) ) )
(msg 'ok)
(bye)
