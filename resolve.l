(de host2 (A)
   (in (list 'host A "127.0.0.1")
      (from "pointer ")
      (till "^J" T) ) )
(let A "5.45.104."
   (for N 255
   (println N (host (pack A N))) ) )
(msg 'ok)
(bye)
