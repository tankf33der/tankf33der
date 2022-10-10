(in "data/spec/keys.dat"
   (until (eof)
      (println (split (till "=") "=" "\"" "'" "." "^I"))
      (line )
   )
)
(msg 'ok)
(bye)
