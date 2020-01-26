# --- Day 2: 1202 Program Alarm ---
(de i2-code (F)
   (make
      (in F
         (until (eof)
            (link (read))
            (char) ) ) ) )
(de i2-1 (F)
   (let Lst (i2-code F)
      (set (cdr Lst) 12  (cddr Lst) 2)
      (for (L Lst L)
         (T (> (car L) 2))
         (set
            (nth Lst (inc (get L 4)))
            ((if (=1 (car L)) '+ '*)
               (get Lst (inc (get L 2)))
               (get Lst (inc (get L 3))) ) )
         (do 4
            (++ L) ) )
      (car Lst) ) )
(test 5482655 (i2-1 "data/2.txt"))


(msg 'ok)
(bye)
