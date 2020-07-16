#include <stdio.h>
#include <netdb.h>
//#include <arpa/inet.h>
//#include <netinet/in.h>


int main (void) {
    struct addrinfo hints;

	// memset(&hints, 0, sizeof hints);
	// hints.ai_family = AF_UNSPEC; // AF_INET or AF_INET6 to force version
	// hints.ai_socktype = SOCK_STREAM;

    printf("%p\n", &hints.ai_flags);
    printf("%p\n", &hints.ai_family);
    printf("%p\n", &hints.ai_socktype);
    printf("%p\n", &hints.ai_protocol);
    printf("%p\n", &hints.ai_addrlen);
    printf("%p\n", &hints.ai_canonname);
    printf("%p\n", &hints.ai_addr);
    printf("%p\n", &hints.ai_next);

}

