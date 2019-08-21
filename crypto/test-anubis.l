(load "anubis.l")

(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(use (I K C)
   (in "tests/anubis128-test-vectors.txt"
      (until (eof)
         (and
            (from "key=")
            (setq K (hex2L (line)))
            (from "plain=")
            (setq I (hex2L (line)))
            (from "cipher=")
            (setq C (hex2L (line)))
            #(println K I C)
            (test C (anubis128 I K)) ) ) ) )
(msg 'OK-test-anubis)
