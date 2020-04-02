(de numbers NIL
   (co 'numbers
      (let N 7
         (for P N
            (for S N
               (for F N
                  (yield (list P S F)) ) ) ) ) ) )
(de departments NIL
   (use (L)
      (while (setq L (numbers))
         (or
            (bit? 1 (car L))
            (= (car L) (cadr L))
            (= (car L) (caddr L))
            (= (cadr L) (caddr L))
            (<> 12 (apply + L))
            (println L) ) ) ) )
(departments)
(msg 'ok)
(bye)

#{
(be departments (@Pol @Fire @San)
   (member @Pol (2 4 6))
   (for @Fire 1 7)
   (for @San 1 7)
   (different @Pol @Fire)
   (different @Pol @San)
   (different @Fire @San)
   (^ @
      (= 12
         (+ (-> @Pol) (-> @Fire) (-> @San)) ) ) )

Test

: (? (departments @Police @Fire @Sanitation))
 @Police=2 @Fire=3 @Sanitation=7
 @Police=2 @Fire=4 @Sanitation=6
 @Police=2 @Fire=6 @Sanitation=4
 @Police=2 @Fire=7 @Sanitation=3
 @Police=4 @Fire=1 @Sanitation=7
 @Police=4 @Fire=2 @Sanitation=6
 @Police=4 @Fire=3 @Sanitation=5
 @Police=4 @Fire=5 @Sanitation=3
 @Police=4 @Fire=6 @Sanitation=2
 @Police=4 @Fire=7 @Sanitation=1
 @Police=6 @Fire=1 @Sanitation=5
 @Police=6 @Fire=2 @Sanitation=4
 @Police=6 @Fire=4 @Sanitation=2
 @Police=6 @Fire=5 @Sanitation=1
-> NIL
}#

