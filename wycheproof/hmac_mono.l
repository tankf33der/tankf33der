(load "@lib/json.l")
(mapcar
   '((L)
      (mapcar
         '((L)
            (let
               (K (cdr (assoc "key" L))
                  M (cdr (assoc "msg" L))
                  R (cdr (assoc "tag" L))
                  F (= "valid" (cdr (assoc "result" L))) )
               (and
                  F
                  (= 128 (length R))
                  (prinl K ":")
                  (prinl M ":")
                  (prinl R ":")
                  (prinl) ) ) )
         (cdr (assoc "tests" L)) ) )
   (assoc "testGroups" (in "hmac_sha512_test.json" (readJson))) )
(bye)
