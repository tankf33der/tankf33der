#{
Legend:

map:
 read files N times and build dicts on words
reduce:
 reduce dicts as sum counters on word

o) do in row;
o) parallel maps and parallel reduce;
As result counter on word "the" must be equal.
Simple, custom, generic, fun way.

Inspired by Julia's example:
https://github.com/JuliaLang/julia/blob/master/examples/wordcount.jl
}#

(setq *MAPFILES
   (quote 
      "txt/Hamlet.txt" 
      "txt/alls-well-that-ends-well.txt"
      "txt/the-essays.txt" 
      "txt/the-new-atlantis.txt" ) )
(de -file (F)
   (let A NIL
      (in F
         (until (eof)
            (and
               (lowc (till "`)(}{\;:!?&-][,. ^J" T))
               (accu 'A @ 1) )
            (char) ) )
      A ) )
(de -reduce (Lst)
   (let A (car Lst)
      (for L (cdr Lst)
         (for W L
            (accu 'A (car W) (cdr W)) ) )
      A ) )
(de inrow (N)
   (cdr
      (assoc
         "the"
         (-reduce (make (do N (chain (mapcar -file *MAPFILES))))) ) ) )
(de inprllel (N)
   (let Lst
      (make
         (do N
            (chain
               (mapcan
                  '((F) (later (cons) (-file F)))
                  *MAPFILES ) )
            (wait NIL (full (made))) ) )
      (while (cdr Lst)
         (setq Lst
            (make
               (for (L Lst L (cddr L))
                  (ifn (cdr L)
                     (chain L) 
                     (chain
                        (later (cons)
                           (for B (cadr L)
                              (accu L (car B) (cdr B)) )
                            (car L) ) ) ) ) ) ) 
         (wait NIL (full Lst)) )
      (cdr (assoc "the" (car Lst))) ) )
(let N 3
   (test (inrow N) (inprllel N)) )
(msg 'OK-mapreduce)

