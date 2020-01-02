# Non-destuctive
(de delnon (Item Lst)
   (if (index Item Lst)
      (conc
         (head (dec @) Lst)
         (tail (- @) Lst) )
      Lst ) )

# Destructive
(de deldestr (Item "Lst")
   (when (setq @@ (index Item (val "Lst")))
      (if (=1 @)
         (set "Lst" (cdr (val "Lst")))
         (con
            (nth (val "Lst") (dec @@))
            (tail (- @@) (val "Lst")) ) ) ) )
(let (N 2  L (range 1 5))
   (delnon N L)
   (println 'L L)
   (setq L (delnon N L))
   (println 'fin L) )

(msg 'destr)
(let (N 1  L (range 1 5))
   (deldestr N 'L)
   (println 'destr 'L L) )

(msg 'ok)
(bye)
