(de toml (F)
   (make
      (in F
         (until (eof)
         )
      )
   )
)

(println
   (toml "data/spec/comment.toml")
)

(msg 'ok)
(bye)
