(de uptime (F)
   (make
      (in F
         (from "average: ")
         (do 3
            (link (till "," T))
            (char)
            (char) ) ) ) )
(test '("1.23" "4.56" "7.89") (uptime "uptime.txt"))


(setq *Mystr "09:56:51 up  6:46,  1 user,  load average: 0.81, 0.45, 0.36")
(de uptimeStr (Str)
   (mapcar
      '((L) (pack (clip L)))
      (tail 3 (split (chop Str) ":" ",") ) ) )
(test '("0.81" "0.45" "0.36") (uptimeStr *Mystr))

(msg 'ok)
(bye)
