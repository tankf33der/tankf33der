(be int_width (@N @W)
   (^ @ (> (-> @N) 9))
   T
   (^ @M (/ (-> @N) 10))
   (int_width @M @WM)
   (^ @W (inc (-> @WM))) )
(be int_width (@N @W)
   (^ @W 1) )

(be write (@C)
   (^ @ (prin (-> @C))) )

(be writeN (@N @C)
   (^ @ (gt0 (-> @N)))
   T
   (^ @M (dec (-> @N)))
   (write @C)
   (writeN @M @C) )
(be writeN (@N @C))

(be write_int (@I @W)
   (int_width @I @Wint)
   (^ @Spaces (- (-> @W) (-> @Wint)))
   (writeN @Spaces " ")
   (write @I) )

(be nl NIL
   (^ @ (t (prinl)) ) )

(be once (@G)
   (^ @ (prove (goal (list (-> @G))))
   T )

(be select (@X (@X . @T) @T))
(be select (@X (@H . @T) (@H . @R))
   (select @X @T @R) )

