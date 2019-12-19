(scl 12)
(de f** (N E)
   (*/ (** N E) (** 1.0 (dec E))) )
(prinl (format (f** 22.12 3) *Scl))

(msg 'ok)
(bye)
