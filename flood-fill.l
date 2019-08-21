(load "@lib/simul.l")

(de floodfill (Start Lst)
   (let
      (Lst (mapcar chop Lst)
         Grid (grid (length (car Lst)) (length Lst)) )
      (mapc
         '((G L)
            (mapc
               '((This Val)
                  (cond
                     ((= "#" Val)
                        (with (: 0 1 1) (con (: 0 1)))    # W
                        (with (: 0 1 -1) (set (: 0 1)))   # E
                        (with (: 0 -1 1) (con (: 0 -1)))  # S
                        (with (: 0 -1 -1) (set (: 0 -1))) # N
                        (set This) )
                     (T (=: V Val)) ) )
               G
               L ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (disp Grid 0 '((This) (if (: V) (pack " " @ " ") "   ")))
      (with Start
         (recur (This)
            (when (= " " (: V))
               (=: V T)
               (recurse (west This))
               (recurse (east This))
               (recurse (south This))
               (recurse (north This)) ) ) )
      (disp Grid 0 '((This) (if (: V) (pack " " @ " ") "   "))) ) )
#{
(floodfill
   'a1
   (quote
      "###"
      "   "
      "   " ) )
(floodfill
   'd4
   (quote
      "   #   "
      "   #   "
      "  #    "
      "##   ##"
      "    #  "
      "   #   " ) )
      "   #   "
}#

(de fgh (Start Lst)
   (let Grid (grid (length (car Lst)) (length Lst))
      (mapc
         '((G L)
            (mapc
               '((This Val) (=: val Val))
               G
               L ) )
         Grid
         (apply mapcar (reverse Lst) list) )
      (disp Grid 0 '((This) (align 3 (: val))))
      (let
         (Cnt
            (sum
               '((G) (cnt '((This) (=0 (: val))) G)) Grid )
            N 1 )
         (println 'start 'N N 'Cnt Cnt)
         (with Start
            (=: visit T)
            (recur (N Cnt)
               (inc 'N)
               (find
                  '((Dir)
                     (with (Dir This)
                        (cond
                           ((=0 Cnt) (println 'END) T)
                           ((= N (: val))
                              (=: visit T)
                              (or (recurse N Cnt) (=: visit NIL)) ) 
                           ((and (not (: visit)) (=0 (: val)))
                              (=: val N)
                              (=: visit T)
                              (or (recurse N (dec Cnt)) (nil (println 'RETURN) (=: val 0)) (=: visit NIL)) ) ) ) )
                  (quote west east south north)
               )
            )
         )
      )
      (disp Grid 0 '((This) (align 3 (: val)))) ) )
(fgh
   'a1
   (quote
      (9 0 0)
      (0 0 0)
      (1 2 0) ) )
            
(msg 'ok)
(bye)
