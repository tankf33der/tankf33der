# 29jul20 Software Lab. Alexander Burger
# Use: time bin/picolisp misc/bench2.l -bye

(de tst ()
   (mapcar
      (quote (X)
         (cons
            (car X)
            (reverse (delete (car X) (cdr X))) ) )
      '((a b c a b c) (b c d b c d) (c d e c d e) (d e f d e f)) ) )

(bench (do 1000000 (tst)))
(bye)
