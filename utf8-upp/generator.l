(de parse (F)
   (make
      (in F
         (while (line)
            (let (L (split @ ";")  N (car L))
               (and
                  (= '("L" "u") (get L 3))
                  (link (hex N)) ) ) ) ) ) )
(de ranges (F)
   (let R NIL
      (for N (parse F)
         (if (= (dec N) (cadar R))
            (inc (cdar R))
            (push 'R (list N N)) ) )
      (flip R) ) )

(prinl "(de *U")
(for L (ranges "UnicodeData.txt")
   (space 3)
   (println L) )
(prinl ")")
(bye)
