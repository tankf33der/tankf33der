(de delnon (Item Lst)
   (if (index Item Lst)
      (conc
         (head (dec @) Lst)
         (tail (- @) Lst) )
      Lst ) )
(let L (range 1 5)
   (delnon 2 L)
   (println 'L L)
)


(msg 'ok)
(bye)
