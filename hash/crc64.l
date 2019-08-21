(setq *Table
   (mapcar
      '((N)
         (do 8
            (setq N
               (if (bit? 1 N)
                  (x| (>> 1 N) `(hex "D800000000000000"))
                  (>> 1 N) ) ) ) )
      (range 0 255) ) )
(de crc64 (Lst)
   (let Crc `(hex "FFFFFFFFFFFFFFFF")
      (for I Lst
         (setq Crc
            (x|
               (get
                  *Table
                  (inc (x| (& Crc 255) I)) )
               (>> 8 Crc) ) ) )
      (x| `(hex "FFFFFFFFFFFFFFFF") Crc) ) )

