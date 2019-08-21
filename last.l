(use (R L H D)
   (in "wtmp.txt"
      (until (eof)
         (setq L (intern (till " " T)))
         (skip)
         (till " ")
         (skip)
         (setq H (intern (till " " T)))
         (skip)
         (setq D (till "^J" T))
         (if (assoc H R)
            (unless (assoc L (cadr @))
               (queue (cdr @) (list L D)) )
            (push 'R (list H (list (list L D)))) )
         (skip) ) )
   (for I
      (filter
         '((L)
            (< 1 (length (cadr L))) )
         R )
      (println (caar I))
      (for J (cadr I)
         (prin "^I")
         (println J) ) ) )
      
(bye)

