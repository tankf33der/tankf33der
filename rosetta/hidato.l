(load "@lib/simul.l")
 
(de hidato (Lst)
   (let Grid (grid (length (maxi length Lst)) (length Lst))
      (mapc
         '((G L)
            (mapc
               '((This Val)
                  (nond
                     (Val
                        (with (: 0 1 1) (con (: 0 1)))    # Cut off west
                        (with (: 0 1 -1) (set (: 0 1)))   # east
                        (with (: 0 -1 1) (con (: 0 -1)))  # south
                        (with (: 0 -1 -1) (set (: 0 -1))) # north
                        (set This) )
                     ((=T Val) (=: val Val)) ) )
               G L ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (let Todo
         (by '((This) (: val)) sort
            (mapcan '((Col) (filter '((This) (: val)) Col))
               Grid ) )
         (println 'Todo Todo)
         (let N 1
            (with (pop 'Todo)
               (recur (N Todo)
                  (println 'N N 'Todo Todo)
                  (unless (> (inc 'N) (; Todo 1 val))
                     (find
                        '((Dir)
                           (with (Dir This)
                              (cond
                                 ((= N (: val))
                                    (if (cdr Todo) (recurse N @) T) )
                                 ((not (: val))
                                    (=: val N)
                                    (or (recurse N Todo) (=: val NIL)) ) ) ) )
                        (quote
                           west east south north
                           ((X) (or (south (west X)) (west (south X))))
                           ((X) (or (north (west X)) (west (north X))))
                           ((X) (or (south (east X)) (east (south X))))
                           ((X) (or (north (east X)) (east (north X)))) ) ) ) ) ) ) )
      (disp Grid 0
         '((This)
            (if (: val) (align 3 @) "   ") ) ) ) )
(hidato
   (quote
      (T   33  35  T   T)
      (T   T   24  22  T)
      (T   T   T   21  T   T)
      (T   26  T   13  40  11)
      (27  T   T   T   9   T   1)
      (NIL NIL T   T   18  T   T)
      (NIL NIL NIL NIL T   7   T  T)
      (NIL NIL NIL NIL NIL NIL 5  T) ) )
(msg 'ok)
(bye)

