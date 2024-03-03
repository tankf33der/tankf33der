(off R)
(in "weather_stations.csv"
   (until (eof)
      (let (A (prog1 (till ";" T) (char))  B (format (line T) 4))
         (ifn (idx 'R A T)
            (set A (list 1 B B B))
            (let Lst (val (car @))
               (inc Lst)
               (when (< B (cadr Lst)) (set (cdr Lst) B))
               (when (> B (cadddr Lst)) (set (cdddr Lst) B))
               (inc (cddr Lst) B) ) ) ) ) )

# (9 -346000 639952 379905)
(println (caar (idx 'R "San Rafael")))

(msg 'ok)
(bye)
