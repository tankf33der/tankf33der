(gc 36)
(de rotn (A)
   (make
      (do (length A)
         (link (copy (rot A))) ) ) )
(de necklace (A B)
   (let (A (chop A)  B (chop B))
      (when (= (length A) (length B))
         (or
            (= A B)
            (pick '((C) (= C B)) (rotn A)) ) ) ) )
(test T (necklace "nicole" "icolen"))
(test T (necklace "nicole" "lenico"))
(test NIL (necklace "nicole" "coneli"))
(test T (necklace "aabaaaaabaab" "aabaabaabaaa"))
(test NIL (necklace "abc" "cba"))
(test NIL (necklace "xxyyy" "xxxyy"))
(test NIL (necklace "xyxxz" "xxyxz"))
(test T (necklace "x" "x"))
(test NIL (necklace "x" "xx"))
(test NIL (necklace "x" ""))
(test T (necklace "" ""))

# optional bonus 2
(let D NIL
   (in "enable1.txt"
      (until (eof)
         (let
            (L (sort (mapcar char (line)))
               K (cons (char (hash L)) L) )
            #(println 'L L 'K K)
            #(wait 1000)
            (if (idx 'D K)
               (inc (caar @))
               (set (car K) 1)
               (idx 'D K T) )
         )

      )
   )
   #{
   (for L (idx 'D)
      (println 'L L (val (car L)))
      (wait 10)
   )
   }#
   (println
      (filter
         '((L) (= 8 (val (car L))))
         (idx 'D) ) )

)


(msg '383-easy-ok)
(bye)

