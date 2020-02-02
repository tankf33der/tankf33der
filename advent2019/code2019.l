`(== 64 64)
(load "@lib/simul.l")

# --- Day 2: 1202 Program Alarm ---
(de read-code (F)
   (make
      (in F
         (until (eof)
            (link (read))
            (char) ) ) ) )

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
            # uncomment if you want output
            #(4 (println (car Y)))
         )
         (do (if (> (car X) 2) 2 4)
            (++ L) ) ) ) )
(test 15386262 (i5-1 "data/5.txt"))

# part 2
(de i5-2 (*Lst I5)
   (let (X NIL  Y NIL)
      (for (L *Lst L)
         (setq
            X (i5-opcode (car L))
            Y (i5-trampo (cdr X) (cdr L)) )
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
            (3 (set (nth *Lst (inc (cadr L))) (++ I5)))
            (4 (push 'I5 (car Y)))
            (5
               (if (n0 (car Y))
                  (set 'L (nth *Lst (inc (cadr Y))))
                  (do 3
                     (++ L) ) ) )
            (6
               (if (=0 (car Y))
                  (set 'L (nth *Lst (inc (cadr Y))))
                  (do 3
                     (++ L) ) ) )
            (7 (if (< (car Y) (cadr Y))
                  (set (nth *Lst (inc (get L 4))) 1)
                  (set (nth *Lst (inc (get L 4))) 0) ) )
            (8 (if (= (car Y) (cadr Y))
                  (set (nth *Lst (inc (get L 4))) 1)
                  (set (nth *Lst (inc (get L 4))) 0) ) ) )
         (do
            (case (car X)
               ((1 2 7 8) 4)
               ((3 4) 2)
               #((5 6) already incresed above)
            )
            (++ L) ) )
      (car I5) ) )
(test 10376124 (i5-2 (read-code "data/5.txt") (list 5)))
(test 0 (i5-2 (read-code "data/5-test-1.txt") (list 9)))
(test 1 (i5-2 (read-code "data/5-test-1.txt") (list 8)))
(test 0 (i5-2 (read-code "data/5-test-1.txt") (list 7)))
(test 0 (i5-2 (read-code "data/5-test-2.txt") (list 9)))
(test 0 (i5-2 (read-code "data/5-test-2.txt") (list 8)))
(test 1 (i5-2 (read-code "data/5-test-2.txt") (list 7)))
(test 0 (i5-2 (read-code "data/5-test-3.txt") (list 9)))
(test 1 (i5-2 (read-code "data/5-test-3.txt") (list 8)))
(test 0 (i5-2 (read-code "data/5-test-3.txt") (list 7)))
(test 0 (i5-2 (read-code "data/5-test-4.txt") (list 9)))
(test 0 (i5-2 (read-code "data/5-test-4.txt") (list 8)))
(test 1 (i5-2 (read-code "data/5-test-4.txt") (list 7)))
(test 0 (i5-2 (read-code "data/5-test-5.txt") (list 0)))
(test 1 (i5-2 (read-code "data/5-test-5.txt") (list 10)))
(test 0 (i5-2 (read-code "data/5-test-6.txt") (list 0)))
(test 1 (i5-2 (read-code "data/5-test-6.txt") (list 10)))

# --- Day 7: Amplification Circuit ---
(de i7-wrap (Prg C)
   (let R (i5-2 (copy Prg) (list (car C) 0))
      (for N (cdr C)
         (setq R (i5-2 (copy Prg) (list N R))) )
      R ) )
(de i7-1 (F)
   (let Prg (read-code F)
      (maxi
         '((L) (i7-wrap Prg L))
         (permute (range 0 4)) )
      @@ ) )
(test 43210 (i7-1 "data/7-test-1.txt"))
(test
   43210
   (i7-wrap (read-code "data/7-test-1.txt") (range 4 0)))
(test
   54321
   (i7-wrap (read-code "data/7-test-2.txt") (range 0 4)))
(test
   65210
   (i7-wrap (read-code "data/7-test-3.txt") (list 1 0 4 3 2)))
(test 34686 (i7-1 "data/7.txt"))

# warmup pseudo part 2
# *Lst: 3 0 4 0 9
# three wagons, pass input number thru all wagons
# some wagon should halt somehow.
(de wagon (Prg N)
   (co (intern (pack 'w N))
      (let
         (N N
            Send
            (intern
               (pack
                  'w
                  (if (= 3 N) 1 (inc N))))
            *Lst (copy Prg) )
         (for (L *Lst L)
            (T (= 9 (car L)) (yield 567))   # halt
            (case (car L)
               (3
                  (set (nth *Lst (inc (cadr L))) (yield))
                  (inc *Lst) )
               (4
                  (if (= 3 N) (inc *Lst))
                  (yield (get *Lst (inc (cadr L))) Send)) )
            (++ L)
            (++ L) ) ) ) )
(setq *W7 (list 3 0 4 0 9))
(wagon (copy *W7) 1)
(wagon (copy *W7) 2)
(wagon (copy *W7) 3)
(test 567 (yield 7 'w1))

# part 2
(de i7-wagon (Prg N)
   (co (intern (pack 'i7 N))
      (let
         (*Lst (copy Prg)
            N N
            Send
            (intern
               (pack
                  'i7
                  (if (= 5 N) 1 (inc N)) ) )
            X NIL
            Y NIL
            Wait NIL
         )
         (for (L *Lst L)
            (setq
               X (i5-opcode (car L))
               Y (i5-trampo (cdr X) (cdr L)) )
            (println 'for N X Y (less L) Wait)
            (T (= 9 (car X)) (println 'boom))    # halt
            (case (car X)
               (1
                  (set
                     (nth *Lst (inc (get L 4)))
                     (apply + Y) ) )
               (2
                  (set
                     (nth *Lst (inc (get L 4)))
                     (apply * Y) ) )
               (3
                  (when Wait
                     (println 'sending Wait Send)
                     (set
                        (nth *Lst (inc (cadr L)))
                        (yield Wait Send) )
                     (off Wait)
                  )
                  #(set (nth *Lst (inc (cadr L))) (yield))
                  #(println N 'in *Lst)
               )
               (4
                  #(println N 'out *Lst)
                  #(yield (get *Lst (inc (cadr L))) Send)
                  (setq Wait (get *Lst (inc (cadr L))))
               )

               (5
                  (if (n0 (car Y))
                     (set 'L (nth *Lst (inc (cadr Y))))
                     (do 3
                        (++ L) ) ) )
               (6
                  (if (=0 (car Y))
                     (set 'L (nth *Lst (inc (cadr Y))))
                     (do 3
                        (++ L) ) ) )
               (7 (if (< (car Y) (cadr Y))
                     (set (nth *Lst (inc (get L 4))) 1)
                     (set (nth *Lst (inc (get L 4))) 0) ) )
               (8 (if (= (car Y) (cadr Y))
                     (set (nth *Lst (inc (get L 4))) 1)
                     (set (nth *Lst (inc (get L 4))) 0) ) ) )
            #(println 'case *Lst)
            (do
               (case (car X)
                  ((1 2 7 8) 4)
                  ((3 4) 2)
                  #((5 6) already incresed above)
               )
               (++ L) )
         ) #for
))) # let-co-de

(setq *I77 (read-code "data/7-test-4.txt"))
(i7-wagon *I77 1)
(i7-wagon *I77 2)
(i7-wagon *I77 3)
(i7-wagon *I77 4)
(i7-wagon *I77 5)

(yield 9 'i71)
(yield 8 'i72)
(yield 7 'i73)
(yield 6 'i74)
(yield 5 'i75)

(println  (yield 0 'i71))


(msg 'ok)
(bye)

