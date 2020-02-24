package main

import (
	"fmt"
	"github.com/agl/ed25519/extra25519"
)

func main() {
    var pub, pub2, rep, prv [32]byte
	fmt.Println("mike")
    extra25519.ScalarBaseMult(&pub, &rep, &prv)
    fmt.Println(prv)
    fmt.Println(pub)
    fmt.Println(rep)
    extra25519.RepresentativeToPublicKey(&pub2, &rep)
    fmt.Println(pub2)
}

