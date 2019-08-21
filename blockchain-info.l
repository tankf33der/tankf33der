(in '("@bin/ssl" "blockchain.info" 443 "de/ticker")
   (from "\"EUR\"")
   (from "\"last\" : ")
   (let
      (Rate
         (format
            (pack (till ".,\n") (or (till ",\n") "."))
            *Scl ) )
      (println 'Rate Rate) ) )
(msg 'ok)
(bye)
