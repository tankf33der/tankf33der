# --- Day 2: 1202 Program Alarm ---
(de i2-code (F)
   (make
      (in F
         (until (eof)
            (link (read))
            (char) ) ) ) )
(de i2-split (Lst)
   (make
      (while Lst
         (if (= 99 (car Lst))
            (println (cut 1 'Lst))
            (println (cut 4 'Lst)) ) ) ) )

(setq L (i2-code "data/2-test-1.txt"))
(i2-split L)

(msg 'ok)
(bye)
