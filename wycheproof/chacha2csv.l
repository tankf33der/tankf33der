(load "@lib/json.l")

# XXX, delete last 5 lines
(mapcar
   '((L)
      (when (lst? L)
         (mapcar
            '((L)
               (prinl
                  (cdr (assoc "key" L))
                  ","
                  (cdr (assoc "iv" L))
                  ","
                  (cdr (assoc "tag" L))
                  ","
                  (cdr (assoc "aad" L))
                  ","
                  (cdr (assoc "ct" L))
                  ","
                  (cdr (assoc "msg" L))
                  ","
                  (if (= "valid" (cdr (assoc "result" L))) 0 -1) ) )
            (cdr (assoc "tests" L)) ) ) )
   (assoc "testGroups" (in "chacha20_poly1305_test.json" (readJson))) )
(bye)
