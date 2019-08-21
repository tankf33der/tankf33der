(load "keccak.l")

(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(use (K C)
   (for
      F
      (quote
         "tests/SHA3_224ShortMsg.rsp"
         "tests/SHA3_224LongMsg.rsp" )
      (in F
         (until (eof)
            (and
               (from "Msg = ")
               (setq K (hex2L (line T)))
               (from "MD = ")
               (setq C (hex2L (line T)))
               (test C (sha3-224 K)) ) ) ) )
   (for 
      F 
      (quote 
         "tests/SHAKE128ShortMsg.rsp"
         "tests/SHAKE128LongMsg.rsp" )
      (in F
         (until (eof)
            (and
               (from "Msg = ")
               (setq K (hex2L (line T)))
               (from "Output = ")
               (setq C (hex2L (line T)))
               #(println C K)
               (test C (head 16 (shake128 K))) ) ) ) )
   (for
      F
      (quote
         "tests/SHAKE256ShortMsg.rsp"
         "tests/SHAKE256LongMsg.rsp" )
      (in F
         (until (eof)
            (and
               (from "Msg = ")
               (setq K (hex2L (line T)))
               (from "Output = ")
               (setq C (hex2L (line T)))
               (test C (head 32 (shake256 K))) ) ) ) ) )
(msg 'OK-test-KECCAK)
