#cat access_log.2014.06.16 | cut -f1 -d" " | sort | uniq -d

(let L NIL
   (in "secure.txt"
      (until (eof)
         (when (line)
            (push1 'L (car (split @ " ")))) ) )
   (println (length L) L) )
(bye)
