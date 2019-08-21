# Gigasecond

# Go Counting

# Grade school
# pilDB
(de *GRADES
   (11 . "Mike") (1 . "Anna")
   (3 . "Nick") (3 . "Bella")
   (4 . "Leo") (4 . "John" ) (4 . "Peter")
   (5 . "Zebra") (5 . "Helga") ) 
(class +Grade +Entity)
(rel gr (+Ref +Number))
(rel nm (+String))
(pool (tmp "grade.db"))
# insert initial data
(for I *GRADES
   (new!
      '(+Grade) 
      'gr 
      (car I) 
      'nm 
      (cdr I) ) )
# manual add
(new! '(+Grade) 'gr 6 'nm "Lena")
# uncomment for output in sort of 'gr and 'nm
#{
(for X (uniq (collect 'gr '+Grade NIL T 'gr))
   (prin X)
   (prin "^I")
   (prinl
      (glue 
         " "
         (sort
            (collect 'gr '+Grade X X 'nm) ) ) ) ) 
}#

# Lisp-assoc way
(off *G)
(de grade (G Gr Nm)
   (if (assoc Gr (val G))
      (push (cdr @) Nm)
      (push G (list Gr (list Nm))) ) )
# insert initial data
(for I *GRADES
   (grade '*G (car I) (cdr I)) )
# manual add
(grade '*G 6 "Lena")
# uncomment for output in sort
#{
(for X (sort (uniq (mapcar car *G)))
   (prin X)
   (prin "^I")
   (prinl
      (glue 
         " "
         (sort (cadr (assoc X *G))) ) ) )
}#
#{
<output>
   1       Anna
   3       Bella Nick
   4       John Leo Peter
   5       Helga Zebra
   6       Lena
   11      Mike
</output>
}#

# Grains
(de grains (A)
   (sum '((A) (** 2 A)) (range 0 (dec A))) )
(test 18446744073709551615 (grains 64))

# Grep

# Hamming
(de hamming (L1 L2)
   (let (L1 (chop L1)  L2 (chop L2))
      (cnt '((A B) (<> A B)) L1 L2) ) )
(test
   7
   (hamming "GAGCCTACTAACGGGAT" "CATCGTAATGACGGCCT") )

# Hangman
(de draw (N)
   (case N
      (1
         (prinl "      __________")
         (prinl "      |        |")
         (prinl "               |")
         (prinl "               |")
         (prinl "               |")
         (prinl "               |")
         (prinl "               |")
         (prinl "               |")
         (prinl "    ============") )
      (2
         (prinl "      __________")
         (prinl "      |        |")
         (prinl "      0        |")
         (prinl "               |")
         (prinl "               |")
         (prinl "               |")
         (prinl "               |")
         (prinl "               |")
         (prinl "    ============") )
      (3
         (prinl "      __________")
         (prinl "      |        |")
         (prinl "      0        |")
         (prinl "      |        |")
         (prinl "      |        |")
         (prinl "               |")
         (prinl "               |")
         (prinl "               |")
         (prinl "    ============") )
      (4
         (prinl "      __________")
         (prinl "      |        |")
         (prinl "      0        |")
         (prinl "      |/       |")
         (prinl "      |        |")
         (prinl "               |")
         (prinl "               |")
         (prinl "               |")
         (prinl "    ============") )
      (5
         (prinl "      __________")
         (prinl "      |        |")
         (prinl "      0        |")
         (prinl "     \\|/       |")
         (prinl "      |        |")
         (prinl "               |")
         (prinl "               |")
         (prinl "               |")
         (prinl "    ============") )
      (6
         (prinl "      __________")
         (prinl "      |        |")
         (prinl "      0        |")
         (prinl "     \\|/       |")
         (prinl "      |        |")
         (prinl "     /         |")
         (prinl "               |")
         (prinl "               |")
         (prinl "    ============") )
      (7
         (prinl "      __________")
         (prinl "      |        |")
         (prinl "      0        |")
         (prinl "     \\|/       |")
         (prinl "      |        |")
         (prinl "     / \\       |")
         (prinl "               |")
         (prinl "               |")
         (prinl "    ============") ) ) )
(de hangman (Word)
   (let
      (Word (chop Word)
         Len (length Word)
         Guess (need Len)
         Was NIL
         Steps 1
      )
      (prinl "Guess a word, its " Len " letters long")
         (draw Steps)
         (prn Guess)
         (prinl "Letters guessed: " Was)
         (prin "Enter a letter: ")
         (read)
         (modify Word 't Guess)
         (prn Try)
   )
)
(de prn (W)
   (prin " ")
   (for I W
      (prin " ")
      (prin (if I @ "_"))
      (prin " ") )
   (prinl) )
(de modify (W C A)
   (let I
      (make
         (for (I . X) W
            (and (= X C) (link I)) ) )
      (for N I
         (set (nth A N) C) ) ) )


#(hangman "letter")

(de mike ()
   (loop
      (prinl "Enter letter: ")
      (read)
   )
)
(mike)



(msg 'ok)
(bye)

