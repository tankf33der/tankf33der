```
https://preshing.com/20141119/how-to-build-a-gcc-cross-compiler/
https://wiki.osdev.org/GCC_Cross-Compiler#The_Build
https://rtime.felk.cvut.cz/hw/index.php/How_to_build_GNU_cross-compilers
https://gcc-renesas.com/wiki/index.php?title=Building_the_RL78_Toolchain_under_Ubuntu_14.04
Linux from scratch
gentoo link on wiki
archlinux
```

```
copy from
https://gist.github.com/resetnow/1b55beed32f3eb3f90513896565ef5c0
```

## Set environment variables

```bash
export TARGET=aarch64-none-elf
export PREFIX=/work/public/$TARGET
export PATH=$PATH:$PREFIX/bin
```

## Build binutils
```shell
mkdir build-binutils
cd build-binutils
../binutils-source/configure --target=$TARGET --prefix=$PREFIX
make all
make install
```

## Prerequisite libs
```shell
cd gcc-source
bash ./contrib/download_prerequisites
cd ..
```
prerequisite libs (GMP/MPFR/MPC), put them into gcc director, and link statically.

If not, the system gmp/mpft/mpc libraries will be used, and linked dynamically.

http://advogato.org/person/redi/diary/253.html

## Build gcc
```
mkdir build-gcc
cd build-gcc
../gcc-source/configure --target=$TARGET --prefix=$PREFIX --without-header --with-newlib --with-gnu-as --with-gnu-ld --enable-lto --enable-linker-build-id --disable-libmudflap --disable-libgomp --disable-libssp --disable-libstdcxx-pch --enable-multiarch --disable-multilib --enable-languages=c,c++ --with-headers=../newlib-source/newlib/libc/include --disable-shared
make
make install
```

## Build newlib
```shell
mkdir build-newlib
cd build-newlib
../newlib-source/configure --target=$TARGET --prefix=$PREFIX
make -j8
make install
```

## Build GCC again with newlib
```shell
cd build-gcc
make -j8
make install
```

## Build GDB
```shell
mkdir build-gdb
cd build-gdb
../gdb-source/configure --target=$TARGET --prefix=$PREFIX --enable-interwork
```

## Errors

### checking for the value of EOF... configure: error: computing EOF failed
```
--with-headers=../newlib-source/newlib/libc/include
```

### error while loading shared libraries: libmpc.so.2
Please refer to <a href="#prerequisite-libs">step 3</a>


