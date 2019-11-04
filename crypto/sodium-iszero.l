`(== 64 64)
(de iszero (Lst)
   (let Len (length Lst)
      (native
         "libsodium.so"
         "sodium_is_zero"
         'N
         (if Lst (cons NIL (cons Len) Lst) 0)
         Len ) ) )
(setq D (need 1024 0))
(for X (1 2 4 8 16 32 64 128)
   (map
      '((L)
         (set L X)
         (test 0 (iszero D))
         (set L 0) )
      D ) )
(msg 'ok)
(bye)
