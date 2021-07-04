(seed (in "/dev/urandom" (rd 8)))
(setq
   *Suits
   (quote C D H S)
   *Pips
   (circ 2 3 4 5 6 7 8 9 10 'J 'Q 'K 'A) )
(de mkDeck ()  # random
   (by
      '(NIL (rand))
      sort
      (make
         (for S *Suits
            (for N 13
               (link (cons N (pack (++ *Pips) S))) ) ) ) ) )
(setq *Deck (mkDeck))
(println (length *Deck))
(println *Deck)
(off P1 P2)
(while *Deck
   (msg 'do)
   (fifo 'P1 (++ *Deck))
   (fifo 'P2 (++ *Deck)) )
(println (length P1) (length P2))
(println P1)
(println P2)

(msg 'ok)
(bye)
