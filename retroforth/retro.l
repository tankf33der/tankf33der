(setq 
   *KERNEL "retroImage"
   *MSIZE 256000
   *M NIL
   *D NIL
   *A NIL
   *P NIL
   *I -1 )

(de totwo (N)
   (or
      (ge0 N)
      (x| (dec (abs N)) `(hex "FFFFFFFF")) ) )

(de fromtwo (N)
   (if (> `(hex "80000000") N)
      N
      (- (x| (dec N) `(hex "FFFFFFFF"))) ) )

(de bitwise (F N1 N2)
   (fromtwo
      (F (totwo N1) (totwo N2)) ) )

(de modulo (X Y)
   (% (+ Y (% X Y)) Y) )

(de norm (N)
  (if (< 2147483647 N)
      (- N 4294967296)
      N ) )

(de memory (Key Val)
   (ground '*M Key Val) )

(de ports (Key Val)
   (ground '*P Key Val) )

(de ground ("Tree" Key Val)
   (and (not Key) (quit "boom"))
   (if2 Val (setq @@ (cache "Tree" Key))
      (set @@ Val)
      (cache "Tree" Key Val)
      (val @@)
      0 ) )

(de popA (V)
   (pop '*A V) )
(de popD (V)
   (pop '*D V) )
(de pushD (V)
   (push '*D V) )
(de pushA (V)
   (push '*A V) )

(de devices ()
   (ports 0 1)
   (cond
      ((=1 (ports 1))
         (ports 1 (char (key)))
         (and
            (= 13 (ports 1))
            (ports 1 10) ) )
      ((=1 (ports 2))
         (if (lt0 (car *D))
            (println "... ...")
            (prin (char (car *D))) )
         (popD)
         (ports 2 0)
         (ports 0 1) )
      ((lt0 (ports 5))
         (ports 0 1)
         (case @
            (-1 (ports 5 (dec *MSIZE)))
            (-2 (ports 5 0))
            (-3 (ports 5 0))
            (-4 (ports 5 0))
            (-5 (ports 5 (length *D)))
            (-6 (ports 5 (length *A)))
            (-7 (ports 5 0))
            (-8 (ports 5 1448289621))
            (-9 (setq *I *MSIZE))
            (T (ports 5 0)) ) ) ) )

(de opcode ()
   (case (memory *I)
      (0)
      (1 (pushD (memory (inc '*I))))
      (2 (pushD (car *D)))
      (3 (popD))
      (4 (xchg (nth *D 1) (nth *D 2)))
      (5 (pushA (popD)))
      (6 (pushD (popA)))
      (7
         (dec (nth *D 1))
         (inc '*I)
         (if (gt0 (car *D)) # XXX
            (setq *I (dec (memory *I)))
            (popD) ) )
      (8 (setq *I (dec (memory (inc '*I)))))
      (9 (setq *I (popA)))
      (10
         (let (Tos (popD)  Nos (popD))
            (inc '*I)
            (and
               (< Tos Nos)
               (setq *I (dec (memory *I))) ) ) )
      (11
         (let (Tos (popD)  Nos (popD))
            (inc '*I)
            (and
               (> Tos Nos)
               (setq *I (dec (memory *I))) ) ) )
      (12
         (inc '*I)
         (and
            (<> (popD) (popD))
            (setq *I (dec (memory *I))) ) )
      (13
         (inc '*I)
         (and
            (= (popD) (popD))
            (setq *I (dec (memory *I))) ) )
      (14 (pushD (memory (popD))))
      (15 (memory (popD) (popD)))
      (16 (pushD (norm (+ (popD) (popD)))))
      (17
         (xchg (nth *D 1) (nth *D 2))
         (pushD (norm (- (popD) (popD)))) )
      (18
         (pushD (norm (* (popD) (popD)))) )
      (19
         (let (Tos (popD)  Nos (popD))
            (pushD (modulo Nos Tos))
            (pushD (/ Nos Tos)) ) )
      (20 (pushD (bitwise & (popD) (popD))))
      (21 (pushD (bitwise | (popD) (popD))))
      (22 (pushD (bitwise x| (popD) (popD))))
      (23 (pushD (norm (>> (- (popD)) (popD)))))
      (24 (pushD (norm (>> (popD) (popD)))))
      (25
         (and
            (=0 (car *D))
            (popD)
            (setq *I (popA)) ) )
      (26 (pushD (norm (inc (popD)))))
      (27 (pushD (norm (dec (popD)))))
      (28 # XXX 
         (let X (popD)
            (pushD (ports X))
            (ports X 0) ) )
      (29 (ports (popD) (popD)))
      (30 
         (and
            (=0 (ports 0))
            (for I 12
               (T (=1 (ports I)) T) )
            (ports 0 1)
            (devices) ) )
      (T
         (pushA *I)
         (setq *I (dec @)) ) ) )

(in *KERNEL
   (while (rd -4)
      (memory (inc '*I) (norm @)) ) )

(zero *I)
(while (< *I *MSIZE)
   (opcode)
   (inc '*I) )

(bye)

