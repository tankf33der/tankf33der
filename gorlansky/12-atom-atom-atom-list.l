#12.1
(de f12-1 (A B C)
   (cons A (cons B (cons C))) )
(test
   '(z zz zzz)
   (f12-1 'z 'zz 'zzz) )

#12.2
(de f12-2 @
   (if (fully oddp? (rest))
      (mapcar '((X) (* X X X)) (rest))
      (apply + (rest)) ) )
(test
   (1 27 125)
   (f12-2 1 3 5) )
(test
   10
   (f12-2 2 3 5) )

#12.3
(de f12-3 (R S W)
   (/ (* R 2 S 1000) W 1000) )
(test
   216
   (f12-3 36 180 60) )

#12.4 - ignored

#12.5
(de f12-5 (A B N)
   (make
      (for (I B (> I N) (dec I))
         (link (range A I)) ) ) )
(test
   '((1 2 3 4 5 6) (1 2 3 4 5) (1 2 3 4))
   (f12-5 1 6 3) )

#12.6
(de f12-6 (A B C)
   (make
      (for (X 10000 (<= X 99999) (inc X))
         (and
            (= C (% X A))
            (= C (% X B))
            (link X) ) ) ) ) 
(test
   (17947 35769 53591 71413 89235)
   (f12-6 133 134 125) )

#12.7
(de f12-7 (A B C)
   (make
      (for (X A (<= X B) (inc X))
         (let R NIL
            (for I (chop X)
               (accu 'R I 1) )
            (and
               (find
                  '((L) (= C (cdr L)))
                  R )
               (link X) ) ) ) ) )
(test
   324
   (length (f12-7 1000 9999 3)) )
(test
   (1111 2222 3333 4444 5555 6666 7777 8888 9999)
   (f12-7 1000 9999 4) )


