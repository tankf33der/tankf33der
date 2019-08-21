# Original archive version from A.Burger (jan2018)
#
#
# 22mar10abu
# (c) Software Lab. Alexander Burger
 
# ../p binary.l 10 -bye |diff - binary/output
# time ../p binary.l 20 -bye
 
(de buildTree (Item Depth)
   (cons Item
      (and
         (n0 Depth)
         (cons
            (buildTree
               (dec (setq Item (>> -1 Item)))
               (dec 'Depth) )
            (buildTree Item Depth) ) ) ) )
 
(de checkNode (Node)
   (if2 (cadr Node) (cddr Node)
      (- (+ (car Node) (checkNode (cadr Node))) (checkNode @))
      (+ (car Node) (checkNode @))
      (- (car Node) (checkNode @))
      (car Node) ) )
 
(let (N (format (opt))  Min 4)
   (prinl
      "stretch tree of depth "
      (inc N)
      "^I check: "
      (checkNode (buildTree 0 (inc N))) )
   (let LongLivedTree (buildTree 0 N)
      (for (D Min (>= N D) (+ 2 D))
         (let (Sum 0  Iterations (>> (- D Min N) 1))
            (for I Iterations
               (inc 'Sum
                  (+
                     (checkNode (buildTree I D))
                     (checkNode (buildTree (- I) D)) ) ) )
            (prinl
               (* 2 Iterations)
               "^I trees of depth "
               D
               "^I check: "
               Sum ) ) )
      (prinl
         "long lived tree of depth "
         N
         "^I check: "
         (checkNode LongLivedTree) ) ) )
 
# vi:et:ts=3:sw=3
 
 
# 07nov09abu
# (c) Software Lab. Alexander Burger
 
# ../p fannkuch2.l 7 -bye |diff - fannkuch/output
# time ../p fannkuch2.l 12 -bye
 
(let (N (format (opt))  Lst (range N 1)  L Lst)
   (catch NIL
      (recur (L)  # Print the first 30 permutations
         (cond
            ((cdr L)
               (do (length L)
                  (recurse (cdr L))
                  (rot L) ) )
            ((ge0 (dec (30)))
               (prinl (reverse Lst)) )
            (T (throw)) ) ) )
   (let (Res (need N)  M)
      (for (R Res R (cdr R))
         (later R
            (let L (cdr Lst)
               (recur (L)  # Permute
                  (if (cdr L)
                     (do (length L)
                        (recurse (cdr L))
                        (rot L) )
                     (let I 0  # For each permutation
                        (for (P (copy Lst)  (> (car P) 1)  (flip P (car P)))
                           (inc 'I) )
                        (setq M (max I M)) ) ) )
               M ) )
         (rot Lst) )
      (wait NIL (full Res))
      (prinl "Pfannkuchen(" N ") = " (apply max Res)) ) )
 
# vi:et:ts=3:sw=3
 
 
# 07nov09abu
# (c) Software Lab. Alexander Burger
 
# ../p fannkuch.l 7 -bye |diff - fannkuch/output
# time ../p fannkuch.l 12 -bye
 
(let (N (format (opt))  Lst (range N 1)  L Lst  M)
   (recur (L)  # Permute
      (if (cdr L)
         (do (length L)
            (recurse (cdr L))
            (rot L) )
         (let I 0  # For each permutation
            (and (ge0 (dec (30))) (prinl (reverse Lst)))
            (for (P (copy Lst)  (> (car P) 1)  (flip P (car P)))
               (inc 'I) )
            (setq M (max I M)) ) ) )
   (prinl "Pfannkuchen(" N ") = " M) )
 
# vi:et:ts=3:sw=3
 
 
# 02nov09abu
# (c) Software Lab. Alexander Burger
 
# time ../p meteor.l 2098 |diff - meteor/output
 
(mapc def
   '(SW SE NW NE W E)
   '(caadr cdadr caaddr cdaddr cadddr cddddr) )
 
### Pieces ###
(de *Pieces
   # Blue
   (E E E SE  SE (NW W) W W  NW W W W)
   # Yellow
   (SE SW W SW  NW (SE SW) W SW  (NE NW) SE (SW W) SW  NE E NE NW)
   # Magenta
   (E (W SW) SE SE  W SW SE SE  NE E (SW SW) SE  NW NW NE E)
   # Black
   (SW W SE SE  E NE (SW SW) SE  NW NW E NE)
   # Blue green
   (SE SW (NE E) SE  SE (NW W) NW (SE SW)  NE NW (SE E) SE  NW W NW (SE SW))
   # Brown
   (SW E SW SW  NE SE SW SW  NW SW SE SW  NE NW E NW)
   # Green
   (E SW SE SW  W SE SE SW  SW (NE NW) NW E  NE NW NW E)
   # Dark red
   (SE W SW SE  NW SW SW SE  SE (NW NE) E NW  NW NE E NW)
   # Red
   (E (W SW) W W  W SW W W  E E NE E  (W W) E (E NE) E)
   # Cyan
   (SE W W W  E E NE SE  NW SW W W) )
 
(de build (L F Lst)
   (mapcar
      '((X)
         (cons F
            (list 'setq 'B
               (if (atom X)
                  (list (val X) 'B)
                  (list (caadr X) (list (caar X) 'B)) ) )
            Lst ) )
      L ) )
 
(de trans (L F Lst)
   (for (X L X (cdr X))
      (if (pair (car X))
         (trans @ F Lst)
         (set X (F (memq (car X) Lst))) ) ) )
 
### Board ((value (SW . SE) (NW . NE) W . E) ...) ###
(de _dir Lst
   (or
      (and (pop Lst) (nth *Board (+ N @) 1))
      X ) )
 
(let X (cons T)
   (con X
      (cons (cons X X) (cons X X) X X) )
   (for (N . B) (setq *Board (make (do 50 (link (cons)))))
      (con B
         (cons
            (cons  # (SW . SE)
               (_dir (NIL 4 4 4 4 5 5 5 5 5 .))
               (_dir (5 5 5 5 5 6 6 6 6 NIL .)) )
            (cons  # (NW . NE)
               (_dir (NIL -6 -6 -6 -6 -5 -5 -5 -5 -5 .))
               (_dir (-5 -5 -5 -5 -5 -4 -4 -4 -4 NIL .)) )
            (_dir (NIL -1 -1 -1 -1 .))  # W
            (_dir (1 1 1 1 NIL .)) ) ) ) )  # E
 
(de display (Lst)
   (for B Lst
      (prin (at (4 . 10) " ") B " ")
      (at (0 . 5) (prinl)) )
   (prinl) )
 
### Let's go ###
(let
   (Lst
      (make
         (for (N . P) *Pieces
            (link
               (make
                  (link (dec N))
                  (do 2  # Permutations
                     (do 6
                        (for (L P (cut 4 'L))
                           (link
                              (cons  # (testfun . placefun)
                                 (list '(B) (cons 'or (build @ 'car)))
                                 (cons '(B N) '(set B N) (build @ 'set '(N))) ) ) )
                        (trans P cadr '(E SE SW W NW NE .)) )
                     (trans P cadddr '(E SE NE W SW NW .)) ) ) ) ) )
      Arg (format (opt))
      Cnt 0
      Min T
      Max )
   (recur (Lst)
      (for P Lst
         (for X (cdr P)
            (unless ((car X) (car *Board))
               ((cdr X) (car *Board) (car P))  # Place piece
               (if (seek '((L) (not (caar L))) *Board)  # Find free place
                  (let (*Board @  B (car @)  L)
                     (recur (B)
                        (set (push 'L B) T)
                        (for F '(SW SE NW NE W E)
                           (or (car (F B)) (recurse (F B))) ) )
                     (mapc set L)
                     (when (=0 (% (length L) 5))  # Prune
                        (recurse (delete P Lst)) ) )
                  # We found a solution
                  (let L (mapcar car (up 0 *Board))
                     (setq Min (min L Min)  Max (max L Max)) )
                  (when (= Arg (inc 'Cnt))
                     (prinl Arg " solutions found")
                     (prinl)
                     (display Min)
                     (display Max)
                     (bye) ) )
               ((cdr X) (car *Board)) ) ) ) ) )  # Remove piece
 
# vi:et:ts=3:sw=3
 
 
# 22mar10abu
# (c) Software Lab. Alexander Burger
 
# ../p taskring.l 1000 |diff - threadring/output
# time ../p taskring.l 50000000
 
(for N 503  # Start all 503 tasks
   (let Recv (tmp N)
      (call 'mkfifo Recv)
      (task (open Recv)
         N N
         Send (tmp (if (= 503 N) 1 (inc N)))
         (in @
            (if (gt0 (rd))
               (out Send (pr (dec @)))
               (println N)  # Print result to stdout
               (bye) ) ) ) ) )  # Exit
 
(out (tmp 1)  # Inject first token into the ring
   (pr (format (opt))) )  # as given by command line argument
(wait)  # Wait to exit
 
# vi:et:ts=3:sw=3
 
 
# 22mar10abu
# (c) Software Lab. Alexander Burger
 
# ../p threadring.l 1000 |diff - threadring/output
# time ../p threadring.l 50000000
 
(for N 503  # Start all 503 threads
   (let (Recv (tmp N)  Send (tmp (if (= 503 N) 1 (inc N))))
      (call 'mkfifo Recv)
      (unless (fork)  # In child process:
         (in Recv
            (out Send
               (loop
                  (NIL (rd))
                  (NIL (gt0 @)  # Done
                     (out NIL (println N))  # Print result to stdout
                     (kill *PPid) )  # Stop parent
                  (pr (dec @))
                  (flush) ) ) )
         (bye) ) ) )
 
(out (tmp 1)  # Inject first token into the ring
   (pr (format (opt)))  # as given by command line argument
   (flush)
   (wait) )  # Wait for signal
 
# vi:et:ts=3:sw=3


