(load "murmur.l")
(load "djb.l")
(load "cityhash.l")
(load "adler32.l")
(load "crc64.l")
(load "fnv.l")
(load "test-siphash.l")
(load "xxhash.l")
(load "lucky777.l")

(setq Seed 123)

# XXHASH32
(test
   46947589
   (xxhash32) )
(test
   1426945110
   (xxhash32 (mapcar char (chop "a"))) )
(test
   1234828371
   (xxhash32 (mapcar char (chop "ab"))) )
(test
   852579327
   (xxhash32 (mapcar char (chop "abc"))) )
(test
   2741253893
   (xxhash32 (mapcar char (chop "abcd"))) )
(test
   2537091483
   (xxhash32 (mapcar char (chop "abcde"))) )
(test
   2340214151
   (xxhash32 (mapcar char (chop "abcdef"))) )
(test
   2647692211
   (xxhash32 (mapcar char (chop "abcdefg"))) )
(test
   196331195
   (xxhash32 (mapcar char (chop "abcdefgh"))) )
(test
   3493598205
   (xxhash32 (mapcar char (chop "abcdefghi"))) )
(test
   2342030590
   (xxhash32 (mapcar char (chop "abcdefghij"))) )
(test
   2646123029
   (xxhash32 (mapcar char (chop "abcdefghijk"))) )
(test
   3976420021
   (xxhash32 (mapcar char (chop "abcdefghijkl"))) )
(test
   2779856918
   (xxhash32 (mapcar char (chop "abcdefghijklm"))) )
(test
   1749889315
   (xxhash32 (mapcar char (chop "abcdefghijklmn"))) )
(test
   3105399669
   (xxhash32 (mapcar char (chop "abcdefghijklmno"))) )
(test
   2637007714
   (xxhash32 (mapcar char (chop "abcdefghijklmnop"))) )
(test
   3015209953
   (xxhash32 (mapcar char (chop "abcdefghijklmnopq"))) )
(test
   2254598351
   (xxhash32 (mapcar char (chop "abcdefghijklmnopqr"))) )
(test
   2637189319
   (xxhash32 (mapcar char (chop "abcdefghijklmnopqrs"))) )
(test
   2439086416
   (xxhash32 (mapcar char (chop "abcdefghijklmnopqrst"))) )
(test
   535079977
   (xxhash32 (mapcar char (chop "abcdefghijklmnopqrstu"))) )
(test
   3061639275
   (xxhash32 (mapcar char (chop "abcdefghijklmnopqrstuv"))) )
(test
   3800781887
   (xxhash32 (mapcar char (chop "abcdefghijklmnopqrstuvw"))) )
(test
   322961314 
   (xxhash32 (mapcar char (chop "abcdefghijklmnopqrstuvwx"))) )
(test
   2064220721
   (xxhash32 (mapcar char (chop "abcdefghijklmnopqrstuvwxy"))) )
(test
   1671515487
   (xxhash32 (mapcar char (chop "abcdefghijklmnopqrstuvwxyz"))) )

# FNV-1a
(test
   "811C9DC5"
   (hex (fnv1a)) )
(test
   "E40C292C"
   (hex (fnv1a (mapcar char (chop "a")))) )
(test
   "4D2505CA"
   (hex (fnv1a (mapcar char (chop "ab")))) )
(test 
   "1A47E90B"
   (hex (fnv1a (mapcar char (chop "abc")))) )

# CRC-64-ISO, with poly "D800000000000000"
(test 0 (crc64))
(test
   3756002089226993664
   (crc64 (mapcar char (chop "a"))) )
(test
   3996597361055891456
   (crc64 (mapcar char (chop "abc"))) )
(test
   9177049756663468903
   (crc64 (mapcar char (chop "abcdefghij"))) )

# Adler-32
(test
   "11E60398"
   (adler32 (mapcar char (chop "Wikipedia"))) )
(test
   "1"
   (adler32) )
(test
   "158603F8"
   (adler32 (mapcar char (chop "abcdefghij"))) )
(test
   "86AF0001"
   (adler32 (need 100000 0)) )
(test
   "79660B4D"
   (adler32 (need 100000 97)) )

# Mur 1 2 3
(test
   205847345
   (mur1 (mapcar char) Seed) )
(test
   2732521653
   (mur1 (mapcar char (chop "1")) Seed) )
(test
   910852522
   (mur1 (mapcar char (chop "12")) Seed) )
(test
   4190283997
   (mur1 (mapcar char (chop "123")) Seed) )
(test
   1538038661
   (mur1 (mapcar char (chop "1234")) Seed) ) 
(test
   4275453765
   (mur1 (mapcar char (chop "12345")) Seed) )
(test
   1210843918
   (mur1 (mapcar char (chop "123456")) Seed) )
(test
   1651173853
   (mur1 (mapcar char (chop "1234567")) Seed) )
(test
   352993231
   (mur1 (mapcar char (chop "mike")) Seed) )
(test
   2195360465
   (mur2 (mapcar char) Seed) )
(test
   2636261578
   (mur2 (mapcar char (chop "1")) Seed) )
(test
   2042071592
   (mur2 (mapcar char (chop "12")) Seed) )
(test
   3068897829
   (mur2 (mapcar char (chop "123")) Seed) )
(test
   3849419663
   (mur2 (mapcar char (chop "1234")) Seed) )
(test
   2615926962
   (mur2 (mapcar char (chop "12345")) Seed) )
(test
   4281510290
   (mur2 (mapcar char (chop "123456")) Seed) )
(test
   3316504741
   (mur2 (mapcar char (chop "1234567")) Seed) )
(test
   2235285516
   (mur3 (mapcar char) Seed) )
(test
   3089878719
   (mur3 (mapcar char (chop "1")) Seed) )
(test
   3265283232
   (mur3 (mapcar char (chop "12")) Seed) )
(test
   1678347533
   (mur3 (mapcar char (chop "123")) Seed) )
(test
   785304072
   (mur3 (mapcar char (chop "1234")) Seed) )
(test
   1303726497
   (mur3 (mapcar char (chop "12345")) Seed) )
(test
   4135123539
   (mur3 (mapcar char (chop "123456")) Seed) )
(test
   2835963541
   (mur3 (mapcar char (chop "1234567")) Seed) )

# djb
(test
   5381
   (djb (mapcar char)) )
(test
   177622
   (djb (mapcar char (chop "1"))) )
(test
   5861576
   (djb (mapcar char (chop "12"))) )
(test
   193432059
   (djb (mapcar char (chop "123"))) )
(test
   2088290703
   (djb (mapcar char (chop "1234"))) )
(test
   194116516
   (djb (mapcar char (chop "12345"))) )
(test
   2110877786
   (djb (mapcar char (chop "123456"))) )
(test
   939490257
   (djb (mapcar char (chop "1234567"))) )

# cityhash
(test
   3696677242
   (city32) )
(test
   2552028077
   (city32 (mapcar char (chop "1"))) )
(test
   1527950834
   (city32 (mapcar char (chop "1234"))) )
(test
   2946287185
   (city32 (mapcar char (chop "12345"))) )
(test
   3307383567
   (city32 (mapcar char (chop "123456789012"))) )
(test
   297541912
   (city32 (mapcar char (chop "1234567890123"))) )
(test
   143204817
   (city32 (mapcar char (chop "123456789012345678901234"))) )
(test
   1623903661
   (city32 (mapcar char (chop "1234567890123456789012345"))) )
(test
   3719585337
   (city32 (mapcar char (chop "12345678901234567890123451234567890123456789012345"))) )
(test
   68138409
   (city32 (mapcar char (chop "1234567890123456789012345123456789012345678901234512345678901234567890123451234567890123456789012345"))) )

# LUCKY777
(let S 12345
   (test 2330272333 (lucky777 (need 1 255) S))
   (test 3456128086 (lucky777 (need 1 255) S S))
   (test 2925380670 (lucky777 (need 1 255) S S S))
   (test 4247623031 (lucky777 (need 2 255) S))
   (test 783991108  (lucky777 (need 2 255) S S))
   (test 3308923909 (lucky777 (need 2 255) S S S))
   (test 3180646147 (lucky777 (need 3 255) S))
   (test 2310340481 (lucky777 (need 3 255) S S))
   (test 3027425117 (lucky777 (need 3 255) S S S))
   (test 2440761407 (lucky777 (need 4 255) S))
   (test 656514323  (lucky777 (need 4 255) S S))
   (test 462908382  (lucky777 (need 4 255) S S S))
   (test 1670431469 (lucky777 (need 5 255) S))
   (test 2806078727 (lucky777 (need 5 255) S S))
   (test 475530743  (lucky777 (need 5 255) S S S))
   (test 3924761605 (lucky777 (need 6 255) S))
   (test 2988036179 (lucky777 (need 6 255) S S))
   (test 3850831620 (lucky777 (need 6 255) S S S))
   (test 3221304464 (lucky777 (need 7 255) S))
   (test 893711535  (lucky777 (need 7 255) S S))
   (test 1987433316 (lucky777 (need 7 255) S S S))
   (test 219255541  (lucky777 (need 8 255) S))
   (test 2185618467 (lucky777 (need 8 255) S S))
   (test 1148212683 (lucky777 (need 8 255) S S S))
   (test 2821877826 (lucky777 (need 9 255) S))
   (test 4090939879 (lucky777 (need 9 255) S S))
   (test 2263152726 (lucky777 (need 9 255) S S S))
   (test 1932935104 (lucky777 (need 10 255) S))
   (test 598038840  (lucky777 (need 10 255) S S))
   (test 2164709823 (lucky777 (need 10 255) S S S)) )
(msg 'Hash-ALL-OK)

