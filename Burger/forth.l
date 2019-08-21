# 17feb17abu
# (c) Software Lab. Alexander Burger

# Usage:  $ pil forth.l -forth

# Globals (without '*')
# IP RP SP WP Words Here State

# Parse word from input stream
(de word ()
   (loop
      (NIL (= "(" (skip "\\"))
         (till " \t\n" T) )
      (char)
      (NIL (sp? (peek))
         (pack "(" (till " \t\n")) )
      (from ")") ) )

(de defineWord (W Val)
   (when (member W Words)
      (prinl W " redefined") )
   (set (push 'Words W) Val) )

# Define primitives
(de code Args
   (defineWord (car Args) (cdr Args)) )

(de comma (W)
   (conc Here (setq Here (list W))) )

(de immediate ()
   (put (car Words) 'immediate T) )

(de execute (W)
   (if (pair (caar W))
      (run (val W))
      (run (caar (setq WP (val W)))) ) )

# Stack
(code "drop"  # ( n1 -- )
   (++ SP) )

(code "dup"  # ( n1 -- n1 n1 )
   (push 'SP (car SP)) )

(code "swap"  # ( n1 n2 -- n2 n1 )
   (xchg SP (cdr SP)) )

(code "2swap"  # ( n1 n2 n3 n4 -- n3 n4 n2 n1 )
   (xchg SP (cddr SP))
   (xchg (cdr SP) (cdddr SP)) )

(code "over"  # ( n1 n2 -- n1 n2 n1 )
   (push 'SP (cadr SP)) )

(code "@"  # ( adr -- n )
   (set SP (caar SP)) )

(code "!"  # ( n adr -- )
   (set (++ SP) (++ SP)) )

(code "r>"  # ( -- n )
   (push 'SP (++ RP)) )

(code ">r"  # ( n -- )
   (push 'RP (++ SP)) )

# Arithmetics
(code "+"  # ( n1|adr n2 -- n3|adr+n2 )
   (if (pair (cadr SP))
      (let N (inc (++ SP))
         (set SP (nth (car SP) N)) )
      (inc (cdr SP) (++ SP)) ) )

(code "1+"  # ( n|adr -- n+1|adr+1 )
   (if (pair (car SP))
      (pop SP)
      (inc SP) ) )

(code "1-"  # ( n -- n-1 )
   (dec SP) )

(code "-"  # ( n1 n2 -- n3 )
   (dec (cdr SP) (++ SP)) )

(code "*"  # ( n1 n2 -- n3 )
   (set (cdr SP) (* (cadr SP) (++ SP))) )

(code "/"  # ( n1 n2 -- n3 )
   (set (cdr SP) (/ (cadr SP) (++ SP))) )

# Comparisons
(code "="  # ( n1 n2 -- f )
   (set (cdr SP)
      (if (= (cadr SP) (++ SP)) 1 0) ) )

(code ">"  # ( n1 n2 -- f )
   (set (cdr SP)
      (if (> (cadr SP) (++ SP)) 1 0) ) )

(code ">="  # ( n1 n2 -- f )
   (set (cdr SP)
      (if (>= (cadr SP) (++ SP)) 1 0) ) )

# I/O
(code "."  # ( n -- )
   (printsp (++ SP))
   (flush) )

(code ".s"  # ( -- )
   (do (length SP)
      (printsp (car (rot SP))) )
   (flush) )

(code "cr"  # ( -- )
   (prinl) )

(code "see"  # ( -- )
   (println (caar (member (word) Words))) )

# Compilation
(code "immediate"  # ( -- )
   (immediate) )

(code "here"  # ( -- adr )
   (push 'SP Here) )

(code "nest"  # (--)
   (push 'RP IP)
   (setq IP (cdr WP)) )

(code "exit"  # ( -- )
   (setq IP (++ RP)) )

(code "(lit)"  # ( -- n )
   (push 'SP (++ IP)) )

(code "(var)"  # ( -- adr )
   (push 'SP (cdr WP)) )

(code ":"  # ( -- )
   (defineWord (word)
      (setq Here (list '"nest")) )
   (on State) )

(code ";"  # ( -- )
   (conc Here '("exit"))
   (off State) )
(immediate)

(code "create"  # ( -- )
   (defineWord (word)
      (setq Here (list '"(var)")) ) )

(code ","  # ( n -- )
   (comma (++ SP)) )

(code "'"  # ( -- word )
   (let W (word)
      (if (member W Words)
         (push 'SP (car @))
         (prinl W " not found") ) ) )

(code "branch"  # ( -- )
   (setq IP (cdar IP)) )

(code "?branch"  # ( f -- )
   (if (=0 (++ SP))
      (setq IP (cdar IP))
      (++ IP) ) )

# System
(code "bye"  # ( -- )
   (bye) )

# Outer interpreter
(de forth ()
   (catch 'eof
      (loop
         (off SP RP)
         (catch 'quit
            (loop
               (when (and (eol) (nor State (file)))
                  (prin "-- ")
                  (flush) )
               (let W (word)
                  (cond
                     ((not W) (throw 'eof))
                     ((format W)
                        (push 'SP @)
                        (when State
                           (comma '"(lit)")
                           (execute '",") ) )
                     ((member W Words)
                        (setq W (car @))
                        (if (and State (not (; W immediate)))
                           (comma W)
                           (execute W)
                           (while IP  # Inner interpreter
                              (execute (++ IP)) ) ) )
                     (T
                        (prinl W " is unknown")
                        (throw 'quit) ) ) ) ) ) ) ) )

(forth)

: variable ( -- )  create 0 , ;

: compile ( -- )  r> dup 1+ >r  @ ,  ;
: [compile]  ' ,  ; immediate

: if    compile ?branch  0 ,  here  ; immediate
: else  compile branch  0 ,  here  swap !  here  ; immediate
: then  here  swap !  ; immediate

: begin   here  ; immediate
: while   [compile] if  ; immediate
: repeat  compile branch  swap ,  [compile] then  ; immediate

\ ### Tests ###
variable Var
3 4 + Var !
Var @ . cr

create Array  2 , 4 , 6 , 8 ,
Array 2 + @ . cr

: foo ( -- )
   7 begin
      dup 1 >=
   while
      dup . 1-
   repeat
   cr  drop ;

: bar ( -- ) foo foo ;

: fibo ( n -- n )
   2 over >= if
      drop 1
   else
      dup 1- fibo  swap 2 - fibo  +
   then  ;
