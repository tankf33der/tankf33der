# (pilog '((db ploc +Cab 265 @Cab) (val 265 @Cab dloc)) (inc 'Cnt))

(class +Cab +Entity)
(rel p (+Bag) ((+Date)) ((+Time)))
(rel d (+Bag) ((+Date)) ((+Time)))
(rel pcnt (+Ref +Number))
(rel code (+Ref +Number))
(rel ploc (+Ref +Number))
(rel type (+Ref +Number))
(rel amnt (+Number))

(dbs
   (1 +Cab)
   (4 (+Cab p))
   (4 (+Cab d))
   (4 (+Cab pcnt))
   (4 (+Cab code))
   (4 (+Cab ploc))
   (4 (+Cab type)) )

(setq *Pool "10k.db/")
(call "mkdir" "-p" *Pool)
(push '*Bye '(call "rm" "-r" *Pool))
(push '*Fork '(del '(call "rm" "-r" *Pool) '*Bye))
(pool *Pool *Dbs)

(in '("sh" "-c" "cut -c3- /tmp/yellow_tripdata_2017-01.csv | tail -n +3 | sort")
   (create '(+Cab) 'p '(d pcnt code ploc type amnt)
      (let? L (split (line) ",")
         (list
            (list  # p
               ($dat (pack (head 10 (car L))) "-")
               ($tim (pack (nth (++ L) 11))) )
            (list  # d
               ($dat (pack (head 10 (car L))) "-")
               ($tim (pack (nth (++ L) 11))) )
            (format (++ L))  # pcnt
            (format (prog (++ L) (++ L)))  # code
            (format (prog (++ L) (++ L)))  # ploc
            (format (prog (++ L) (++ L)))  # type
            (format (get L 7) 2) ) ) ) )   # amnt
(msg 'ok)
(bye)



