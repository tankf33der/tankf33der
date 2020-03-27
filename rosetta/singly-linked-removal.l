# Non-destuctive
(de delnon (Item Lst)
   (if (index Item Lst)
      (conc
         (head (dec @) Lst)
         (tail (- @) Lst) )
      Lst ) )

# Destructive
(de deldestr-- (Item "Lst")
   (when (setq @@ (index Item (val "Lst")))
      (if (=1 @)
         (set "Lst" (cdr (val "Lst")))
         (con
            (nth (val "Lst") (dec @@))
            (tail (- @@) (val "Lst")) ) ) ) )
(de deldestr (Item "Var")
   (let Lst (val "Var")
      (let? M (member Item Lst)
         (ifn (prior M Lst)
            (set "Var" (cdr Lst))
            (con @ (cdr M))
            (val "Var") ) ) ) )

(let (N 2  L (range 1 5))
   (delnon N L)
   (println 'L L)
   (setq L (delnon N L))
   (println 'fin L) )

(msg 'destr)
(let (N 3  L (range 1 5))
   (println 'L L)
   (deldestr N 'L)
   (println 'fin 'L L) )

(msg 'ok)
(bye)
