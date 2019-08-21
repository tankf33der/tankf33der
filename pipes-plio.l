#{

: (pipe (out NIL (pr "mike")) (make (while (rd 1) (link @))) )
-> (18 109 105 107 101)
: (pipe (out NIL (pr (>> -64 12))) (make (while (rd 1) (link @))) )
-> (36 0 0 0 0 0 0 0 0 24)
: (pipe (out NIL (pr (list (list 1 2) (range 4 6)))) (make (while (rd 1) (link @))) )
-> (1 1 4 2 4 4 3 1 4 8 4 10 4 12 3 3)
:

}#

(de pliopr (L)
   (pipe
      (out NIL (pr L))
      (make
         (while (rd 1)
            (link @) ) ) ) )
(de pliord (L)
   (pipe (out NIL (mapc wr L)) (rd)) )
(test 1024 (pliord (list 8 0 8)))
(test (8 0 8) (pliopr 1024))
(test
   (1 4 2 4 4 4 6 4 8 4 10 3)
   (pliopr (range 1 5)) )
(test (18 109 105 107 101) (pliopr "mike"))
(test
   (1 9 42 42 4 44 8 188 1 3)
   (pliopr '(** 22 222)) )
(test
   (252 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 128 36 82 69 250 98 152 105 111 144 95 206 54 250 40 182 252 122 131 43 64 61 169 111 46 52 182 42 131 146 9 31 79 119 10 248 61 19 251 208 116 168 126 55 91 215 157 5 125 86 164 224 109 235 84 59 17 210 106 180 204 188 220 221 218 16 145 153 46 207 36 109 182 39 137 31 193 25 93 223 104 47 171 93 48 54 211 56 48 5 45 42 51 79 41 235 115 127)
   (pliopr (** 22 222)) )

(msg 'ok)
(bye)
