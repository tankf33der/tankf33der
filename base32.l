(setq *Alpha32 (chop "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"))

(de encode32 (Lst)
   (let
      (Len (length Lst)
         N (inc (/ (dec (* Len 8)) 5))
         S 0 )
      (mapc
         '((N) (setq S (+ N (>> -8 S))))
         Lst )
      (and
         (> 8 N)
         (setq S
            (>>
               (- (- 5 (% (* Len 8) 5)))
               S ) ) )
      (make
         (for (A 0 (> N A) (inc A))
            (yoke
               (get
                  *Alpha32
                  (inc (& (>> (* A 5) S) `(hex "1F"))) ) ) )
         (chain (need (- 8 N) "=")) ) ) )
(de decode32 (Lst)
   (let
      (Len (length Lst)
         N (/ (* Len 5) 8)
         S 0 )
      (mapc
         '((N)
            (setq S
               (+ (dec (index N *Alpha32)) (>> -5 S)) ) )
         Lst )
      (and
         (> 8 Len)
         (setq S
            (>> (- 5 (% (* N 8) 5)) S) ) )
      (make
         (for (A 0 (> N A) (inc A))
            (yoke
               (char (& (>> (* A 8) S) `(hex "FF"))) ) ) ) ) )
(de b32enc (Lst)
   (let Lst (mapcar char (chop Lst))
      (pack
         (make
            (while (cut 5 'Lst)
               (chain (encode32 @)) ) ) ) ) )

(de b32dec (Lst)
   (let Lst (filter '((N) (<> "=" N)) (chop Lst))
      (pack
         (make
            (while (cut 8 'Lst)
               (chain (decode32 @)) ) ) ) ) )

# RFC4648
(test
   (b32dec (b32enc ""))
   NIL )
(test
   (b32dec (b32enc "f"))
   "f" )
(test
   (b32dec (b32enc "fo"))
   "fo" )
(test
   (b32dec (b32enc "foo"))
   "foo" )
(test
   (b32dec (b32enc "foob"))
   "foob" )
(test
   (b32dec (b32enc "fooba"))
   "fooba" )
(test
   (b32dec (b32enc "foobar"))
   "foobar" )

(msg 'ok)
(bye)

