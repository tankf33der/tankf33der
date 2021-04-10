(de left ("N")
   (cond
      ((bit? 1 (val "N")) (inc "N" 2))
      ((== 2 (val "N")) (dec "N"))
      (T (dec "N" 2)) ) )
(de right ("N")
   (cond
      ((not (bit? 1 (val "N"))) (inc "N" 2))
      ((=1 (val "N")) (inc "N"))
      (T (dec "N" 2)) ) )

(let (N 1  Key)
   (do 100
      (setq Key
         (pack 
            (make 
               (link (key))
               (while (key 8)
                  (link @) ) ) ) )
      (if (= Key "^[[D")
         (left 'N)
         (right 'N) )
      (println 'N N) ) )
(msg 'ok)
(bye)
