(zero *C)
(in "4.txt"
   (until (eof)
      (let R NIL
         (and
            (loop
               (T (eol) T)
               (T (num? (accu 'R (read) 1)) (nil (line))) )
            (inc '*C)
            (char) ) ) ) )
(println 'Result: *C)

(msg 'ok)
(bye)
