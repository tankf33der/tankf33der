#6.1
(test NIL (nth '(A B C) 4))

#6.2
(test '(C . D) (nth '(A B C . D) 3))

#6.3
(test 'ROSEBUD (last '(ROSEBUD)))

#6.4
(test '(A B C) (last '((A B C))))

#6.5
(let Line '(ROSES ARE RED)
   (test '(RED ARE ROSES) (reverse Line))
   (test 'RED (last Line))
   (test '(ARE RED) (nth Line 2))
   (test '(ROSES ARE RED) (reverse (reverse Line)))
   (test '(ROSES ARE RED ROSES) (append Line (list (car Line))))
   (test '(RED ROSES ARE RED) (append (cons (last Line)) Line))
   (test '(ROSES RED) (list (car Line) (last Line)))
   (test '(RED . (ROSES ARE RED)) (cons (last Line) Line))
   (test '(ROSES RED) (delete 'ARE Line))
   (test
      '(ROSES ARE RED VIOLETS ARE BLUE)
      (append Line '(VIOLETS ARE BLUE)) )
)

#6.6
(let L (1 2 3)
   (test 3 (car (reverse L)))
   (test 3 (car (nth L (length L)))) )

#6.7
(let L (1 2 3)
   (test 2 (cadr (reverse L)))
   (test 2 (car (nth L (dec (length L))))) )

#6.8
(de my-butlast (L)
   (head (dec (length L)) L) )
(test '(ROSES ARE) (my-butlast '(ROSES ARE RED)))

#6.9
(de mystery (L)
   (last (reverse L)) )
(let L (1 2 3)
   (test (car L) (mystery (1 2 3))) )

#6.10
(de palindromp (L)
   (= L (reverse L)) )
(test NIL (palindromp (1 2 3)))
(test T (palindromp (1 2 1)))
 
#6.11
(de make-palindrome (L)
   (append L (reverse L)) )
(test (1 2 3 3 2 1) (make-palindrome (1 2 3)))

#6.12-6.25 - ignore

#6.26
(de Ncommon (Lst)
   (let L NIL
      (list
         (length
            (sect
               (prog
                  (until (== '-vs- (setq @ (pop 'Lst)))
                     (push 'L @) )
                  L )
               Lst ) )
         'common
         'features ) ) )
(test
   '(3 common features)
   (Ncommon
      '(large red 123 shiny cube -vs-
         small shiny 123 red four-sided pyramid ) ) )

#6.27 - ignored

#6.28
(let
   PRODUCE
      (quote
         (apple . fruit)
         (celery . veggie)
         (banana . fruit)
         (lettuce . veggie) )
   (test '(banana . fruit) (assoc 'banana PRODUCE))
   (test '(apple . fruit) (rassoc 'fruit PRODUCE))
   (test '(lettuce . veggie) (assoc 'lettuce PRODUCE))
   (test '(celery . veggie) (rassoc 'veggie PRODUCE)) )

#6.29-6.35 - ignored

#6.36
(de swap-first-last (Lst)
   (append
      (cons (last Lst))
      (head
         (- (length Lst) 2)
         (cdr Lst) )
      (cons (car Lst)) ) )
(test
   '(love cant buy you)
   (swap-first-last '(you cant buy love)) )

#6.37
(de rotate-left (Lst)
   (append (cdr Lst) (cons (car Lst))) )
(de rotate-right (Lst)
   (append
      (cons (last Lst))
      (head (dec (length Lst)) Lst) ) )
(let Lst '(A B C D E)
   (test
      '(B C D E A)
      (rotate-left Lst) )
   (test
      '(E A B C D)
      (rotate-right Lst) ) )

#6.38-6.41 - ignored

#6.42
(de royal-we (Lst)
   (make
      (for A Lst
         (link (if (== 'I A) 'WE A)) ) ) )
(de royal-we-destr (Lst) # Destructive
   (for (L Lst L)
      (if (== 'I (car L))
         (set L 'WE)
         (pop 'L) ) )
   Lst )
(test
   '(IF WE LEARN LISP WE WILL BE PLEASED)
   (royal-we '(IF I LEARN LISP I WILL BE PLEASED)) )

(let L '(I I I)
   (royal-we-destr L)
   (test L '(WE WE WE)) )

