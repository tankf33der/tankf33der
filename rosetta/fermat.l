(de fermat (N)
   (inc (** 2 (** 2 N))) )
(for (N 0 (>= 9 N) (inc N))
   (println N ': (fermat N)) )



(msg 'ok)
(bye)
