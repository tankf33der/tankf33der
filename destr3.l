(de mike1 ("Lst")
   (inc "Lst") )
(let (L (22 23)  A 123)
   (mike1 L)
   (test (23 23) L)
   (test A 123) )

(msg 'new)

(de mike2 ("Lst")
   (mike1 "Lst")
   (map
      '((A B) (set A (x| (car A) (car B))))
      "Lst"
      (range 1 1024) ) )
(let (L (22 33)  A 123)
   (mike2 L)
   (test (22 35) L)
   (test A 123) )

(msg 'new)

(let (L (44 33)  A 123)
   (mike1 L)
   (mike2 L)
   (test (47 35) L)
   (test A 123) )

(msg 'new)

(de mike3 ("Lst")
   (do 10
      (mike1 "Lst") )
   (mike2 "Lst") )
(let (L (78 22)  A 123)
   (mike3 L)
   (test (88 20) L)
   (test A 123) )

(msg 'new)

(de mike4 ("Lst")
   (mike1 "Lst")
   (set 'A 777) #bnd
)
(let (L (78 22)  A 123)
   (mike4 L)
   (test (79 22) L)
   (test A 777) )

(msg 'new)
(de blockmix (Lst)
   (let (X (tail 16 Lst)  L NIL)
      (setq L
         (make
            (for (Z (nth Lst 1) Z (nth (cdr Z) 16))
               #(setq X (mapcar x| X Z))
               (map '((A B) (set A (x| (car A) (car B))))
                  X
                  Z )
               (link X) 
) ) )

##))
      (conc
          (make
            (for (I . X) Lst
               (and (bit? 1 I) (chain X)) ) ) 
         (make
            (for (I . X1) Lst
               (or (bit? 1 I) (chain X)) ) ) ) ) )
   
(de smix (Lst N)
   (let L NIL
      (setq L
         (make
            (for Y N
               (println 'Y Y Lst)
               (link Lst)
               (setq Lst (blockmix Lst)) ) ) )
      Lst ) )
#(println (smix (range 1 32) 8))
# HANGS
#(println
#   (blockmix (range 1 32)))

(msg 'mike5)
(de mike5 (Lst)
   (let L (make (for N 8 (link (range N 16))))
      (conc
         (make
            (for (I . X) L
               (and (bit? 1 I) (chain X)) ) )
         (make
            (for (I . X) L
               (or (bit? 1 I) (chain X)) ) ) ) ) ) 
(println (mike5 (range 1 16)))
  
 
(msg 'ok)
(bye)
