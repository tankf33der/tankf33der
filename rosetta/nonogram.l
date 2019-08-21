(de nonogram (LstX LstY)
   (let Lim (** 2 (length LstY))
      (_nonogX LstX) ) )
(de _nonogX (LstX Res)
   (if LstX
      (_nonogY LstX Res)
      (when
         (= 
            LstY
            (make
               (for (I Lim (gt0 (setq I (>> 1 I))))
                  (link
                     (flip
                        (make
                           (let C NIL
                              (for N Res
                                 (if2 (bit? I N) C
                                    (inc 'C)
                                    (one C)
                                    (prog (link C) (off C)) ) )
                              (and C (link @)) ) ) ) ) ) ) )
         (for N (flip Res)
            (for (I Lim (gt0 (setq I (>> 1 I))))
               (prin "|" (if (bit? I N) "X" "_")) )
            (prinl "|") ) ) ) )
(de _nonogY (LstX Res)
   (let
      (Lst
         (mapcar
            '((N) (cons 1 (** 2 N)))
            (car LstX) )
         P Lst )
      (recur (P)
         (ifn P
            (let N 0
               (for X Lst
                  (setq N
                     (+
                        (* 2 N (car X) (cdr X))
                        (* (car X) (dec (cdr X))) ) ) )
               (when (> Lim N)
                  (_nonogX (cdr LstX) (cons N Res))
                  T ) )
            (prog1 (recurse (cdr P))
               (while
                  (prog
                     (set (car P) (* 2 (caar P)))
                     (recurse (cdr P)) ) )
               (set (car P) 1) ) ) ) ) )
#{
(in "nonogram_problems.txt"
   (until (eof)
      (println
         (mapcar
            '((L) (mapcar '((C) (- (char C) 64)) L))
            (split (line) " ") ) 
         (mapcar
            '((L) (mapcar '((C) (- (char C) 64)) L))
            (split (line) " ") ) )
      (prinl)
      (prinl) 
      (line)
   )
)
}#

(bench
(nonogram
   '((6) (3 1 3) (1 3 1 3) (3 14) (1 1 1) (1 1 2 2) (5 2 2) (5 1 1) (5 3 3 3) (8 3 3 3))
   '((4) (4) (1 5) (3 4) (1 5) (1) (4 1) (2 2 2) (3 3) (1 1 2) (2 1 1) (1 1 2) (4 1) (1 1 2) (1 1 1) (2 1 2) (1 1 1) (3 4) (2 2 1) (4 1)) )
)

(msg 'ok)
(bye)
