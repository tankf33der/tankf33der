(load "@lib/json.l")

(mapcar
   '((L)
      (when (lst? L)
         (let
            (K (assoc "key" L)
               P (assoc "pk" K)
               S (assoc "sk" K) )
            (mapcar
               '((L)
                  (prinl 
                     (cdr P) 
                     ","
                     (cdr S)
                     ","
                     (cdr (assoc "msg" L))
                     ","
                     (cdr (assoc "sig" L))
                     ","
                     (if (= "valid" (cdr (assoc "result" L))) 0 -1) ) )
               (cdr (assoc "tests" L)) ) ) ) )
   (assoc "testGroups" (in "eddsa_test.json" (readJson))) )
(bye)
