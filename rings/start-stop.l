(stack 8)
(let N 10000
   (for A N
      (co (intern (pack 'a  A))
         (yield 'ready) )
   )
)



(msg 'ok)
(bye)
