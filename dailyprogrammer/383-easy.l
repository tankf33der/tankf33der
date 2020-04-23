# https://www.reddit.com/r/dailyprogrammer/comments/ffxabb/20200309_challenge_383_easy_necklace_matching/https://www.reddit.com/r/dailyprogrammer/comments/ffxabb/20200309_challenge_383_easy_necklace_matching/
#
(gc 64)

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
   #(in "383-test1.txt"
   #(in "383-test2.txt"
   (in "enable1.txt"
      (until (eof)
         (let
            (L (sort (line))
               K (cons (char (hash L)) L)
               R (idx 'D K) )
            (if R
               (inc (caar @))
               (set (car K) 1)
               (idx 'D K T) )


         )

      )
   )

   #{
   (for L (idx 'D)
      (println 'L L (val (car L)) (length (cdr L)) (pack (mapcar char (cdr L))))
   )
   }#

   (for L (idx 'D)
      (when (= 4 (val (car L)))
         (println 'L L (val (car L)))
      )
   )



)


(msg '383-easy-ok)
(bye)

