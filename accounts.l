(scl 2)

(class +Account +Entity)
(rel id        (+Key +Number))
(rel created   (+Date))
(rel active    (+Bool))
(rel username  (+Key +String))
(rel balance   (+Number) 2)
(rel age       (+Number))
(rel notes     (+Blob))

(pool (tmp "account.db"))

(new! '(+Account)
   'id 12345
   'username "John Doe"
   'balance 77.22
   'created (date 2009 5 13) )

(new! '(+Account)
   'id 12346
   'username "Jane Miller"
   'active T
   'created (date 2009 5 14)
   'balance 123.75 )

(println 'start (collect 'id '+Account))

(new! '(+Account)
   'id 12345
   'username "M"
   'balance 77.22
   'created (date 2009 5 13) )

(println 'same-id (collect 'id '+Account))

(new! '(+Account)
   'id 1
   'username "John Doe"
   'balance 77.22
   'created (date 2009 5 13) )
(println 'same-username (collect 'id '+Account))
(more (collect 'id '+Account) show)



(msg 'ok)
(bye)
