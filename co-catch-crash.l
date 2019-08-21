# jul2018

(de foo ()
   (co "html"
      (catch "err"
         (println 'OK)
         (yield)
         (throw "err") ) ) )
# crash
(foo)
(do 1 (foo))

# no crash
# (foo) (foo)

(bye)
