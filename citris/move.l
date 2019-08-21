(seed (in "/dev/urandom" (rd 8)))

(de world (X Y)
   (make (do X (link (need Y '\#)))) )
(de pressed @
   (pack
      (make
         (link (key))
         (while (key 50)
            (link @) ) ) ) )
(de display (G P) # one.l
   (set (nth G (car P) (cadr P)) 'X)
   (mapc prinl G)
   (do 2
      (prinl) ) )
(de go @
   (let
      (G (world 10 10)
         P (list (rand 1 10) (rand 1 10)) )
      (display G P)
      (loop
         (set (nth G (car P) (cadr P)) '\#) 
         (case (pressed)
            ("^[[D"
               (and (> (cadr P) 1) (dec (cdr P))) )
            ("^[[C"
               (and (< (cadr P) 10) (inc (cdr P))) )
            ("^[[A" (and (> (car P) 1) (dec P)) )
            ("^[[B" (and (< (car P) 10) (inc P)) )
            (T) )
      (display G P) ) ) )
(go)
(bye)

