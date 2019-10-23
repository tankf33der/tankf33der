`(== 64 64)
(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(zero C)         
(prinl "#include <inttypes.h>")
(prinl "#include <stddef.h>")
(in "../crypto/tests/sign.input"
   (while (line)
      (let L (mapcar hex2L (split @ ":"))
         (prinl
            "uint8_t si_"
            (inc 'C)
            "[] = {"
            (glue "," (head 32 (car L)))
            "};" )
         (prinl
            "uint8_t si_"
            (inc 'C)
            "[] = {"
            (glue "," (cadr L))
            "};" )
         (prinl
            "uint8_t si_"
            (inc 'C)
            "[] = {"
            (glue "," (caddr L))
            "};" )
         (prinl
            "#define msg_"
            (inc (/ (- C 3) 4)) # You are, Looser
            " "
            (length (caddr L)) )
         (prinl
            "uint8_t si_"
            (inc 'C)
            "[] = {"
            (glue "," (cadddr L))
            "};" ) ) ) )
(prinl
   "size_t nb_si = "
   C
   ";" )
(prin "size_t msg_sizes[] = {")
(for N 1024
   (prin "msg_" N ",") )
(prinl "};")
(prin "uint8_t *si_vectors[] = {")
(for N (* 1024 4)
   (prin "si_" N ",") )
(prinl "};")

   



#(println 'C C (/ C 4))
(msg 'ok)
(bye)
