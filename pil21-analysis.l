#{
   Lets take all pil21's primitives from "../pil21/src/glob.l" and
   all functions from "../pil21-tests/*.l" and find which functions
   dont have tests.
}#

(in "../pil21/src/glob.l"
   (from "symTab")
   (line)
   (from "(")
   (println (peek))


)

(msg 'ok)
(bye)
