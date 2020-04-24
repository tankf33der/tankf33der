# https://www.reddit.com/r/dailyprogrammer/comments/ffxabb/20200309_challenge_383_easy_necklace_matching/
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

# optional bonus #2
(off D)
(setq Lst
   (make (in "enable1.txt" (while (line) (link @)))) )
(for L Lst
   (idx 'D (cons (char (hash L)) L) T) )
(println
   (filter
      '((L)
         (=
            4
            (cnt
               '((A) (idx 'D (cons (char (hash A)) A)))
               (rotn L) ) ) )
      Lst ) )
(msg '383-easy-ok)
(bye)

