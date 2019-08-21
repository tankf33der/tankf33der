# --- Day 9: Marble Mania ---
(de a9-shift (L)
   (let L (copy L)
      (conc (cdr L) (cons (car L))) ) )
(de a9-1 (P M)
   (let (L (list 0)   I 16  D)
      (for N M
         (if (=0 (% N 23))
            # XXX
            #(setq L (a9-shift L))
            (prog
               #(println 'boom (- (length L) 7) I )
               (accu
                  'D
                  (% N P)
                  (+ (get L I) N) )
               (inc 'I 21)
               (setq
                  L (conc (tail 7 L) (head -8 L))
                  L (a9-shift L) ) 
            ) # prog
            (setq L (a9-shift L))
            (conc L (cons N)) 
            # XXX
            #(queue 'L N)
         ) 
         #(println L)
      )
      (cdr (maxi cdr D)) 
      #L
   ) )
(de mar-shift NIL
   (made (conc (cdr (made)) (cons (car (made))))) )
(de marble (P M)
   (let (I 15  D)
      (make
         (link 0)
         (for N M
            (mar-shift)
            (if (gt0 (% N 23))
               (prog
                  (link N) )
               #(println 'boom (made))
               (accu
                  'D
                  (% N P)
                  (+ (get (made) I) N) )
               (inc 'I 21)
               (made
                  (conc
                     (tail 8 (made)) (head -9 (made)) ) )
               (mar-shift)
               
            )
            #(println (made))
         )
      )
      #(println 'D D)
      (cdr (maxi cdr D))
   )
)


#(println 32 (a9-1 9 50))
#(println 8317 (a9-1 10 1618))
#(println 146373 (a9-1 13 7999))
#(println 2764 (a9-1 17 1104))
(test 8820  (marble 9 1500))
(println 2764 (marble 17 1104))

#{
(test 32     (a9-1 9 25))
(test 8317   (a9-1 10 1618))
(test 146373 (a9-1 13 7999))
(test 2764   (a9-1 17 1104))
(test 54718  (a9-1 21 6111))
}#
#(bench (println 37305  (a9-1 30 5807)))
# to infinity and beyond
#(bench (println 418237 (a9-1 423 71944)))
#(test 3505711612 (a9-1 423 7194400))

(msg 'ok)
(bye)
