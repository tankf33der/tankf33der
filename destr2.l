(setq X 0  Y 0)
(zero X)
(zero Y)

(de f1 (A B)
   (set A (inc B)) )
(test (list X Y) (0 0))
(f1 'X 'Y)
(test (list X Y) (1 1))

(de f2 (A)
   (set 'Y A) )
(test (list X Y) (1 1))
(f2 22)
(test (list X Y) (1 22))

(de f3 (Y)
   (set 'Y 777) ) 
(test (list X Y) (list 1 22))
(f3 Y)
(test (list X Y) (list 1 22))

(de f3-1 (Y X)
   (set Y X) )
(test (list X Y) (list 1 22))
(f3-1 'Y 555)
(test (list X Y) (list 1 22))

(de f3-1-1 ("Y" X) # the most important
   (set "Y" X) )
(test (list X Y) (list 1 22))
(f3-1-1 'Y 555)
(test (list X Y) (list 1 555))

(de f3-1-2 ("Y" X)
   (set '"Y" X) )
(test (list X Y) (list 1 555))
(f3-1-2 Y X)
(test (list X Y) (list 1 555))

(de f3-2 (A)
   (set 'Y A) )
(test (list X Y) (list 1 555))
(f3-2 777)
(test (list X Y) (1 777))

(de f3-3 (X)
   (set X 444) )
(test (list X Y) (list 1 777))
(f3-3 'Y)
(test (list X Y) (1 444))

(setq X (range 1 3))
(de f4 (X)
   (set (cdr X) 777) )
(test (1 2 3) X)
(f4 X)
(test (1 777 3) X)

(de f4-2 (Y)
   (set Y 555) )
(test (1 777 3) X)
(f4-2 X)
(test (555 777 3) X)

(de f4-3 ("Y")
   (set "Y" 333) )
(test (555 777 3) X)
(f4-3 X)
(test (333 777 3) X)


(msg 'OK-destr)

