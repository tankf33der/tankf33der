(de prog3-1 (A B Res . Prg)
   (run Prg 1)
   Res )
(de prog3-2 (A B Res . @) Res) 

(let A 3
   (test
      7 
      (prog3-2
         (println 1)
         (println 2)
         (+ 3 4)
         (println A) ) ) )

#{ IRC session:
<Regenaxer> So do you understand why it prints '1' instead of '3'?
<Regenaxer> in the above example?
<Regenaxer> : (debug 'prog3)
<Regenaxer> -> T
<Regenaxer> : (let A 3 (prog3 (println 1) (println 2) (+ 3 4) (println A)))
<Regenaxer> 1
<Regenaxer> 2
<Regenaxer> (run Prg 1)
<Regenaxer> ! Prg
<Regenaxer> -> ((println A))
<Regenaxer> ! A   
<Regenaxer> -> 1
<Regenaxer> !
<Regenaxer> If you use 'X' instead of 'A' in the 'let', or if you use transients, it will work
<Regenaxer> hmm
<Regenaxer> But it is essential
<Regenaxer> The binding of 'A'
<Regenaxer> Think about it!
<Regenaxer> ok
<Regenaxer> But it is so simple. Look at the debug output
<Regenaxer> A is bound to '1', right? So it prints '1'. That's all
<Regenaxer> (pp 'prog3)
<Regenaxer> (de prog3 (A B Res . Prg)
<Regenaxer>    (run Prg 1)
<Regenaxer>    Res )
<Regenaxer> If it is (run Prg), then 'Prg' is executed with 'A' being bound to '1', because this is the first parameter
}#

(bye)
