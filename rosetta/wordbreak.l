(setq *Dict (quote "a" "bc" "abc" "cd" "b"))
(setq *Dict2
   (quote
      "mobile" "samsung" "sam" "sung" "man" "mango"
      "icecream" "and" "go" "i" "like" "ice" "cream" ) )

(de word (Str D)
   (let
      (Str (chop Str)
         Len (length Str)
         DP (need (inc Len))
         Res (need (inc Len))
         B 1 )
      (set DP 0)
      (map
         '((L)
            (and
               (get DP B)
               (for N (length L)
                  (let Str (pack (head N L))
                     (when (member Str D)
                        (set (nth Res (+ B N))
                           (copy (get Res B)) )
                        (queue (nth Res (+ B N)) Str)
                        (set (nth DP (+ B N))
                           (inc (get DP B)) ) ) ) ) )
            (inc 'B) )
         Str )
      (last Res) ) )

(println (word "abcd" *Dict))
(println (word "abbc" *Dict))
(println (word "abcbcd" *Dict))
(println (word "acdbc" *Dict))
(println (word "abcdd" *Dict))
(println (word "ilikesamsung" *Dict2))
(println (word "iii" *Dict2))
(println (word "ilikelikeimangoiii" *Dict2))
(println (word "samsungandmango" *Dict2))
(println (word "samsungandmangok" *Dict2))
(println (word "ksamsungandmango" *Dict2))

(test '("a" "b" "cd") (word "abcd" *Dict))
(test '("a" "b" "bc") (word "abbc" *Dict))
(test '("a" "bc" "b" "cd") (word "abcbcd" *Dict))
(test '("a" "cd" "bc") (word "acdbc" *Dict))
(test NIL (word "abcdd" *Dict))
(test '("i" "like" "sam" "sung") (word "ilikesamsung" *Dict2))
(test '("i" "i" "i") (word "iii" *Dict2))
(test '("i" "like" "like" "i" "man" "go" "i" "i" "i")
   (word "ilikelikeimangoiii" *Dict2) )
(test '("sam" "sung" "and" "man" "go") (word "samsungandmango" *Dict2))
(test NIL (word "samsungandmangok" *Dict2))
(test NIL (word "ksamsungandmango" *Dict2))

(msg 'ok)
(bye)

