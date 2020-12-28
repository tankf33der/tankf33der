#{
   Lets take all pil21's primitives from "../pil21/src/glob.l" and
   all functions from "../pil21-tests/*.l" and find which functions
   dont have tests.
}#

(de analyze (File)
   (in File
      (until (eof)
         (when (line)
            (mapcar
               '((L)
                  (when (pack L)
                     (and (assoc @ D) (inc (cdr @))) ) )
               (split @ " " "(" ")") ) ) ) ) )
(off D)
(in "../pil21/src/glob.l"
   (let (T1 NIL  T2 NIL)
      (from "symTab")
      (line)
      (loop
         (from "(")
         (setq T1 (read) T2 (read))
         (T (= T1 "$LastSym"))
         (or T1 (pre? "$" T2) (push 'D (list T2 0)))
         (line) ) ) )
(let Dir "../pil21-tests"
   (recur (Dir)
      (for F (dir Dir)
         (let Path (pack Dir "/" F)
            (cond
               ((=T (car (info Path)))
                  (recurse Path) )
               ((match '`(chop "@.l") (chop F))
                  (analyze Path) ) ) ) ) ) )
(let Dir "../pil21/test"
   (recur (Dir)
      (for F (dir Dir)
         (let Path (pack Dir "/" F)
            (cond
               ((=T (car (info Path)))
                  (recurse Path) )
               ((match '`(chop "@.l") (chop F))
                  (analyze Path) ) ) ) ) ) )
(mapc
   println
   (flip
      (by
         cadr
         sort
         D ) ) )
(println
   (length D)
   (cnt '((L) (=0 (cadr L))) D) )
(msg 'ok)
(bye)
