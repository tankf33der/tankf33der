(de parsedate (D)
   (let D (mapcar pack (flip (split D "/")))
      (date
         (format (car D))
         (index (cadr D) *Mon)
         (format (caddr D)) ) ) )
(de parse (File Start End)
   (let
      (Start (date Start)
         End (date End)
         Host NIL
         Date NIL
         Traffic NIL )
      (in File
         (until (eof)
            (setq Host (till " " T))
            (from "[")
            (setq Date (parsedate (till ":")))
            (when (<= Start Date End)
               (from "\"")
               (from "\"")
               (read)
               (and (read) (num? @) (accu 'Traffic Host @)) )
            (line) ) )
      (maxi '((H) (length (car H))) Traffic)
      (let Fmt (list (- (+ @@ 7)) -1)
         (for H (reverse (by cdr sort Traffic))
            (tab Fmt (car H) (cdr H)) ) ) ) )
(parse 
   "access_log"
   (2004 3 7)
   (2004 3 7) )
(msg 'ok)
(bye)
