
(setq C (native "@" "malloc" 'N 96))
(native
   "libcrypto.so"
   "SHA1_Init"
   NIL
   C )
(native
   "libcrypto.so"
   "SHA1_Final"
   NIL
   '(R (20 B . 20))
   C )
(test
   (218 57 163 238 94 107 75 13 50 85 191 239 149 96 24 144 175 216 7 9)
   R )

(msg 'ok)
(bye)
