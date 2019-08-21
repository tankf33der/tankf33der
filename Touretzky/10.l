#10.1-10.2 - ignored

#10.3
(off *FRIENDS)
(zero *FRIENDS-COUNT)
(de meet (P)
   (cond
      ((== P (car *FRIENDS))
         (inc '*FRIENDS-COUNT)
         'we-just-met )
      ((member P *FRIENDS)
         (inc '*FRIENDS-COUNT)
         'we-know-each-other )
      (T
         (push '*FRIENDS P)
         'pleased-to-meet-you ) ) )
(test
   'pleased-to-meet-you
   (meet 'mike) )
(test
   'pleased-to-meet-you
   (meet 'lena) )
(test
   'we-just-met
   (meet 'lena) )
(test 1 *FRIENDS-COUNT)

#10.4
(de forget (P)
   (if (member P *FRIENDS)
      (setq *FRIENDS (delete P *FRIENDS))
      'unknown ) )
(test #10.3
   '(lena mike)
   *FRIENDS )
(test
   'unknown
   (forget 'nick) )
(test
   '(lena)
   (forget 'mike) )

#10.5-10.8 - ignored

#10.9
(de my-chop-1 (L)
   (and L (cons (car L))) )
(de my-chop-2 (L) # Destructive
   (and L (con L)) )
(test (1) (my-chop-1 (1 2 3)))
(let L (1 2 3)
   (my-chop-2 L)
   (test (1) L) )

#10.10
(de ntack (L I)
   (conc L (cons I)) )
(let L (1 2 3)
   (ntack L 44)
   (test (1 2 3 44) L) )

#10.11-10.12 - ignored

