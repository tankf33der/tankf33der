(de mike NIL
   (one *X) )
(de nick (L)
   (one L) )
(de gaga (*X)
   (one *X) )
(setq *X 123)
(mike)
(println '*X *X)
(setq *X 123)
(println '*X *X)
(nick *X)
(println '*X *X)
(setq *X 123)
(println '*X *X)
(gaga *X)
(println '*X *X)


(println 'start-new)
(de def22 NIL 
   (inc '"A")
   (dec '"X1")
   (inc '"B" 100)
   (inc '"C" 1000) )
(de start22 ("A" "B" "C")
   (def22)
   (list "A" "B" "C") )

(let (A 1  B 2  C 3  "X1" 1000)
   (do 2
      (and
         (setq @@ (start22 A B C))
         (println 'a A 'b B 'c C)
         (setq
            A (* A (pop '@@))
            B (* B (pop '@@))
            C (* C (pop '@@)) ) ) 
      (println 'A A 'B B 'C C) )
   (println 'X1 "X1")
)

(msg 'start-new)
(de def33 ("A" "B" "C" X M)
   (inc "A" 1)
   (dec "B" 2)
   (inc "C" 3) )
(de start33 ("A" "B" "C")
   (def33 "C" "B" "A")
   (list (val "A") (val "B") (val "C")) )
(let (A 10 B 20 C 30)
   (do 2
      (setq @@ (start33 'A 'B 'C))
      (println '@@ @@)
      (println 'a A 'b B 'c C)
      (setq
         A (* A (pop '@@))
         B (* B (pop '@@))
         C (* C (pop '@@)) ) )
   (println 'A A 'B B 'C C) )

(msg 'start-new)
(de tre ("A" "B")
   (set 
      "A" (+ (val "A") 10)
      "B" (- (val "B") 20) ) )
(let (A 100  B A "A" 777 "B" 888)
   (println 'A A 'B B "A" "B")
   (tre 'A 'B)
   (println 'A A 'B B "A" "B")
   (tre 'B 'A)
   (println 'A A 'B B "A" "B") )

(msg 'start-new)
(de trr ("N")
   (set "N" 777) )
(let N 123
   (println 'N N)
   (trr 'N)
   (println 'N N) )

(msg 'start-new)
(de gfh (N)
   (set 'N 777)
   (println 'gfh N) )
(let N 123
   (println 'N N)
   (gfh N)
   (println 'N N) )

(msg 'start-new)
(de m1 ("Lst")
   (apply + (reverse "Lst")) )
(let L (range 1 5)
   (println L)
   (println (m1 L))
   (println L) )


      
(bye)
