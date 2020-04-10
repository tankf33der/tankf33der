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



(msg '383-easy-ok)
(bye)

