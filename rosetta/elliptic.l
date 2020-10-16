(scl 6)
(load "@lib/math.l")
(setq *B 7)
(de from_y (Y)
   (let
      (A (* 1.0 (- (* Y Y) *B))
         B (pow (abs A) 0.3333) )
      (list
         (if (gt0 A) B (- B))
         (* Y 1.0) ) ) )
(de prn (P)
   (pack
      (format (car P) *Scl)
      " "
      (format (cadr P) *Scl) ) )
(de neg (P)
   (list (car P) (*/ -1.0 (cadr P) 1.0)) )
(de is_zero (P)
   (> (length (car P)) 20) )
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
         (println "add: T: cond" A B)
         (let
            (Y
               # Y := (q.y - p.y) / (q.x - p.x)
               (*/
                  1.0
                  (- (cadr B) (cadr A))
                  (- (car B) (car A)) )
               # x := Y*Y - p.x - q.x
               X
               (-
                  (*/ Y Y 1.0)
                  (car A)
                  (car B) ) )
            (list
               X
               # y: Y*(p.x-x) - p.y
               (-
                  (*/
                     Y
                     (- (car A) X)
                     1.0 )
                  (cadr A) ) )
         )
      )
   )
)
(setq
   A (from_y 1)
   B (from_y 2) )
(prinl "A: " (prn A))
(prinl "B: " (prn B))
(setq C (add A B))
(prinl "C: " (prn C))
(setq D (neg C))
(prinl "D: " (prn D))

(setq E (add C D))
(prinl "D + C: " (prn D))


(msg 'ok)
(bye)
