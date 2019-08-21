# notes: 
# (dec (:: goblin 5))
# (put 'c2 'goblin (get 'a1 'goblin))
# (put 'c2 'goblin (; 'a1 goblin))
# reading order: north, west, east, south
(load "@lib/simul.l")
(de a15-list (F)
   (make (in F (while (line) (link @)))) )
(de prin-stat (Lst)
   (for This Lst
      (when (: piece)
         (prin (: points) " ") ) ) ) 
(de a15-remove (Grid)
   (for G Grid
      (for This G
         (removeprop This) ) ) )
(de grid-display (Grid)
   (for G (flip (apply mapcar Grid list))
      (for This G
         (prin
            (cond
               ((not (val This)) "#")
               ((: piece) (car @))
               (T ".") ) ) )
      (prin-stat G)
      (prinl) ) )
(de removeprop (This)
   (=: points)
   (=: piece) )
(de attack (This)
   (dec (:: points) 3)
   (when (le0 (: points))
      (removeprop This) ) )
(de select-attack (This)
   (let (I (: piece)  A (a15-enemy I))
      (by
         cdr
         sort
         (mapcan
            '((Dir N)
               (with (Dir This)
                  (and
                     (= (: piece) A)
                     (cons (list This (: points) N)) ) ) )
            '(north west east south)
            (1 2 3 4) ) ) ) )
(de move (This Goal)
   (put Goal 'points (: points))
   (put Goal 'piece  (: piece))
   (removeprop This) ) 
(de short (This Goal)
   (let (Path NIL  Best NIL) 
      (recur (This Path)
         (when (and This (not (: mark)) (not (: piece)))
            (push 'Path This)
            (if (== Goal This)
               (unless (and Best (>= (length Path) (length Best)))
                  (setq Best Path) )
               (=: mark T)
               (recurse (north This) Path)
               (recurse (west This) Path)
               (recurse (east This) Path)
               (recurse (south This) Path)
               (=: mark NIL) ) ) )
      Best ) ) 
(de a15-enemy (U)
   (if (= U "E") "G" "E") )
# skip move if near enemy
(de intersect (Lst Enem)
   (sect
      (mapcar car Lst)
      Enem ) )
(de a15-neib4att (This)
   (let (I (: piece)  A (a15-enemy I))
      (by
         cdr
         sort
         (mapcan
            '((Dir N)
               (with (Dir This)
                  (and
                     (= (: piece) A)
                     (cons (list This (: points) N)) ) ) )
            '(north west east south)
            (range 1 4) ) ) ) )
(de mike (F)
   (let
      (Lst (a15-list F)
         Grid (grid (length (car Lst)) (length Lst))
         Rounds 0
      )
      #(println Grid)
      (mapc
         '((G L)
            (mapc
               '((This Val)
                  (case Val
                     ("#"
                        (with (: 0 1 1) (con (: 0 1)))    # W
                        (with (: 0 1 -1) (set (: 0 1)))   # E
                        (with (: 0 -1 1) (con (: 0 -1)))  # S
                        (with (: 0 -1 -1) (set (: 0 -1))) # N
                        (set This) )
                     (("E" "G")
                        (=: piece @)
                        (=: points 200) ) ) )
               G
               L ) )
         Grid
         (apply mapcar (reverse Lst) list)
      )

      #(grid-display Grid)

(catch 'exit
(loop
      (for L (round Grid)
         (NIL (one-type-piece? Grid) (throw 'exit))
         (when (with (car L) (: piece))
         (let
            (My (adjacentMy (car L))
               Enem (enemies (cdr L) Grid)
               Adjs (enemies-adj Enem)
               NextMove NIL )
            #(println 'row 'L L 'M My 'E Enem 'A Adjs)
            #(setq NextMove (select-move My Adjs))
            #(println 'NextMove NextMove)
            # skip move if near enemy
            (unless (intersect My Enem)
               #(println 'moving (car L))
               (setq NextMove (select-move My Adjs))
               (and
                  NextMove
                  #(println 'moved (car L) NextMove)
                  (move (car L) NextMove)
                  #(setq L (list NextMove))
                  (set L NextMove)
                  #(setq My (adjacentMy NextMove))
                  ## XXX
                  #(println 'moved-new L)
               )
            )
            (setq My (adjacentMy (if NextMove @ (car L))) )
            ###   Enem (enemies (cdr L) Grid) )
            #(println 'M My 'E Enem)
            #(println 'after-move (car L) (intersect My Enem))
            (when (intersect My Enem)
               (let A (select-attack (if NextMove @ (car L)))
                  #(println 'attacking (car L) (caar A))
                  (attack (caar A))
               )
            )
         )
      )
      #(grid-display Grid)
   ) #when
   (inc 'Rounds)
) #loop
) #catch
(prog1
   (*
      Rounds
      (sum
         '((G)
            (sum '((This) (: points)) G))
         Grid ) )
      (a15-remove Grid)
)
   )
)
(de one-type-piece? (Grid)
   (let R NIL
      (for G Grid
         (for This G
            (and (: piece) (accu 'R @ 1)) ) )
      (cdr R) ) )
# '((c3 2) (d2 3)) (c5 f3 g2)
(de select-move (My Adjs)
   (caar
      (by
         '((L) (reverse (cdr L))) # LOL
         sort
         (mapcan
            '((M)
               (let L
                  (mapcan
                     '((A)
                        (and (short (car M) A) (cons (length @))) )
                     Adjs )
                  (when L (cons (append M (cons (apply min L))))) ) )
            My ) ) ) )
# '((b4 . "E") (c2 . "G"))
(de round (Grid)
   (make
      (for G (flip (apply mapcar Grid list))
         (for This G
            (and
               (: piece)
               (link (cons This @) ) ) ) ) ) )
(de adjacentMy (This)
   (mapcan
      '((Dir N)
         (with (Dir This)
            (and (val This) (list (list This N))) ) )
      '(north west east south)
      '(1 2 3 4) ) ) 
(de adjacent (This)
   (mapcan
      '((Dir)
         (with (Dir This)
            (and (val This) (cons This)) ) )
      '(north west east south) ) )
(de enemies (X Grid)
   (let A (a15-enemy X)
      (make
         (for G (flip (apply mapcar Grid list))
            (for This G
               (and
                  (= (: piece) A)
                  (link This) ) ) ) ) ) )
(de enemies-adj (Lst)
   (mapcan adjacent Lst) )


#(mike "advent2018/data/15-test-4.txt")
(test 27730 (mike "advent2018/data/15-test-6.txt"))
(test 36334 (mike "advent2018/data/15-test-7.txt"))
(test 39514 (mike "advent2018/data/15-test-8.txt"))
(test 27755 (mike "advent2018/data/15-test-9.txt"))
(test 28944 (mike "advent2018/data/15-test-10.txt"))
(test 18740 (mike "advent2018/data/15-test-11.txt"))
(msg 'ok)
(bye)

