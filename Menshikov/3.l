#3A - rosetta
(de 3a (N)
   (make
      (let (D 2  L (1 2 2 . (4 2 4 2 4 6 2 6 .))  M (sqrt N))
         (while (>= M D)
            (if (=0 (% N D))
               (setq M (sqrt (setq N (/ N (link D)))))
               (inc 'D (pop 'L)) ) )
         (link N) ) ) )
(test
   (2 3 5)
   (3a 30) )
(test
   (2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3)
   (3a 1610612736) )
(test
   (2 1073741783)
   (3a 2147483566) )

#3B
(de 3b (Lst)
   (uniq (2b Lst)) )
(test
   '(AB BA)
   (3b (chop "AB")) )
(test
   (122 212 221)
   (uniq (2b (chop 122))) )

#3C
(de mini0 (F L)
   (let M T
      (for I L
         (and
            (setq @@ (F I))
            (< @@ M)
            (setq M @@) ) )
      (if (=T M) 0 M) ) )
(de maxi0 (F L)
   (let M NIL
      (for I L
         (and
            (setq @@ (F I))
            (> @@ M)
            (setq M @@) ) )
      (if M @ 0) ) )
(de 3c (Sum Lst) 
   (let (Min NIL  Max NIL)
      (cacheset 'Min 0 0)
      (cacheset 'Max 0 0)
      (for W Sum
         (cacheset
            'Min
            W
            (mini0
               '((L)
                  (cond
                     ((= (cdr L) W) (car L))
                     ((< (cdr L) W)
                        (let N (val (cache 'Min (- W (cdr L))))
                           (and (gt0 N) (+ N (car L))) ) ) ) )
               Lst ) )
         (cache
            'Max
            W
            (maxi0
               '((L)
                  (cond
                     ((= (cdr L) W) (car L))
                     ((< (cdr L) W)
                        (let N (val (cache 'Max (- W (cdr L))))
                           (and (gt0 N) (+ N (car L))) ) ) ) )
               Lst ) ) )
      (let 
         (X (val (cache 'Min Sum))
            Y (val (cache 'Max Sum)) )
         (and (gt0 X) (gt0 Y) (cons X Y)) ) ) )

(test
   (100 . 250)
   (3c 100 '((1 . 1) (5 . 2))) )
(test
   (10 . 16)
   (3c 10 '((6 . 3) (2 . 2))) )
(test
   NIL
   (3c 1000 '((10 . 3))) )

#3D - ignored

#3E - ignored

#3F
(de 3f (N) # rosetta
   (let 
      ("Grid" (grid N N)
         D '(north west south east .)
         E '(north east .)
         This 'a1 )
      (mapc
         '((G)
            (mapc '((This) (=: "val" NIL)) G) )
         "Grid" )
      (for Val (* N N)
         (=: "val" Val)
         (setq This
            (or
               ((cadr D) ((car D) This))
               (prog
                  (setq D (cddr D))
                  ((pop 'E) This) )
               ((pop 'E) This) ) ) ) 
      ##(disp "Grid" 0 '((This) (align 3 (: "val"))))
      (mapcar
         '((L) (mapcar '((This) (: "val")) L))
         "Grid" ) ) )
(test
   (quote
      (1 2 6)
      (3 5 7)
      (4 8 9) )
   (3f 3) )
(test
   (quote
      ( 1  2  6  7 15)
      ( 3  5  8 14 16)
      ( 4  9 13 17 22)
      (10 12 18 21 23) 
      (11 19 20 24 25) )
   (3f 5) )
