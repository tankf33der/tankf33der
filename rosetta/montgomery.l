
# X power Y modulus N
# from rsa.l
(de **Mod (X Y N)
   (let M 1
      (loop
         (when (bit? 1 Y)
            (setq M (% (* M X) N)) )
         (T (=0 (setq Y (>> 1 Y))) M)
         (setq X (% (* X X) N)) ) ) )
(de rrm (M)
   (% (>> (- (* 2 Mbins)) 1) M) )
(de reduce (A)
   (do Mbins
      (and (bit? 1 A) (inc 'A M))
      (setq A (>> 1 A)) )
   (and (>= A M) (dec 'A M))
   A )
(let 
   (M 750791094644726559640638407699
      Mbins (length (bin M))
      RRM (rrm M)
      X1 540019781128412936473322405310
      X2 515692107665463680305819378593 
      T1 (* X1 RRM)
      T2 (* X2 RRM)
      R1 (reduce T1)
      R2 (reduce T2)
      R (>> (- Mbins) 1)
      Prod (reduce RRM)
      Base (reduce (* X1 RRM))
      Exp X2 )
   (test RRM 598433309008759715574391739610)
   (test T1 323165824550862327179367294465482435542970161392400401329100)
   (test T2 308607334419945011411837686695175944083084270671482464168730)
   (test R1 440160025148131680164261562101)
   (test R2 435362628198191204145287283255)
   (test R 1267650600228229401496703205376)
   (test X1 (reduce R1))
   (test X2 (reduce R2))

#{
   (println 'b ': 2)
   (println 'n ': Mbins)
   (println 'r ': R)
   (println 'm ': M)
   (println 't1 ': T1)
   (println 't2 ': T2)
   (println 'r1 ': R1)
   (println 'r2 ': R2)
   (prinl)
   (prinl "Original x1       : " X1)
   (prinl "Recovered from r1 : " (reduce R1))
   (prinl "Original x2       : " X2)
   (prinl "Recovered from r2 : " (reduce R2))
   (prinl)
   (prin "Montgomery computation of x1 \^ x2 mod m : ")
}#

   (while (gt0 Exp)
      (and
         (bit? 1 Exp)
         (setq Prod (reduce (* Prod Base))) )
      (setq 
         Exp (>> 1 Exp)
         Base (reduce (* Base Base)) ) )
#{
   (prinl (reduce Prod))
   (prinl "Montgomery computation of x1 \^ x2 mod m : " (**Mod X1 X2 M))
}#
   (test 
      T
      (=
         151232511393500655853002423778
         (reduce Prod)
         (**Mod X1 X2 M) ) ) )
(msg 'OK-Montgomery)
#(bye)
