# 2018, day 6, demo

#(def '*Counts ())
(de day6-1 (f)
    (in f (day6-1-helper (make (until (eof) (link (parse-line-d6)))))))
 
 (de parse-line-d6 ()
     (and (match '(@X "," " " @Y) (line))
          (list (format @X) (format @Y))))
 
 (de day6-1-helper (points)
   (println points)
     (let (Min-x (car (mini car points))
           Max-x (car (maxi car points))
           Min-y (cadr (mini cadr points))
           Max-y (cadr (maxi cadr points))
            *Counts NIL )
       (for (X 0 (>= (+ 10 Max-x) X) (inc X))
           (for (Y 0 (>= (+ 10 Max-y) Y) (inc Y))
                 (let Closest (mini '((P) (+ (abs (- (car P) X)) (abs (- (cadr P) Y)))) points)
                   (println X Y Closest)
                   (wait 100)
                   (unless (or (<> (car Closest) (cadr Closest))
                                 (member (car Closest) '(Min-x Max-x))
                               (member (cadr Closest) '(Min-y Max-y)))
                     (accu '*Counts Closest 1)))))
       (maxi cdr *Counts)))
#(println (day6-1 "advent2018/data/6-test.txt"))
(println (day6-1 "advent2018/data/6.txt"))

(msg 'ok)
(bye)

