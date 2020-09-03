import java.math.BigInteger;
import java.util.*;

public class Bigtest
{
    public static void main(String args[]) throws Exception
    {
        Scanner scanner = new Scanner(System.in);
		BigInteger a, b;
		String line;
		String s[];

        while(true) {
        	line = scanner.nextLine();
			s = line.split(" ");
			a = new BigInteger(s[0]);
			if (s.length == 1) {
				System.out.println(a);
				continue;
			}
			b = new BigInteger(s[2]);
			switch(s[1]) {
				case "+":
					System.out.println(a.add(b));
					break;
				case "-":
					System.out.println(a.subtract(b));
					break;
				case "*":
					System.out.println(a.multiply(b));
					break;
				case "/":
					System.out.println(a.divide(b));
					break;
				case "%":
					System.out.println(a.mod(b));
					break;
				case "&":
					System.out.println(a.and(b));
					break;
				case "|":
					System.out.println(a.or(b));
					break;
				case "^":
					System.out.println(a.xor(b));
					break;
				case ">>":
					System.out.println(a.shiftRight(b.intValue()));
					break;
				case "<<":
					System.out.println(a.shiftLeft(b.intValue()));
					break;

				default:
					System.out.println("default");
					break;
			}

        }
    }
}
