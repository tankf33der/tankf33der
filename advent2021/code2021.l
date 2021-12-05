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
      Lst (mapcar c3-worker (apply mapcar (c3-read F) list))
      (apply
         *
         (mapcar
            '((F)
               (bin
                  (mapcar '((L) (car (F cdr L))) Lst) ) )
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
(de c3-select (Fun Lst Select)
   (if (= (cdar Lst) (cdadr Lst))
      Select
      (car (Fun cdr Lst)) )
)
(de c3-glue (File Fun Select)
   (let Lst (c3-read File)
      (for I (length (car Lst))
         (let L (c3-worker (c3-get I))
            (setq Lst (c3-filter Lst I (c3-select Fun L Select))) ) )
      (bin (car Lst)) ) )
(de c3-2 (F)
   (*
      (c3-glue F 'maxi "1")
      (c3-glue F 'mini "0") ) )
(test
   230
   (c3-2 "data/3-test.txt") )
(test
   587895
   (c3-2 "data/3.txt") )

# --- Day 4: Giant Squid ---
(de c4-header ()
   (make
      (until (eol)
         (link (read)) ) ) )
(de c4-grids ()
   (make
      (until (eof)
         (link
            (make
               (do 5
                  (link
                     (make
                        (do 5
                           (link (box (read))) ) ) ) )
               (line) ) ) ) ) )
(de c4-print ()
   (msg 'NEXT)
   (for G C4-Grids
      (for L G
         (for This L
            (let Found (: F)
               (if Found
                  (prin "\(" (val This) "\) ")
                  (prin (val This) " ") ) ) )
         (prinl) )
      (prinl) ) )
(de c4-set (N)
   (println 'set N)
   (for G C4-Grids
      (for L G
         (for This L
            (when (= N (val This))
               (put This 'F T) ) ) ) ) )
(de c4-find (Grid)
   # (println 'Grid Grid)
   (find
      '((Lst)
         (fully '((This) (: F)) Lst) )
      (conc
         (copy Grid)
         (apply mapcar Grid list) ) ) )
(in "data/4-test.txt"
   (setq C4-Moves (c4-header))
   (setq C4-Grids (c4-grids))
   (do 12
      (c4-set (++ C4-Moves))
      # (T (setq @@ (c4-check)) (println '@@ @@))
   )
   (println 'find (c4-find (last C4-Grids)))
   (c4-print)
)



(msg 'ok)
(bye)
