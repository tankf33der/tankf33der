(setq *ALPHA '`(chop "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"))

(de keys (Lst)
   (let (R NIL  N NIL  Q NIL)
      (for L Lst
         (case L
            (("\"" "'") (onOff Q))
            ("."
               (if Q
                  (push 'N L)
                  (queue 'R (pack (reverse N)))
                  (off N) ) )
            (T
               (if Q
                  (push 'N L)
                  (when (member L *ALPHA)
                     (push 'N L)
                  )
               )
            )
         )
      )
      (queue 'R (pack (reverse N)))
      R
   )
)

(in "data/spec/keys.dat"
   (until (eof)
      (println (keys (till "=")))
      (line)
   )
)
(msg 'ok)
(bye)
