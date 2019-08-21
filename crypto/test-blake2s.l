(load "blake2s.l")

(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(use (D K R)
   (in "tests/blake2s-kat.txt"
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
            (test (hex2L (line)) (blake2s D K)) ) ) ) )
(msg 'OK-test-blake2s)
