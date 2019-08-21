(load "@lib/simul.l")

(de numbrix (Lst)
   (let Grid (grid (length (car Lst)) (length Lst))
      (mapc
         '((G L)
            (mapc
               '((This Val) (and (gt0 Val) (=: val Val)))
               G
               L ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (disp Grid 0 '((This) (align 3 (: val))))
      (let 
         (Todo
            (by '((This) (: val)) sort
               (mapcan '((C) (filter '((This) (gt0 (: val))) C)) 
                  Grid ) )
            N 1 )
         (with (++ Todo)
            (recur (N Todo)
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
                     (quote west east south north) ) ) ) )
      )
      (disp Grid 0 '((This) (align 3 (: val))))
))
                  

(numbrix
   (quote
      (0  0  0  0  0  0  0  0  0)
      (0  0 46 45  0 55 74  0  0)
      (0 38  0  0 43  0  0 78  0)
      (0 35  0  0  0  0  0 71  0)
      (0  0 33  0  0  0 59  0  0)
      (0 17  0  0  0  0  0 67  0)
      (0 18  0  0 11  0  0 64  0)
      (0  0 24 21  0  1  2  0  0)
      (0  0  0  0  0  0  0  0  0) ) )

(msg 'ok)
(bye)

