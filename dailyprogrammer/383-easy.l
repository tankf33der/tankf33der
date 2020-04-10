(de rotn (A)
   (make
      (do (length A)
         (link (copy (rot A))) ) ) )
(de necklace (A B)
   (let (A (chop A)  B (chop B))
      (println 'A A 'B B)
      (and
         (= (length A) (length B))
         (println 'boom)
         (pick '((C) (prog (println 'C C 'B B) (= C B))) (rotn A)) ) ) )
#{
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
}#
(println T (necklace "" ""))




(msg 'ok)
(bye)

