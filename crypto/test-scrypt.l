(load "scrypt.l")

# RFC7914
(test
   (lsthex
      (quote
         77 d6 57 62 38 65 7b 20 3b 19 ca 42 c1 8a 04 97
         f1 6b 48 44 e3 07 4a e8 df df fa 3f ed e2 14 42
         fc d0 06 9d ed 09 48 f8 32 6a 75 3a 0f c8 1f 17
         e8 d3 e0 fb 2e 0d 36 28 cf 35 e2 0c 38 d1 89 06 ) )
   (scrypt NIL NIL 16 1 1 64) )
(test
   (lsthex
      (quote
         fd ba be 1c 9d 34 72 00 78 56 e7 19 0d 01 e9 fe
         7c 6a d7 cb c8 23 78 30 e7 73 76 63 4b 37 31 62
         2e af 30 d9 2e 22 a3 88 6f f1 09 27 9d 98 30 da
         c7 27 af b9 4a 83 ee 6d 83 60 cb df a2 cc 06 40 ) )
   (scrypt 
      (mapcar char (chop "password")) 
      (mapcar char (chop "NaCl")) 
      1024 
      8 
      16 
      64 ) )
# Internet
(setq Tsts
   (quote
      (2 1 1 (57 99 68 44 203 130 16 248))
      (2 2 1 (71 190 177 69 80 11 75 220))
      (2 2 2 (207 219 195 244 201 136 226 226))
      (2 1 2 (19 202 4 248 70 252 72 242))
      (4 1 1 (119 202 101 244 177 160 12 88))
      (4 1 2 (211 218 29 154 16 102 145 34))
      (4 1 3 (49 159 117 40 91 200 124 7))
      (4 1 4 (171 141 83 154 199 58 104 186))
      (4 2 1 (128 4 235 129 121 26 150 194))
      (4 2 2 (37 17 7 1 50 25 176 65))
      (4 2 3 (17 116 217 128 108 248 76 113))
      (4 2 4 (14 14 72 145 242 128 6 36))
      (4 3 1 (192 73 184 108 43 67 47 157))
      (4 3 2 (235 113 35 187 41 227 137 107))
      (4 3 3 (246 236 36 139 114 207 118 175))
      (4 3 4 (207 36 219 118 152 61 116 175))
      (4 4 1 (78 33 133 207 26 120 211 45))
      (4 4 2 (157 221 211 142 239 130 113 124))
      (4 4 3 (36 91 87 31 123 46 158 232))
      (4 4 4 (69 10 61 169 133 113 91 70)) ) )
(let (Pwd (mapcar char (chop "Password"))  Slt (mapcar char (chop "Salt")))
   (for Ts Tsts
      (test
         (cadddr Ts)
         (scrypt Pwd Slt (car Ts) (cadr Ts) (caddr Ts) 8) ) ) )
(msg 'OK-test-scrypt)
