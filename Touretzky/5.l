#5.1
(de good-style (P) # WTF?
   (let Q (+ P 5)
      (list 'result 'is Q) ) )
(test
   '(result is 10)
   (good-style 5) )

#5.2-5.5 - ignored

#5.6
# a
(de throw-die ()
   (rand 1 6) )

# b
(de throw-dice ()
   (list (throw-die) (throw-die)) )

# c
# (= (1 1) L) 
(de snake-eyes-p (L)
   (= 1 (car L) (cadr L)) )
(de boxcars-p (L)
   (= 6 (car L) (cadr L)) )

# d
(de sum-dice (L)
   (+ (car L) (cadr L)) )
(de instant-win-p (N)
   (or (= 7 N) (= 11 N)) )
(de instant-loss-p (N)
   (or
      (= 2 N)
      (= 3 N)
      (= 12 N) ) )

# e
(de say-throw (L)
   (let L (sum-dice L)
      (cond
         ((= 2 L) 'snake-eyes)
         ((= 12 L) 'boxcars)
         (T L) ) ) )

# f
(de craps ()
   (let (D (throw-dice)  S (sum-dice D))
      (conc
         (list 'throw)
         (list (car D) 'and (cadr D) '--)
         (cond
            ((instant-win-p S)
               (list (say-throw D) '-- 'you 'win) )
            ((instant-loss-p S)
               (list (say-throw D) '-- 'you 'lose) )
            (T (list 'your 'point 'is S)) ) ) ) )

# g - ignored

(test
   T
   (and
      (<= 1 (setq @@ (throw-die)))
      (>= 6 @@) ) )
(test
   T
   (and
      (= 2 (length (setq @@ (throw-dice))))
      (<= 1 (car @@)) ) )
(test
   T
   (flg? (snake-eyes-p (throw-dice))) )
(test
   T
   (flg? (boxcars-p (throw-dice))) )
(test
   T
   (flg?
      (instant-win-p
         (sum-dice (throw-dice)) ) ) )
(test
   T
   (flg?
      (instant-loss-p
         (sum-dice (throw-dice)) ) ) )
(test
   'snake-eyes
   (say-throw (1 1)) )
(test
   'boxcars
   (say-throw (6 6)) )
(test
   7
   (say-throw (3 4)) )

