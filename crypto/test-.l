(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(let C NIL
   (do 64
      (setq C
         (hex2L (pack (pack (pack (need 64 255))))) ) ) )
(msg 'ok)
(bye)
