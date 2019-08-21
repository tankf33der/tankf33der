(load "threefish.l")

(let Key (need 4 0)
   (for N 55
      (threefish256 (need 4 0) 'Key (list N (inc N))) )
   (test
      (6073933946305501873 17111034423173541082 9892538611192574087 6689146426950941208)
      Key ) )
(msg 'OK-test-threefish)
