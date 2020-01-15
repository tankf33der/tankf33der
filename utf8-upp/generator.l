# for UnicodeData.txt format
(de parse- (F)
   (make
      (in F
         (while (line)
            (let (L (split @ ";")  N (car L))
               (and
                  (= '("L" "u") (get L 3))
                  (link (hex N)) ) ) ) ) ) )
(de parse (F)
   (make
      (in F
         (until (eof)
            (link (hex (till ";")))
            (line) ) ) ) )
(de ranges (F)
   (let R NIL
      (for N (parse F)
         (if (= (dec N) (cadar R))
            (inc (cdar R))
            (push 'R (list N N)) ) )
      (flip R) ) )

(prinl "(de *U")
(for L (ranges "CaseFolding.txt")
   (space 3)
   (print L)
   (prinl
      "   # "
      (hex (car L))
      " "
      (hex (cadr L)) ) )
(prinl ")")
(bye)
