# --- Day 2: 1202 Program Alarm ---
(de read-code (F)
   (make
      (in F
         (until (eof)
            (link (read))
            (char) ) ) ) )
#{
(de i2-1 (Lst X Y)
   (set (cdr Lst) X  (cddr Lst) Y)
   (for (L Lst L)
      (T (> (car L) 2))
      (set
         (nth Lst (inc (get L 4)))
         ((if (=1 (car L)) '+ '*)
            (get Lst (inc (get L 2)))
            (get Lst (inc (get L 3))) ) )
      (do 4
         (++ L) ) )
   (car Lst) )
(setq *I2-Lst (read-code "data/2.txt"))
(test 5482655 (i2-1 (copy *I2-Lst) 12 2))

# part2
(de i2-gen NIL
   (co 'i2-gen
      (for X 99
         (for Y 99
            (yield (cons X Y)) ) ) ) )
(de i2-2 NIL
   (loop
      (setq @@ (i2-gen))
      (T
         (=
            19690720
            (i2-1 (copy *I2-Lst) (car @@) (cdr @@)) ) ) )
   (+ (cdr @@) (* 100 (car @@))) )
(test 4967 (i2-2))
}#

# --- Day 5: Sunny with a Chance of Asteroids ---
# Legend:
# 1 3ops +
# 2 3ops *
# 3 1op *I5 -> pos
# 4 1op print *I5
# 99 0opts 'halt
####
(one *I5)   # input reg
(de i5-opcode (N)
   (let N (mapcar format (flip (chop (pad 4 N))))
      (conc (cons (car N)) (cddr N)) ) )
(de i5-trampo (L1 L2)
   (mapcar
      '((A B)
         (if (=0 A)
            (get Lst (inc B))
            B ) )
      L1
      L2 ) )
(de i5-1 (Lst)
   (use (X Y)
   (for (L Lst L)
      (setq
         X (i5-opcode (car L))
         Y (i5-trampo (cdr X) (cdr L)) )
      (T (= 9 (car X)))    # halt
      (case (car X)
         (1
            (set
               (nth Lst (inc (get L 4)))
               (apply + Y) ) )
         (2
            (set
               (nth Lst (inc (get L 4)))
               (apply * Y) ) )
         (3
            (set (nth Lst (inc (car Y))) *I5) )
         (4
            (println (car Y)) )
      )
      (do (if (> (car X) 2) 2 4)
         (++ L) )
      (println 'loop)
   ))
)
(setq *I5-Lst (read-code "data/5.txt"))
(i5-1 *I5-Lst)
# XXX bnd Lst

(msg 'ok)
(bye)
