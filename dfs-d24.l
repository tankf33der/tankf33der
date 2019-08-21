#(setq Lst '((0 2) (2 2) (2 3) (3 4) (3 5)))

(setq Lst
   (quote
      (0 2) (2 2) (2 3) (3 4)
      (3 5) (0 1) (10 1) (9 10) ) )



(de f24-rest (V R A)
   (filter
      '((L) (nor (member L V) (member L A)))
      R ) )
(de f24-adj (V R)
   (cond
      ((cdr V)
         (let
            (I (car (setq @ (last V)))
               J (cadr @) )
            (filter
               '((L) (or (member I L) (member J L)))
               (filter '((L) (not (member L V))) R) ) ) )
      (T
         (let (I (cadar V)  Y (car V))
            (filter
               '((L) (member I L))
               (filter '((L) (<> Y L)) R) ) ) ) ) )
#(test '((9 10)) (f24-adj '((0 1) (10 1)) Lst))
#(test NIL (f24-adj '((0 1) (10 1) (9 10)) Lst))
#(test '((10 1)) (f24-adj '((0 1)) Lst))
(test
   '((0 2) (3 4) (3 5))
   (f24-rest
      '((0 1) (2 2) (9 10))
      Lst
      '((10 1) (2 3)) ) )

(de f24 (V A R)
   (println 'V V 'R R 'A A)
   (cond
      ((not A)) 
      ((atom (car A))
         (let
            (V (append V (cons A))
               A (f24-adj V R)
               R (f24-rest V R A) )
            (append
               (cons V)
               (f24 V (car A) R)
               (f24 V (cdr A) R) ) ) )
      (T
         (append
            (cons V)
            (f24 V (car A) R)
            (f24 V (cdr A) R)) ) ) )
#(trace 'f24)
#{
(setq
   FIN
   (f24
      '((0 2)) 
      (setq @ (f24-adj '((0 2)) Lst))
      (f24-rest '((0 2)) Lst @) ) )
(mapc println FIN)
}#


(de d24 (V R)
   (let M 0
      (recur (V R)
         (let
            (R (filter '((L) (not (member L V))) R)
               Adj (f24-adj V R)
               #R (filter '((L) (not (member L Adj))) R)
            )
            (and
               (>
                  (setq @@ (sum '((L) (apply + L)) V))
                  M )
               (setq M @@) )
            #(link V)
            (prinl)
            (println 'Res V)
            (println 'V V 'R R)
            (println 'Adj Adj)
            (for A Adj
               #(println 'A A)
               (let (V (append V (cons A)) R (filter '((L) (not (member L Adj))) R))
                  (recurse V R) ) )
         )
      )
      M
   )
)

#(println (d24 '((0 2)) Lst))

(de dd24 (Lst I)
   (default I 0)
   (let S 0
      (for L Lst
         (let (A (car L)  B (cadr L))
            (when (member I L)
               (let
                  (Lst (filter '((Y) (<> Y L)) Lst)
                     BA 0
                     BB 0 )
                  (cond
                     ((= I A)
                        (setq BA (+ A B (dd24 Lst B))) )
                     ((= I B)
                        (setq BB (+ A B (dd24 Lst A))) ) )
                     (setq S (max S BA BB)) ) ) ) )
      S ) )
(test 31 (dd24 Lst))

(de dd24-2 (Lst I)
   (default I 0)
   (let S (list 0 0)
      (for L Lst
         (let (A (car L)  B (cadr L))
            (when (member I L)
               (let
                  (Lst (filter '((Y) (<> Y L)) Lst)
                     BA (list 0 0)
                     BB (list 0 0) )
                  (cond
                     ((= I A)
                        (set
                           '@ (dd24-2 Lst B)
                           BA (inc (car @))
                           (cdr BA) (+ (cadr @) A B) ) )
                     ((= I B)
                        (set
                           '@ (dd24-2 Lst A)
                           BB (inc (car @))
                           (cdr BB) (+ (cadr @) A B) ) ) )
                     (setq S (max S BA BB)) ) ) ) )
      S ) )
(test (4 19) (dd24-2 Lst))


(msg 'ok)
(bye)

