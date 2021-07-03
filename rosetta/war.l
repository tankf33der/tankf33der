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

(msg 'ok)
(bye)
