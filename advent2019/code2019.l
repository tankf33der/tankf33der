`(== 64 64)
(load "@lib/simul.l")

# --- Day 2: 1202 Program Alarm ---
(de read-code (F)
   (make
      (in F
         (until (eof)
            (link (read))
            (char) ) ) ) )
# set
(de s ("Var" I V F)
   (let K (char (hash I))
      (if (idx "Var" K)
         (set (car @) V)
         (set K V)
         (put K 'p I)
         (idx "Var" K T) ) ) )
# get
(de g ("Var" I)
   (let K (char (hash I))
      (if (idx "Var" K) (val (car @)) 0) ) )
# create
(de c ("Var" Lst)
   (for (I . N) Lst
      (s 'R (dec I) N T) ) )
(de sorted ("Var")
   (mapcar
      val
      (by
         '((C) (get C 'p))
         sort
         (idx "Var") ) ) )
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

# variation
(de i2-1-2 (Lst X Y)
   (set (cdr Lst) X  (cddr Lst) Y)
   (let R NIL
      (c 'R Lst)
      (for (L Lst L)
         (T (= 99 (car L)))
         (s
            'R
            (cadddr L)
            ((if (=1 (car L)) '+ '*)
               (g 'R (cadr L))
               (g 'R (caddr L)) ) )
         (do 4
            (++ L) ) )
      (car (sorted 'R)) ) )
(test 5482655 (i2-1-2 (read-code "data/2.txt") 12 2))

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
      (conc (cons (if (= 9 (car N) (cadr N)) 99 (car N))) (cddr N)) ) )
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
         (T (= 99 (car X)) (cadr L))    # halt
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
            #/ uncomment if you want output
            #(4 (println (car Y)))
         )
         (do (if (> (car X) 2) 2 4)
            (++ L) ) ) ) )
(test 15386262 (i5-1 "data/5.txt"))

# part 2
(de i5-2 (*Lst I5)
   (let (X NIL  Y NIL  *Base 0)
      (for (L *Lst L)
         (setq
            X (i5-opcode (car L))
            Y (i5-trampo (cdr X) (cdr L)) )
         (T (= 99 (car X)))    # halt
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
                  (set (nth *Lst (inc (get L 4))) 0) ) )
            (9 (setq *Base (car Y)))
         )#case
         (do
            (case (car X)
               ((1 2 7 8) 4)
               ((3 4 9) 2)
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

# XXX
#{
(de s ("Var" I V)
   (let K (char (hash I))
      (if (idx "Var" K)
         (set (car @) V)
         (set K V)
         (idx "Var" K T) ) ) )
(de g ("Var" I)
   (let K (char (hash I))
      (if (idx "Var" K)
         (val (car @))
         0 ) ) )
# try rewrite from scratch
(de i5-mode ("Var" M N X)
   (if (=1 (% (/ M X) 1))
      N
      (g "Var (g "Var" N)) ) )
(de i5-first ("Var" M N)
   (i5-mode "Var" M N 100) )
(de i5-second ("Var" M N)
   (i5-mode "Var" M N 1000) )
(de i5-3 (Lst I)
   (let (Op NIL  R NIL)
      (for (I . N) Lst
         (s 'R (dec I) N) )
      (for (L Lst L)
         (setq Op (% (car L) 100))
         (T (= 99 Op))
         (case Op
            (1
               (s 'R
                  (g 'R (cadddr L))
                  (+
                     (i2-first 'R (car L) (cadr L)))
                     (i2-second 'R (car L) (caddr L))) ) ) )
            (2
               (s 'R
                  (g 'R (cadddr L))
                  (*
                     (i2-first

}#
#{
(setq *W (read-code "data/2.txt"))
(off R)
(for (I . N) *W
   (s 'R (dec I) N) )
(println *W)
(println (mapcar val (idx 'R)))
}#

#{
(off R)
(s 'R 33 1)
(test 1 (g 'R 33))
(s 'R 1 1122)
(test 1122 (g 'R 1))
#(println R)
}#

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
(de i7-runner (Prg N)
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
            Wait NIL )
         (for (L *Lst L)
            (setq
               X (i5-opcode (car L))
               Y (i5-trampo (cdr X) (cdr L)) )
            (T (= 99 (car X)) (yield Wait Send))    # halt&send
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
                  (if Wait
                     (prog
                        (set
                           (nth *Lst (inc (cadr L)))
                           (yield Wait Send) )
                        (off Wait) )
                     (set (nth *Lst (inc (cadr L))) (yield)) ) )
               # let be this way
               (4 (setq Wait (get *Lst (inc (cadr L)))))
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
               (++ L) ) ) ) ) )
(de i7-wagon (Lst Phase)
   (let W
      (make
         (for N 5
            (link (intern (pack 'i7 N)) ) ) )
      (for N 5
         (i7-runner Lst N) )
      (mapc '((A B) (yield A B)) Phase W)
      (prog1 (yield 0 'i71) (mapc co W)) ) )
(de i7-2 (F)
   (let Prg (read-code F)
      (maxi
         '((L) (i7-wagon Prg L))
         (permute (range 5 9)) )
      @@ ) )

(setq *I77 (read-code "data/7-test-4.txt"))
(test 139629729  (i7-wagon *I77 (list 9 8 7 6 5)))
(setq *I77 (read-code "data/7-test-5.txt"))
(test 18216 (i7-wagon *I77 (list 9 7 8 5 6)))
(test 36384144 (i7-2 "data/7.txt"))

# --- Day 9: Sensor Boost ---

(msg 'ok)
(bye)
