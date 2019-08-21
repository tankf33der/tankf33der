(load "jh.l")

(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(use (K C)
   (in "tests/JH256Test.txt"
      (until (eof)
         (from "Messsage: ")
         (setq K (hex2L (line T)))
         (from "Hash: ")
         (setq C (line T))
         #(println K C)
         (test C (jh256_hex K)) ) ) )
(msg 'OK-test-JH256)

