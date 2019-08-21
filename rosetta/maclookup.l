(load "@lib/http.l")

(de maclookup (M)
   (client "api.macvendors.com" 80
      M
      (while (line))
      (line T) ) )
(test
   "Intel Corporate"
   (maclookup "88:53:2E:67:07:BE") )
(test
   "Apple, Inc."
   (maclookup "D4:F4:6F:C9:EF:8D") )

(msg 'ok)
(bye)
