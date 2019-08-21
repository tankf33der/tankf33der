#4A
(de perfect (N)
   (let (C 1  Stop (sqrt N))
      (for (I 2 (<= I Stop) (inc I))
         (and
            (=0 (% N I))
            (inc 'C (+ (/ N I) I)) ) )
      (= C N) ) )
(de 4a (M N)
   (make
      (for (X M (<= X N) (inc X))
         (and (perfect X) (link X) ) ) ) )
(test (6) (4a 6 6))
(test (6 28 496) (4a 6 496))
(test
   (33550336)
   (4a 33550000 33551000) ) 

#4B
# http://jeromekelleher.net/partitions.php
(de 4b (N)
   (let
      (L (need (inc N) 0)
         K 2 
         X 0
         Y 0
         R NIL )
      (set (nth L K) N)
      (while (<> 1 K)
         (setq 
            X (inc (car (nth L (dec K))))
            Y (dec (car (nth L K))) )
         (dec 'K)
         (while (<= X Y)
            (set (nth L K) X)
            (dec 'Y X)
            (inc 'K) )
         (set (nth L K) (+ X Y))
         (push 'R (head K L)) )
      (cdr R) ) )

(test
   '((2 2) (1 3) (1 1 2) (1 1 1 1))
   (4b 4) )
