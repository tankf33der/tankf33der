(load "blake2.l")

(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
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
            (test (hex2L (line)) (blake2b D K)) ) ) ) )
(test
   "A8ADD4BDDDFD93E4877D2746E62817B116364A1FA7BC148D95090BC7333B3673F82401CF7AA2E4CB1ECD90296E3F14CB5413F8ED77BE73045B13914CDCD6A918"
   (blake2b_hex (mapcar char (chop "The quick brown fox jumps over the lazy dog")) NIL 64) ) 
(msg 'OK-test-blake2b)
