(de anagram (F)
   (let R NIL
      (in F
         (until (eof)
            (from "^I")
            (accu 'R (read) (prog (char) (read)))
            (line) ) )
      R ) )
(bench
   (println
      (maxi cdr (anagram "/root/anagram.dat") ) ) )

(de anagram2 (F "Tr")
   (balance
      "Tr" 
      (mapcar 
         '((N) (def (format N) 0)) 
         (range 1700 2038) ) )
   (in F
      (until (eof)
         (from "\t")
         (inc (car (idx "Tr" (till "\t" T))) (read)) ) ) )
(off Tr)
(bench
   (anagram2 "/root/anagram.dat" 'Tr)
   (println
      (and
         (maxi 
            '((N) (val (car (idx 'Tr N))))
            (mapcar format (range 1700 2038)) )
         (cons @ (val (car (idx 'Tr @)))) ) ) )

(msg 'ok)
(bye)

