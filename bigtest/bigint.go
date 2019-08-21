package main
import (
	"fmt"
	"math/big"
	"bufio"
	"os"
	"strings"
)

func main() {
	a := new(big.Int)
	b := new(big.Int)
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		line := strings.Fields(scanner.Text())
		a.SetString(line[0], 10)
		if(len(line) == 1) {
			fmt.Println(a)
			continue
		}
		b.SetString(line[2], 10)
		switch line[1] {
		case "+": fmt.Println(a.Add(a, b))
		case "-": fmt.Println(a.Sub(a, b))
		case "*": fmt.Println(a.Mul(a, b))
		case "/": fmt.Println(a.Div(a, b))
		case "%": fmt.Println(a.Mod(a, b))
		case "&": fmt.Println(a.And(a, b))
		case "|": fmt.Println(a.Or(a, b))
      case "xor": fmt.Println(a.Xor(a, b))
		case "<<": fmt.Println(a.Lsh(a, 1024))
		case ">>": fmt.Println(a.Rsh(a, 64))
		}
	}
}
