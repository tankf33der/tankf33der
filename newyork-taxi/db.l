(class +Cab +Entity)
(rel pd (+Aux +Ref +Date) (pt))
(rel pt (+Ref +Time))
(rel dd (+Aux +Ref +Date) (dt))
(rel dt (+Ref +Time))
(rel pcnt (+Ref +Number))
(rel code (+Ref +Number))
(rel ploc (+Ref +Number))
(rel type (+Ref +Number))
(rel amnt (+Number))

(dbs
   (0 +Cab)
   (4 (+Cab pd pt))
   (4 (+Cab dd dt))
   (4 (+Cab pcnt))
   (4 (+Cab code))
   (4 (+Cab ploc))
   (4 (+Cab type)) )

(setq *Pool "10k.db/")
(call "mkdir" "-p" *Pool)
(pool *Pool *Dbs)

