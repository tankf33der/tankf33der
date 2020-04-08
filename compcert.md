### March 2020

Lets write notes how to check Monocypher by CompCert
```
Monocypher 3.1.0
Compcert 3.7
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
If you already have ocamp-opam ecosystem installed and updated above then only:
```
$ eval $(opam env)
```
```
$ cd
$ wget http://compcert.inria.fr/release/compcert-3.7.tgz
$ tar zxvf compcert-3.7.tgz
$ mkdir -p /home/mpech/ccomp37
$ cd CompCert-3.7
$ ./configure -prefix /home/mpech/ccomp37 x86_64-linux
$ make -j 8 all
$ make install
$ export PATH=$PATH:/home/mpech/ccomp37/bin
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
$ ccomp -interp mike.c
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
$ comment free() call in vector_test(). Helps for: Stuck state: calling free(0LL)
$ add code to the end of mike.c file
int
memcmp (const void *str1, const void *str2, size_t count)
{
  register const unsigned char *s1 = (const unsigned char*)str1;
  register const unsigned char *s2 = (const unsigned char*)str2;

  while (count-- > 0)
    {
      if (*s1++ != *s2++)
	  return s1[-1] < s2[-1] ? -1 : 1;
    }
  return 0;
}
void *memcpy(void *__restrict __dest, const void *__restrict __src, size_t __n)
{
   char *csrc = (char *)__src;
   char *cdest = (char *)__dest;
   for (int i=0; i<__n; i++)
       cdest[i] = csrc[i];
}
$ function main() in the end of file, comment all TEST() calls
$ uncomment one by one and run:
$ ccomp -interp -quiet mike.c
$ for every test.
$ Elliptic is very fat (one key ~1GB RAM). Create vectors.h for 1 test only.
$ rm -rf Monocypher/tests/formal-analysis
```

Mike, you are cool.
