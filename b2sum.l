(de blake2b (D DL)
   (use R
      (native
         "libmonocypher.so"
         "crypto_blake2b"
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
               (blake2b M S) ) ) )
      "  "
      F )
   (munmap M S) )

#{
[root@home]# b2sum /bin/date
9ab89cf86f4f6cb74de77d4180e613dcffb7e6ca3010d92478398b81cc981f040d0161c75e31902b192ab10c708ce1ed557e422e44fc6548d608728b26a64d70  /bin/date
[root@home]# pil b2sum.l /bin/date
9ab89cf86f4f6cb74de77d4180e613dcffb7e6ca3010d92478398b81cc981f040d0161c75e31902b192ab10c708ce1ed557e422e44fc6548d608728b26a64d70  /bin/date
}#

(bye)
