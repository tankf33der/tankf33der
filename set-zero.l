(setq Lst (need 3 0))

(for X (0 1 2 4 8 16 32 64 128)
   (map
      '((L)
         (set L X)
         (println Lst)
         (set L 0)
      )
      Lst ) )

(set (nth Lst 3) 128)
(for X (0 1 2 4 8 16 32 64 128)
   (for (L Lst (cdr L) (cdr L))
      (set L X)
      (println Lst)
      (set L 0) ) )

(msg 'ok)
(bye)
