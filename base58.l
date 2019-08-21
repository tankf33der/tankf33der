(setq *B58Alpha 
   (chop "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz") )
(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de b58enc (Lst)
   (let
      (P 1
         Z 0
         A 
         (sum 
            '((X)
               (* X (swap 'P (>> -8 P))) )
            (reverse Lst) ) )
   (for L Lst
      (T (n0 L))
      (inc 'Z) )
   (pack
      (need Z "1")
      (make
         (while (gt0 A)
            (yoke
               (prog1
                  (get *B58Alpha (inc (% A 58)))
                  (setq A (/ A 58)) ) ) ) ) ) ) )
(test
   "DwzW1NuTy3a"
   (b58enc (mapcar char (chop "MikeMike"))) )
(test
   "AZRwdEpLkwkYCwmiaVu23E"
   (b58enc (mapcar char (chop "MikeMikeMikeMike"))) )
# https://github.com/bitcoin/bitcoin/
#    blob/master/src/test/data/base58_encode_decode.json
(test NIL (b58enc))
(test
   "2g"
   (b58enc (hex2L "61")) )
(test
   "a3gV"
   (b58enc (hex2L "626262")) )
(test
   "2cFupjhnEsSn59qHXstmK2ffpLv2"
   (b58enc (hex2L "73696d706c792061206c6f6e6720737472696e67")) )
(test
   "1NS17iag9jJgTHD1VXjvLCEnZuQ3rJDE9L"
   (b58enc (hex2L "00eb15231dfceb60925886b67d065299925915aeb172c06647")) )
(test
   "ABnLTmg"
   (b58enc (hex2L "516b6fcd0f")) )
(test
   "3SEo3LWLoPntC"
   (b58enc (hex2L "bf4f89001e670274dd")) )
(test
   "3EFU7m"
   (b58enc (hex2L "572e4794")) )
(test
   "EJDM8drfXA6uyA"
   (b58enc (hex2L "ecac89cad93923c02321")) )
(test
   "Rt5zm"
   (b58enc (hex2L "10c8511e")) )
(test
   "1111111111"
   (b58enc (hex2L "00000000000000000000")) )

(msg 'ok)
(bye)

