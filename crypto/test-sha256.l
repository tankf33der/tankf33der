(load "../rosetta/sha256.l")

(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de createL (Lst)
   (let Lst (split Lst "\*" "\,")
      (conc
         (need (setq @ (format (car Lst))) 0)
         (cons (hex (caddr Lst)))
         (need (abs (- @ 63)) 0) ) ) )
(use (K C)
   (in "tests/Sha-2-256.unverified.test-vectors"
      (until (eof)
         (and
            (from "string: ")
            (setq K (createL (clip (line))))
            (from "hash=")
            (setq C 
               (conc
                  (hex2L (line T))
                  (hex2L (pack (clip (line)))) ) )
            #(println K C)
            (test C (sha256 K)) ) ) )
   (for F '("tests/SHA256ShortMsg.rsp" "tests/SHA256LongMsg.rsp")
      (in F
         (until (eof)
            (and
               (from "Msg = ")
               (setq K (hex2L (line T)))
               (from "MD = ")
               (setq C (hex2L (line T)))
               (test C (sha256 K)) ) ) ) ) )
(msg 'OK-test-SHA256)

