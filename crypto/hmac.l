# 64 -> 144 for SHA3-224
# 128 sha512
# you must tune blocksize
(de hmac ("Fun" Msg Key)
   (let (Msg (copy Msg)  Key (copy Key))
      (and
         (> (length Key) 64)
         (setq Key ("Fun" Key)) )
      (setq Key (need -64 Key 0))
      ("Fun"
         (conc
            (mapcar x| (need 64 `(hex "5C")) Key)
            ("Fun" (conc (mapcar x| (need 64 `(hex "36")) Key) Msg)) ) ) ) )

