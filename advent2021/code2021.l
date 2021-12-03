# --- Day 1: Sonar Sweep ---
(de c1-read (F)
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
         (c1-read F) )
      C ) )
(test
   7
   (c1-1 "data/1-test.txt") )
(test
   1390
   (c1-1 "data/1.txt") )

(de c1-2 (F)
   (let (Lst (c1-read F)  C 0  N 0)
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

# --- Day 2: Dive! ---
(de c2-1 (F)
   (let (H 0  D 0)
      (in F
         (until (eof)
            (case (read)
               ("forward" (inc 'H (read)))
               ("down" (inc 'D (read)))
               ("up" (dec 'D (read))) )
            (line) ) )
      (* H D) ) )
(test
   150
   (c2-1 "data/2-test.txt") )
(test
   1427868
   (c2-1 "data/2.txt") )

(de c2-2 (F)
   (let (H 0  D 0  A 0)
      (in F
         (until (eof)
            (case (read)
               ("down" (inc 'A (read)))
               ("up" (dec 'A (read)))
               ("forward"
                  (inc 'H (setq @@ (read)))
                  (inc 'D (* A @@)) ) )
            (line) ) )
      (* H D) ) )
(test
   900
   (c2-2 "data/2-test.txt") )
(test
   1568138742
   (c2-2 "data/2.txt") )

# --- Day 3: Binary Diagnostic ---
(de c3-read (F)
   (in F
      (make
         (while (line)
            (link @) ) ) ) )
(de c3-1 (F)
   (let Lst (apply mapcar (c3-read F) list)
      (println Lst)
   )
)
(c3-1 "data/3-test.txt")

(msg 'ok)
(bye)
