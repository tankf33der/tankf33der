(de soundex (Str) #NARA
   (let (Str (chop Str) Last)
      (pack
         (pad
            -4
            (cons
               (uppc (car Str))
               (head
                  3
                  (filter 
                     gt0
                     (cdr
                        (mapcar
                           '((C)
                              (and
                                 (setq C
                                    (case (uppc C)
                                       (`(chop "AEIOUY") 0)
                                       (`(chop "BFPV") 1)
                                       (`(chop "CGJKQSXZ") 2)
                                       (("D" "T") 3)
                                       ("L" 4)
                                       (("M" "N") 5)
                                       ("R" 6) ) )
                                 (<> Last C)
                                 (setq Last C) ) )
                           Str ) ) ) ) ) ) ) ) )
(setq *Soundex
   (quote
      ("Ashcraft" . "A261") ("Ashcroft" . "A261") ("auerbach" . "A612")
      ("Baragwanath" . "B625") ("bar" . "B600") ("barre" . "B600")
      ("Baragwanath" . "B625") ("Burroughs" . "B620") ("Burrows" . "B620")
      ("Donnell" . "D540") ("Dracula" . "D624") ("Drakula" . "D624")
      ("Ekzampul" . "E251") ("example" . "E251") ("Ellery" . "E460")
      ("Euler" . "E460") ("Gauss" . "G200") ("Ghosh" . "G200")
      ("Gutierrez" . "G362") ("he" . "H000") ("Heilbronn" . "H416")
      ("Hilbert" . "H416") ("Jackson" . "J250") ("Johnny" . "J500")
      ("Jonny" . "J500") ("Kant" . "K530") ("Knuth" . "K530")
      ("Ladd" . "L300") ("Llyod" . "L300") ("Lee" . "L000")
      ("Lissajous" . "L222") ("Lukasiewicz" . "L222") ("Miller" . "M460")
      ("Moses" . "M220") ("Moskowitz" . "M232") ("Moskovitz" . "M213")
      ("Peters" . "P362") ("Peterson" . "P362") ("Pfister" . "P236")
      ("Robert" . "R163") ("Rupert" . "R163") ("Rubin" . "R150")
      ("Soundex" . "S532") ("sownteks" . "S532") ("Swhgler" . "S460")
      ("Tymczak" . "T522") ("Uhrbach" . "U612") ("VanDeusen" . "V532")
      ("Washington" . "W252") ("Wheaton" . "W350") ("Williams" . "W452")
      ("Woolcock" . "W422") ("Smith" . "S530") ("Johnson" . "J525")
      ("Williams" . "W452") ("Jones" . "J520") ("Brown" . "B650")
      ("Davis" . "D120") ("Miller" . "M460") ("Wilson" . "W425")
      ("Moore" . "M600") ("Taylor" . "T460") ("Anderson" . "A536")
      ("Thomas" . "T520") ("Jackson" . "J250") ("White" . "W300")
      ("Harris" . "H620") ("Martin" . "M635") ("Thompson" . "T512")
      ("Garcia" . "G620") ("Martinez" . "M635") ("Robinson" . "R152")
      ("Clark" . "C462") ("Rodriguez" . "R362") ("Lewis" . "L200")
      ("Lee" . "L000") ("Walker" . "W426") ("Hall" . "H400")
      ("Allen" . "A450") ("Young" . "Y520") ("Hernandez" . "H655")
      ("King" . "K520") ("Wright" . "W623") ("Lopez" . "L120")
      ("Hill" . "H400") ("Scott" . "S300") ("Green" . "G650")
      ("Adams" . "A352") ("Baker" . "B260") ("Gonzalez" . "G524")
      ("Nelson" . "N425") ("Carter" . "C636") ("Mitchell" . "M324")
      ("Perez" . "P620") ("Roberts" . "R163") ("Turner" . "T656")
      ("Phillips" . "P412") ("Campbell" . "C514") ("Parker" . "P626")
      ("Evans" . "E152") ("Edwards" . "E363") ("Collins" . "C452")
      ("Stewart" . "S363") ("Sanchez" . "S522") ("Morris" . "M620")
      ("Rogers" . "R262") ("Reed" . "R300") ("Cook" . "C200")
      ("Morgan" . "M625") ("Bell" . "B400") ("Murphy" . "M610")
      ("Bailey" . "B400") ("Rivera" . "R160") ("Cooper" . "C160")
      ("Richardson" . "R263") ("Cox" . "C200") ("Howard" . "H630")
      ("Ward" . "W630") ("Torres" . "T620") ("Peterson" . "P362")
      ("Gray" . "G600") ("Ramirez" . "R562") ("James" . "J520")
      ("Watson" . "W325") ("Brooks" . "B620") ("Kelly" . "K400")
      ("Sanders" . "S536") ("Price" . "P620") ("Bennett" . "B530")
      ("Wood" . "W300") ("Barnes" . "B652") ("Ross" . "R200")
      ("Henderson" . "H536") ("Coleman" . "C455") ("Jenkins" . "J525")
      ("Perry" . "P600") ("Powell" . "P400") ("Long" . "L520")
      ("Patterson" . "P362") ("Hughes" . "H220") ("Flores" . "F462")
      ("Washington" . "W252") ("Butler" . "B346") ("Simmons" . "S552")
      ("Foster" . "F236") ("Gonzales" . "G524") ("Bryant" . "B653")
      ("Alexander" . "A425") ("Russell" . "R240") ("Griffin" . "G615")
      ("Diaz" . "D200") ("Hayes" . "H200") ) )
(for I *Soundex
   (test (soundex (car I)) (cdr I)) ) 

(msg 'ok)
(bye)
