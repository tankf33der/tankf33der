(load "whirlpool.l")

(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(use (K C)
   (in "tests/Whirlpool-test-vectors.txt"
      (until (eof)
         (and
            (split (line) ':)
            (setq
               I (hex2L (pop '@))
               O (hex2L (pop '@)) )
            (test O (whirlpool I)) ) ) ) )
(msg 'OK-test-Whirlpool)
