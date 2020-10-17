(scl 16)
(load "@lib/math.l")
(setq *B 7)
(de from_y (Y)
   (let
      (A (* 1.0 (- (* Y Y) *B))
         B (pow (abs A) (*/ 1.0 1.0 3.0)) )
      (list
         (if (gt0 A) B (- B))
         (* Y 1.0) ) ) )
(de prn (P)
   (if (is_zero P)
      "Zero"
      (pack
         (round (car P) 3)
         " "
         (round (cadr P) 3) ) ) )
(de neg (P)
   (list (car P) (*/ -1.0 (cadr P) 1.0)) )
(de is_zero (P)
   (or
      (=T (car P))
      (=T (cadr P))
      (> (length (car P)) 20) ) )
(de dbl (P)
   (if (is_zero P)
      P
      (let
         # Y := (3 * p.x * p.x) / (2 * p.y)
         (Y
            (*/
               1.0
               (*/ 3.0 (car P) (car P) (** 1.0 2))
               (*/ 2.0 (cadr P) 1.0) )
            # x := Y*Y - 2*p.x
            X
            (-
               (*/ Y Y 1.0)
               (*/ 2.0 (car P) 1.0) ) )
         (list
            X
            #y: Y*(p.x-x) - p.y
            (-
               (*/ Y (- (car P) X) 1.0)
               (cadr P) ) ) ) ) )
(de add (A B)
   (cond
      ((= A B) (dbl A))
      ((is_zero A) B)
      ((is_zero B) A)
      (T
         (let Z (- (car B) (car A))
            (if (=0 Z)
               (list T T)
               (let
                  (Y (*/ 1.0 (- (cadr B) (cadr A)) Z)
                     X
                     (- (*/ Y Y 1.0) (car A) (car B)) )
                  (list
                     X
                     (-
                        (*/ Y (- (car A) X) 1.0)
                        (cadr A) ) ) ) ) ) ) ) )
(de mul (P N)
   (let R (list 1.0 1.0)
      (for (I 1 (>= N I) (* I 2))
         # (println 'I I)
         (when (gt0 (& I N))
            # (println "odd?: " I)
            (setq R (add R P)) )
         (setq P (dbl P))
         (println 'P (prn P))
         (println 'R (prn R))
      )
      R
   )
)
(setq
   A (from_y 1)
   B (from_y 2) )
# (prinl "A: " (prn A))
# (prinl "B: " (prn B))
# (setq C (add A B))
# (prinl "C: " (prn C))
# (test "10.375 -33.525" (prn C))
# (setq D (neg C))
# (prinl "D: " (prn D))
# (prinl "D + C: " (prn (add C D)))
# (prinl "A + B + D: " (prn (add A (add B D))))

# (prinl "A * 12345: ", (mul A 12345))
(mul A 12345)

(msg 'ok)
(bye)
