(load "@lib/json.l")

(mapcar
   '((L)
      (when (lst? L)
         (mapcar
            '((L)
               (prinl
                  (cdr (assoc "private" L))
                  ","
                  (cdr (assoc "public" L))
                  ","
                  (cdr (assoc "shared" L)) ) ) 
            (cdr (assoc "tests" L)) ) ) )
   (assoc "testGroups" (in "x25519_test.json" (readJson))) )
(bye)
