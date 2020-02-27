### february 2020

Lets write notes how to check Monocypher by CompCert
```
Monocypher 3.0.0
Compcert 3.6
```
### get opam ready
```
$ opam update
$ opam upgrade
$ eval $(opam env)
$ opam switch 4.07.1 # or 'opam switch create 4.07.1'
$ eval $(opam env)
$ opam install coq=8.9.1
$ opam install menhir=20190626
```

### compile and install
```
$ cd
$ wget http://compcert.inria.fr/release/compcert-3.6.tgz
$ tar zxvf compcert-3.6.tgz
$ mkdir -p /home/mpech/ccomp36
$ cd CompCert-3.6
$ ./configure -prefix /home/mpech/ccomp36 x86_64-linux
$ make -j 8 all
$ make install
$ export PATH=$PATH:/home/mpech/ccomp36/bin
```

### try compile mode
```
$ cd Monocypher
$ make clean
$ ccomp -o test.out -Wall -fall -O3 -Isrc -Isrc/optional tests/test.c tests/utils.c src/monocypher.c src/optional/monocypher-ed25519.c
$ ./test.out
<All tests OK!>
$ make clean
```

### try interp mode
```
$ cd Monocypher
$ make clean
$ bash tests/formal-analysis.sh
$ cd tests/formal-analysis
$ cat monocypher.c >> mike.c
$ cat monocypher-ed25519.c >> mike.c
$ cat utils.c >> mike.c
$ cat test.c >> mike.c
$ $ ccomp -interp mike.c
mike.c:2310: warning: "FOR" redefined
 2310 | #define FOR(i, min, max)     for (size_t i = min; i < max; i++)
      |
mike.c:60: note: this is the location of the previous definition
   60 | #define FOR(i, start, end)         FOR_T(size_t, i, start, end)
      |
In file included from mike.c:2699:
utils.h:65: warning: "FOR" redefined
   65 | #define FOR(i, start, end) for (size_t i = (start); i < (end); i++)
      |
mike.c:2310: note: this is the location of the previous definition
 2310 | #define FOR(i, min, max)     for (size_t i = min; i < max; i++)
      |
mike.c:2705: error: redefinition of 'store64_le'
mike.c:2717: error: redefinition of 'load32_le'
mike.c:2725: error: redefinition of 'load64_le'
3 errors detected.

$ fix errors by comment them
$ XXX
$ function main is last in file mike.c
$ comment all TEST calls
$ uncomment one by one
```
