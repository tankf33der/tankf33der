(pool "store.db")
#(println {1} *Dbs *Ext)
(store NIL 12 22)
(store NIL 22 222)
(store NIL "mike" "abc")
(commit)
#(scan NIL '((A B) (println '1 A B)))

(store NIL "mike")
(scan)
(store NIL "mike" "abc")


(println (fetch NIL "mike"))


(msg 'ok)
(bye)
