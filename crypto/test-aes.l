(load "aes.l")

(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )

(use (K P C )
   (in "tests/Rijndael-128-128.unverified.test-vectors"
      (until (eof)
         (and
            (from "Set ")
            (setq @@ (line))
            (<= 1 (format (car @@)) 4)
            (from "key=")
            (setq K (hex2L (line T)))
            (from "plain=")
            (setq P (hex2L (line T)))
            (from "cipher=")
            (setq C (line T))
            #(println K P C)
            (test C (aes P K))) ) ) )
(msg 'OK-test-aes)

