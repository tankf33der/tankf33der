(load "@lib/json.l")
(mapcar
   '((L)
      (mapcar
         '((L)
            (prinl
               (cdr (assoc "key" L))
               ","
               (cdr (assoc "msg" L))
               ","
               (cdr (assoc "tag" L))
               ","
               (if (= (cdr (assoc "result" L)) "valid") 0 1) ) )
         (cdr (assoc "tests" L)) ) )
   (assoc "testGroups" (in "hmac_sha512_test.json" (readJson))) )
(bye)
