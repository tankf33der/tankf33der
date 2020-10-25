#{
   Lets take all pil21's primitives from "../pil21/src/glob.l" and
   all functions from "../pil21-tests/*.l" and find which functions
   dont have tests.
}#

(off D)
(in "../pil21/src/glob.l"
   (let (T1 NIL  T2 NIL)
      (from "symTab")
      (line)
      (loop
         (from "(")
         (setq T1 (read) T2 (read))
         (T (= T1 "$LastSym"))
         (or T1 (pre? "$" T2) (accu 'D T2 0))
         (line) ) ) )
(msg 'ok)
(bye)
