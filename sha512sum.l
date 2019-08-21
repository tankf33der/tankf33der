(de sha512 (D DL)
   (use R
      (native
         "libmonocypher.so"
         "crypto_sha512"
         NIL
         '(R (64 B . 64))
         D
         DL )
      R ) )
(de mmap (L F)
   (native "@" "mmap" 'N 0 L 1 2 F 0) )
(de munmap (A L)
   (native "@" "munmap" 'N A L) )
(let 
   (F (car (argv))
      S (car (info F))
      M (mmap S (open F T)) )
   (prinl
      (lowc
         (pack
            (mapcar
               '((B) (pad 2 (hex B)))
               (sha512 M S) ) ) )
      "  "
      F )
   (munmap M S) )

(bye)
