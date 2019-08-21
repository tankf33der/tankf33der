# rm -rf 10k.db
# while (true); do du -sh 10k.db; sleep 1; done
# pil create-test.l

# Minimal E/R model
(class +Cls +Entity)          # Class
(rel key (+Key +Number))      # with a unique numeric key,
(rel num (+Ref +Number))      # an indexed number,
(rel str (+Ref +String))      # and an indexed string

(dbs
   (0 +Cls)
   (4 (+Cls key))             # Each index in a different file
   (4 (+Cls num))
   (4 (+Cls str)) )

(setq *Pool "10k.db/")
(call "mkdir" "-p" *Pool)
(pool *Pool *Dbs)


(create '(+Cls) 'key '(num str)
   (co 'go                 # Use a coroutine as generator
      (for Key 100000000   # Key is sorted in input
         (yield            # Return keys, numbers and single-char strings
            (list Key (rand) (char (rand 97 122))) ) ) ) )


(msg 'fin)
(bye)

