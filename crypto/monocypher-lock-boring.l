`(== 64 64)
(de hex2L (H)
   (make
      (for (L H L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de lock_aead (K N P A)
   (let 
      (AL (length A)
         PL (length P)
         Mac NIL
         CH NIL )
      (native
         "libmonocypher.so"
         "crypto_lock_aead"
         NIL
         '(Mac (16 B . 16))
         (if P  # for empty plain data
            (list 'CH (cons PL 'B PL)) 
            0 )
         (cons NIL (32) K)
         (cons NIL (12) N)
         (cons NIL (cons AL) A)
         AL
         (cons NIL (cons PL) P)
         PL )
      (conc CH Mac) ) )
(de unlock_aead (K N M A C)
   (let
      (AL (length A)
         CL (length C)
         P )
      (native
         "libmonocypher.so"
         "crypto_unlock_aead"
         'I
         (if (=0 CL)
            0
            (list 'P (cons CL 'B CL)) )
         (cons NIL (32) K)
         (cons NIL (12) N)
         (cons NIL (16) M)
         (cons NIL (cons AL) A)
         AL
         (cons NIL (cons CL) C)
         CL )
      P ) )
(in "tests/chacha20_poly1305_tests.txt"
   (until (eof)
      (use (K N P A C M)
         (from "KEY: ")
         (setq K (hex2L (line)))
         (from "NONCE: ")
         (setq N (hex2L (line)))
         (from "IN: ")
         (setq P 
            (if (= "\"" (peek))
               (prog (char) (mapcar char (till "\"")))
               (hex2L (line)) ) )
         (from "AD: ")
         (setq A
            (if (= "\"" (peek))
               (prog (char) (mapcar char (till "\"")))
               (hex2L (line)) ) )
         (from "CT: ")
         (setq C
            (if (= "\"" (peek))
               (prog (char) (mapcar char (till "\"")))
               (hex2L (line)) ) )
         (from "TAG: ")
         (setq M (hex2L (line)))
         (test
            (append C M)
            (lock_aead K N P A) )
         (test
            P
            (unlock_aead K N M A C) ) ) ) )
(msg 'ok)
(bye)
