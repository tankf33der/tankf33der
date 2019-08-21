(setq C (circ "\\" "/" "-" "+"))
(loop
   (prin (++ C) "^[[1D")
   (flush)
   (wait 200) )

(msg 'ok)
(bye)
