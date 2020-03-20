# http://rosettacode.org/wiki/Fivenum
(de median (Lst)
   (let N (length Lst)
      (if (bit? 1 N)
         (get (sort Lst) (/ (inc N) 2))
         (setq Lst (nth (sort Lst) (/ N 2)))
         (/ (+ (car Lst) (cadr Lst)) 2) ) ) )
(de fivenum (Lst)
   (let (Len (length Lst)  M (/ Len 2)  S (sort Lst))
      (list
         (format (car S) *Scl)
         (format (median (head (+ M (% Len 2))  S)) *Scl)
         (format (median S) *Scl)
         (format (median (tail M S)) *Scl)
         (format (last S) *Scl) ) ) )
(scl 2)
(println (fivenum (36.0 40.0 7.0 39.0 41.0 15.0)))
(scl 8)
(println
   (fivenum
      (0.14082834 0.09748790 1.73131507 0.87636009 -1.95059594
         0.73438555 -0.03035726 1.46675970 -0.74621349 -0.72588772
         0.63905160 0.61501527 -0.98983780 -1.00447874 -0.62759469
         0.66206163 1.04312009 -0.10305385 0.75775634 0.32566578 ) ) )
#{
("7.00" "15.00" "37.50" "40.00" "41.00")
("-1.95059594" "-0.67674120" "0.23324706" "0.74607094" "1.73131507")
}#
(msg 'ok)
(bye)
