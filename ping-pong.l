`(== 64 64)

#{
(de pong (N)
   (co 'pong
      (let (N N)
         (yield) # ready
         (while (gt0 N)
            (println 'pong N)
            (yield 'next)
            (dec 'N) )
         NIL ) ) )
(de ping (A B)
   (pong B) # setup
   (while (gt0 A)
      (println 'ping A)
      (pong)
      (dec 'A) )
   (while (pong)) )
}#

# 3 3
# 1 3
# 3 1
# 0 3
# 3 0
# ^ all ok
##(ping 3 0)


(de ring (M N)
   (co (intern (pack 'ring M))
      (let (M M  N (intern (pack 'ring N)))
         (and
            (yield 'ok)
            #(while (gt0 (setq @@ @))
            #   (setq @ (yield (dec @@) N))
            #)
            #(while (gt0 @)
            #   (setq @ (yield (dec @) N))
            #)

            #(while (and (gt0 (setq @@ @)) (yield (dec @@) N)))
            (while (and (gt0 @) (yield (dec @) N))
               #(prog 1) 
            )
   
            M
         )
      )
   )
)
(for
   (L 
      (conc (range 1 503) (cons 1))
      (cdr L) 
      (cdr L) )
   (ring (car L) (cadr L)) )
(println 204 (yield 50000 'ring1))




#(msg 'ok)
(bye)

