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
(de c3-worker (Lst)
   (let R NIL
      (for L Lst
         (accu 'R L 1) )
      (by cdr sort R) ) )
(de c3-1 (F)
   (let
      (Lst (apply mapcar (c3-read F) list)
         Lst (mapcar c3-worker Lst))
      (apply
         *
         (mapcar
            '((F)
               (bin
                  (pack
                     (mapcar '((L) (car (F cdr L))) Lst) ) ) )
            '(maxi mini) ) ) ) )
(test
   198
   (c3-1 "data/3-test.txt") )
(test
   4001724
   (c3-1 "data/3.txt") )

(de c3-get (I)
   (make
      (for A (length Lst)
         (link (get Lst A I)) ) ) )
(de c3-filter (Lst I Num)
   (filter
      '((L) (= Num (get L I)))
      Lst ) )
(de c3-2 (File Fun)
   (let Lst (c3-read File)
      (println 'Lst Lst)
      # (for I (length (car Lst))
      (for I 5
         (println 'I I)
         (let (L (c3-get I)  L (c3-worker L))
            (println 'L L (car (Fun cdr L)))
            (setq Lst (c3-filter Lst I (car (Fun cdr L))))
            (println 'Lst Lst)
         )
      )
   )
)
(c3-2 "data/3-test.txt" 'maxi)

(msg 'ok)
(bye)
