(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(hex2L (pack (need 8 0)))
(msg 'ok)
(bye)
