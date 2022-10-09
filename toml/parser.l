(de toml (F)
   (make
      (in F
         (until (eof)
            (skip "#")
            (make
               (link (till " =" T))
               (
            )
         )
      )
   )
)

(toml "data/spec/comment.toml")

(msg 'ok)
(bye)
