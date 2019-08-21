(let X 3
   (loop
      (do X
         (prin
            (intern 
               (pack (mapcar char (83 109 105 108 101 33))) ) ) )
      (prinl)
      (NIL (gt0 (dec 'X))) ) )
(bye)
