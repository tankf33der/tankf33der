(gc 256)
(cd "utf8")
(load "test.l")
(cd "..")
(load "test-math.l")
(load "forth.l")
(load "parse2list.l")
(load "map-reduce.l")
(load "pow_test.l")
(load "inc-db.l")
(load "inc-db-v2.l")
(load "destr2.l")
(load "test-car.l")
(load "bitwise.l")
(load "cartesian.l")

(cd "4clojure")
(load "test.l")

(cd "../advent2015")
(load "code2015.l")

(cd "../advent2016")
(load "code2016.l")

(cd "../advent2017")
(load "code2017.l")

(cd "../advent2018")
(load "code2018.l")

(cd "../Simply-Scheme")
(load "ss.l")

(cd "../Touretzky")
(load "test.l")

(cd "../Menshikov")
(load "test.l")

(cd "../gorlansky")
(load "test.l")

(cd "../Stepanoff")
(load "labs.l")

(cd "../hash")
(load "test.l")

(cd "../rng")
(load "test.l")

(cd "../crypto")
(load "test.l")

(msg 'OK-All)
(bye)
