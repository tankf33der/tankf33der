## you have fresh installed CentOS 7 x64 (Minimal)

# bootstrap via pil32
* ```# yum update```
* ```# yum install git gcc openssl-devel openssl-libs.i686 openssl-devel.i686 glibc-devel.i686 glibc-devel libgcc.i686
* ```# reboot```
* 
```
# cd
# git clone https://github.com/picolisp/picolisp.git
# cd picolisp/src
# make
# make tools gate
```


