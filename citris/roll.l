(setq *F
   (quote
      (S ((2 -1) (0 0) (0 0) (0 -1) 
            (-2 1) (0 0) (0 0) (0 1) . ) )
      (Z ((2 1) (0 0) (0 0) (0 1)
            (-2 -1) (0 0) (0 0) (0 -1) . ) )
      (O ((0 0) .))
      (I ((1 -1) (0 0) (-1 1) (-2 2)
            (-1 1) (0 0) (1 -1) (2 -2) . ) )
      (J ((-1 1) (0 0) (1 -1) (0 -2)
            (1 1) (0 0) (-1 -1) (-2 0)
            (1 -1) (0 0) (-1 1) (0 2)
            (-1 -1) (0 0) (1 1) (2 0) . ) )
      (L ((-1 1) (0 0) (1 -1) (-2 0)
            (1 1) (0 0) (-1 -1) (0 2)
            (1 -1) (0 0) (-1 1) (2 0)
            (-1 -1) (0 0) (1 1) (0 -2) . ) )
      (T ((0 0) (1 1) (0 0) (0 0)
            (2 0) (-1 -1) (0 0) (0 0)
            (-2 0) (0 0) (0 0) (1 -1)
            (0 0) (0 0) (0 0) (-1 1) .) ) ) )
(setq *F-create
   (quote
      (S (1 0) (1 1) (2 1))
      (T (1 -1) (1 0) (1 1))
      (O (0 1) (1 1) (1 0))
      (I (1 0) (2 0) (3 0))
      (J (0 1) (0 2) (1 2))
      (L (0 1) (0 2) (1 0))
      (Z (1 0) (1 -1) (2 -1)) ) )
(de world-create (X Y)
   (make (do X (link (need Y '\#)))) )
(de world-set (G Figs C)
   (mapc
      '((F)
         (mapc
            '((P)
               (set (nth G (car P) (cadr P)) C) )
            (cdr F) ) )
      Figs ) )
(de world-clear (G Figs)
   (world-set G Figs '\#) )
(de world-draw (G Figs)
   (world-set G Figs 'X) )
(de world-redraw (G Figs) # IMPL ME
   (world-clear G Figs)
   (roll Figs)
   (world-draw G Figs)
   (mapc prinl G)
   (do 2
      (prinl) ) )
(de figures-create (Lst)
   (mapcar
      '((F)
         (let
            (Lst (cdr (asoq (car F) *F-create))
               X (cadr F) )
            (make
               (chain F)
               (for L Lst
                  (link
                     (list
                        (+ (car L) (car X))
                        (+ (cadr L) (cadr X)) ) ) ) ) ) )
      Lst ) )
(de roll (Figs)
   (for (Lst Figs Lst)
      (let? Fu (cdr (asoq (caar Lst) *F))
         (for (L (cdar Lst) L)
            (let N (pop Fu)
               (inc (car L) (car N))
               (inc (cdar L) (cadr N)) )
            (pop 'L) ) )
      (pop 'Lst) ) )
(de go @
   (let
      (G (world-create 9 23)
         Figs
         (figures-create
            '((S (2 3))
               (T (5 5))
               (O (1 14))
               (I (2 20))
               (J (7 9))
               (L (7 16))
               (Z (2 10)) ) ) )
      (loop (wait 500) (world-redraw G Figs)) ) )
(go)
(bye)
