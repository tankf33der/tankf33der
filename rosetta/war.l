(seed (in "/dev/urandom" (rd 8)))
(setq
   *Suits
   # (quote C D H S)
   (quote C)
   *Pips
   # (circ 2 3 4 5 6 7 8 9 10 'J 'Q 'K 'A) )
   (circ 3 4 5 6 7 8 9 10 'J 'Q 'K 'A) )
(de mkDeck ()  # random
   (by
      '(NIL (rand))
      sort
      (make
         (for S *Suits
            (for N 12
               (link (cons N (pack (++ *Pips) S))) ) ) ) ) )
(setq *Deck (mkDeck))
(println (length *Deck))
(println *Deck)
(off P1 P2)
(while *Deck
   (fifo 'P1 (++ *Deck))
   (fifo 'P2 (++ *Deck)) )
(println (length P1) (length P2))
(println P1)
(println P2)

(off P1 P2)
(fifo 'P1 (list 2 . 77) (list 5 . 77) (list 7 . 77) (list 1 . 77))
(fifo 'P2 (list 3 . 77) (list 8 . 77) (list 2 . 77) (list 10 . 77))


(let
   # (P1 (list 3 4 1 5 6)
      # P2 (list 2 7 10 8 9)
      Table NIL
   (loop
      (push 'Table (fifo 'P1) (fifo 'P2))
      (println 'loop Table P1 P2)
      (println (length P1) (length P2))
      # (wait 2000)
      (NIL (and P1 P2))
      (cond
         ((> (caar Table) (caadr Table))
            (while Table (fifo 'P1 (++ Table))) )
         ((> (caadr Table) (caar Table))
            (while Table (fifo 'P2 (++ Table))) )
      )
   )
   (println P1 P2)
)


(msg 'ok)
(bye)
