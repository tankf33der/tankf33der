Emergency aid kit for pil64 (x64) only to bootstrap without everything.
No warranty, you definitely should not trust me.

=====
Info:
=====

# ldd picolisp
        not a dynamic executable
# file picolisp
picolisp: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, stripped
# ./picolisp
: (== 1 1)
-> T
: (version)
19.2.7
-> (19 2 7)
# xz -t picolisp.xz
# xz -l picolisp.xz
Strms  Blocks   Compressed Uncompressed  Ratio  Check   Filename
    1       1     80.6 KiB    210.8 KiB  0.382  CRC64   picolisp.xz


======
Usage:
======

# md5sum picolisp.xz
3d0b26ec2261831bb40377550c896aa4  picolisp.xz
# cp picolisp.xz to picolisp/bin
# xz -d	picolisp/bin/picolisp.xz
# cd picolisp/src64
# make ## --> rewritten by new recompiled version
# pil @lib/test.l +
