(load "twofish.l")

(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )

(use (K P C )
   (in "tests/twofish-ECB_TBL.TXT"
      (until (eof)
         (and
            (from "KEY=")
            (setq K (hex2L (line T)))
            (from "PT=")
            (setq P (hex2L (line T)))
            (from "CT=")
            (setq C (hex2L (line T)))
            #(println K P C)
            (test C (twofish P K)) ) ) ) )
(msg 'OK-test-twofish)

