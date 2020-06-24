(load "sha512.l")
(de hex2L (H)
   (println H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de createL (Lst)
   (println Lst)
   (let Lst (split Lst "\*" "\,")
      (conc
         (need (setq @ (format (car Lst))) 0)
         (cons (hex (caddr Lst)))
         (need (abs (- @ 63)) 0) ) ) )
(use (K C)
   (in "tests/Sha-2-512.unverified.test-vectors"
      (until (eof)
         (and
            (from "string: ")
            (setq K (createL (clip (line))))
            (from "hash=")
            (setq C
               (conc
                  (hex2L (line T))
                  (hex2L (pack (clip (line))))
                  #(hex2L (pack (clip (line))))
                  #(hex2L (pack (clip (line))))
                  ) )
            #(println C)
            #(test C (sha512 K))
    ) ) )
)
(msg 'ok)
(bye)
