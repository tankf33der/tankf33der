# https://www.reddit.com/r/dailyprogrammer/comments/ffxabb/20200309_challenge_383_easy_necklace_matching/https://www.reddit.com/r/dailyprogrammer/comments/ffxabb/20200309_challenge_383_easy_necklace_matching/
# https://www.morewords.com/
(gc 72)

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
   # (in "10k.txt"
   #(in "383-test1.txt"
   #(in "383-test2.txt"
   (in "enable1.txt"
      (until (eof)
         (let
            (W (line T)
               L (sort (chop W))
               K (cons (char (hash L)) L) )
            (set (car K) 1)
            (put (car K) 1 W)
            (when (idx 'D K T)
               (inc (caar @))
               (put (caar @) (val (caar @)) W)
            )
         )

      )
   )

   (for L (idx 'D)
      (when (= (val (car L)) 4)
         (println 'L L (val (car L)) (getl (car L)))
      )
   )



)

(msg '383-easy-ok)
(bye)

