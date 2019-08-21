`(== 64 64)
(de mono_wipe (N)
   (use R
      (native
         "libmonocypher.so"
         "crypto_wipe"
         NIL
         M
         N )
      R ) )
(setq M (native "@" "malloc" 'N 100000))
(for (N 0 (>= 100000 N) (inc N))
   (mono_wipe N) )
(native "@" "free" NIL M)
(msg 'ok)
(bye)
