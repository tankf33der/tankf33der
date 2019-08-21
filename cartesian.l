`(== 64 64)

(load "rosetta/cartesian.l")

(de product (Lst)
   (co 'cartesian
      (let
         (Lst Lst
            Z (need (length Lst) 1)
            Lens (mapcar length Lst)
            N (apply * Lens)
            Flg )
         (yield 'ready)
         (while (ge0 (dec 'N))
            (yield (mapcar get Lst Z))
            (off Flg)
            (let (A Z  B Lens)
               (until Flg
                  (inc A)
                  (ifn (> (car A) (car B))
                     (on Flg)
                     (set A 1)
                     (++ A)
                     (++ B) ) ) ) ) ) ) )
(de cartesian-sum (Lst)
   (let
      (Z (need (length Lst) 1)
         Lens (mapcar length Lst)
         N (apply * Lens)
         S 0
         Flg )
      (while (ge0 (dec 'N))
         (inc
            'S
            (sum prog (mapcar get Lst Z)) )
         (off Flg)
         (let (A Z  B Lens)
            (until Flg
               (inc A)
               (ifn (> (car A) (car B))
                  (on Flg)
                  (set A 1)
                  (++ A)
                  (++ B) ) ) ) )
      S ) )
(de cartesian-maxi (Lst)
   (let
      (Z (need (length Lst) 1)
         Lens (mapcar length Lst)
         N (apply * Lens)
         Max NIL
         Flg )
      (while (ge0 (dec 'N))
         (and
            (>
               (setq @@ (sum prog (mapcar get Lst Z))) 
               Max )
            (setq Max @@) )
         (off Flg)
         (let (A Z  B Lens)
            (until Flg
               (inc A)
               (ifn (> (car A) (car B))
                  (on Flg)
                  (set A 1)
                  (++ A)
                  (++ B) ) ) ) )
      Max ) )



(setq L 
   (list
      (range 1 10)
      (range 10 20)
      (range 1 30)
      (range 1 40) ) )
(product L)
(zero S)
(while (product 'cartesian)   # sum over every list
   (inc 'S (sum prog @)) )
(test
   S
   (sum '((L) (sum prog L)) (apply cartesian L)) )



# prev iter finished.
(setq L '((1 2) (3 4 5)))
(product L)                   # set new iter on smaller lists.
(test 
   (1 3)
   (product 'cartesian) )     # take one number
(co 'cartesian)               # oops, i need bigger list, stop it



(setq L '((1 2) (3 4 5) (100 111)))
(product L)                   # define bigger list, start again
(zero S)
(while (product 'cartesian)   # sum over every list
   (inc 'S (sum prog @)) )   
(test
   S
   (sum '((L) (sum prog L)) (apply cartesian L)) )


# sum over 4M items of product
(setq L (make (do 4 (link (range 1 21)))))
(product L)
(zero S)
(while (product 'cartesian)
   (inc 'S (sum prog @)) ) 
(test
   S
   (cartesian-sum L) )


# adventofcode2015-day13
# Find max sum of items in cartesian product
(setq L '((-25 52 -81) (76 20 -70) (-2 -7 115) (39 87 34)))
(test
   330 
   (cartesian-maxi L) )


(msg 'OK-Cartesian)

