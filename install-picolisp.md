# you have fresh installed CentOS 7 x64 (Minimal)

## bootstrap via pil32
```
yum update
yum install wget git gcc openssl-devel openssl-libs.i686 openssl-devel.i686 glibc-devel.i686 glibc-devel libgcc.i686
reboot
<after reboot>
cd /home/user
git clone https://github.com/picolisp/picolisp.git
cd picolisp/src
make
make tools gate
export PATH=$PATH:/home/user/picolisp
pil @lib/test.l
OK
: (bye)
```
* ready to compile pil64

## bootstrap via JDK
* the same machine, same installation
* clean prev. pil32 compilation and install Java

```
cd picolisp/src
make clean
rm ../bin/picolisp
yum install java-1.8.0-openjdk
```
* ready to compile pil64

## bootstrap via *.s files
*
```
# cd picolisp
# wget https://software-lab.de/x86-64.linux.tgz
# tar zxvf x86-64.linux.tgz
```
* ready to compile pil64


