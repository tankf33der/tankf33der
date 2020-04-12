#!/usr/bin/env pil
(seed (in "/dev/urandom" (rd 8)))
(de randsym NIL
   (pack
      (make
         (do (rand 5 8)
            (link
               (char
                  (if (rand T) (rand 97 122) (rand 48 57)) ) ) ) ) ) )
(call
   "sh" "-c"
   (pack
      "git commit -aqm "
      (randsym)
      " && git push -q" ) )
(bye)


# alias g1='git commit -aqm . && git push -q'
