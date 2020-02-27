### february 2020

Lets write notes how to check Monocypher by compcert
```
Monocypher 3.0.0
Compcert 3.6
```


# get ready opam and libraries
### update before installed opam infrastructure
```
$ opam update
$ opam upgrade
$ eval $(opam env)
$ opam switch 4.07.1 # or 'opam switch create 4.07.1'
$ eval `opam env`
$ opam install coq=8.9.1
$ opam install menhir=20190626
```

### compile and install
```
$ cd
$ wget http://compcert.inria.fr/release/compcert-3.6.tgz
$ tar zxvf compcert-3.6.tgz
$ cd CompCert-3.6
$ ./configure -prefix /home/mpech/ccomp36 x86_64-linux
$ make -j 8 all
$ make install
```

