all:
	gcc -fPIC -c -Wall -std=gnu99 tweetnacl.c
	gcc -shared -Wl,-soname,libtweet.so.0 -o libtweet.so.0 tweetnacl.o -lc
	cp -uf libtweet.so.0 /usr/local/lib
	# blake2b
	gcc -fPIC -DED25519_BLAKE2B -c -Wall -std=gnu99 tweetnacl.c
	gcc -shared -Wl,-soname,libtweetb.so.0 -o libtweetb.so.0 tweetnacl.o -lc
	cp -uf libtweetb.so.0 /usr/local/lib
	ldconfig
clean:
	rm -rf *.o *.0