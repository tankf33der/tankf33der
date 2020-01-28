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
         (if (=0 A) (get *Lst (inc B)) B) )
      L1
      L2 ) )
(de i5-1 (F)
   (let (*Lst (read-code F)  X NIL  Y NIL)
      (for (L *Lst L)
         (setq
            X (i5-opcode (car L))
            Y (i5-trampo (cdr X) (cdr L)) )
         (T (= 9 (car X)) (cadr L))    # halt
         #(println (less L) 'X X 'Y Y)
         (case (car X)
            (1
               (set
                  (nth *Lst (inc (get L 4)))
                  (apply + Y) ) )
            (2
               (set
                  (nth *Lst (inc (get L 4)))
                  (apply * Y) ) )
            (3 (set (nth *Lst (inc (cadr L))) *I5))
            (4 (println (car Y)))
         )
         (do (if (> (car X) 2) 2 4)
            (++ L) ) ) ) )
#(test 15386262 (i5-1 "data/5.txt"))


# part 2
(de i5-2 (F *I5)
   (let (*Lst (read-code F)  L *Lst  X NIL  Y NIL)
      (loop
         (setq
            X (i5-opcode (car L))
            Y (i5-trampo (cdr X) (cdr L)) )
         #(println (less L) 'X X 'Y Y *I5)
         #(wait 300)
         (T (= 9 (car X)))    # halt
         (case (car X)
            (1
               (set
                  (nth *Lst (inc (get L 4)))
                  (apply + Y) ) )
            (2
               (set
                  (nth *Lst (inc (get L 4)))
                  (apply * Y) ) )
            (3 (set (nth *Lst (inc (cadr L))) *I5))
            (4 (println '! (car Y)))
            (5
               (if (n0 (car Y))
                  (set 'L (nth *Lst (inc (cadr Y))))
                  (do 3 (++ L)) )
            )
            (6
               (if (=0 (car Y))
                  (set 'L (nth *Lst (inc (cadr Y))))
                  (do 3 (++ L)) )
            )
            (7 (if (< (car Y) (cadr Y))
                  (set
                     (nth *Lst (inc (get L 4)))
                     1 )
                  (set
                     (nth *Lst (inc (get L 4)))
                     0 ) ) )
            (8 (if (= (car Y) (cadr Y))
                  (set
                     (nth *Lst (inc (get L 4)))
                     1 )
                  (set
                     (nth *Lst (inc (get L 4)))
                     0 ) ) )
         )
         (do
            (case (car X)
               ((1 2 7 8) 4)
               ((3 4) 2)
               #((5 6) 3)
            )
            (++ L) )
      )
   )

)


# 10376124
(i5-2 "data/5.txt" 5)
#(i5-2 "data/5-test-1.txt" 8)
#(i5-2 "data/5-test-2.txt" 9)
#(i5-2 "data/5-test-3.txt" 9)
#(i5-2 "data/5-test-4.txt" 7)

#(i5-2 "data/5-test-5.txt" 0)
#(i5-2 "data/5-test-5.txt" 10)

#(i5-2 "data/5-test-6.txt" 10)


(msg 'ok)
(bye)
