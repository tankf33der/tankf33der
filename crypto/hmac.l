# 64 -> 144 for SHA3-224
# 128 sha512
# you must tune blocksize
(de hmac ("Fun" Msg Key N)
   (default N 64)
   (let (Msg (copy Msg)  Key (copy Key))
      (and
         (> (length Key) N)
         (setq Key ("Fun" Key)) )
      (setq Key (need (- N) Key 0))
      ("Fun"
         (conc
            (mapcar x| (need N `(hex "5C")) Key)
            ("Fun" (conc (mapcar x| (need N `(hex "36")) Key) Msg)) ) ) ) )
