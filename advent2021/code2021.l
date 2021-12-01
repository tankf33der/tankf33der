# --- Day 1: Sonar Sweep ---
(de read2Lst (F)
   (make
      (in F
         (while (read)
            (link @) ) ) ) )
(de c1-1 (F)
   (let C 0
      (maplist
         '((L)
            (when (> (cadr L) (car L))
               (inc 'C) ) )
         (read2Lst F) )
      C ) )
(test
   7
   (c1-1 "data/1-test.txt") )
(test
   1390
   (c1-1 "data/1.txt") )

(de c1-2 (F)
   (let (Lst (read2Lst F)  C 0  N 0)
      (setq N (apply + (head 3 Lst)))
      (for (L (cdr Lst) (cddr L) (cdr L))
         (let X (apply + (head 3 L))
            (when (> X N) (inc 'C))
            (setq N X) ) )
      C ) )
(test
   5
   (c1-2 "data/1-test.txt") )
(test
   1457
   (c1-2 "data/1.txt") )

(msg 'ok)
(bye)
