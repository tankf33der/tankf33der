(de cidr (S)
   (let
      (L (rot (mapcar format (split (chop S) "." "/")))
         N (++ L)
         M
         (&
            (sum >> (-24 -16 -8 0) L)
            (rev 32 (dec (** 2 N))) ) )
      (pack
         (>> 24 M)
         "."
         (& 255 (>> 16 M))
         "."
         (& 255 (>> 8 M))
         "."
         (& 255 (& 255 M))
         "/"
         N ) ) )
(let Fmt (18 3 17)
   (for A
      (quote
         "87.70.141.1/22"
         "36.18.154.103/12"
         "62.62.197.11/29"
         "67.137.119.181/4"
         "161.214.74.21/24"
         "184.232.176.184/18" )
      (tab Fmt A "=>" (cidr A)) ) )
(msg 'ok)
(bye)