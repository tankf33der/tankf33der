#!/usr/bin/env pike

int main()
  {
    string s;
    array line;
    int a;
    int b;

    while(s = Stdio.stdin.gets()) {
         line = s / " ";
         if (sizeof(line) == 1) {
            write("%d\n", line[0]);
            continue;
	     }
         a = (int)line[0];
         b = (int)line[2];
         switch(line[1]) {
	    case "+":
              write("%d\n", a+b);
              break;
	    case "-":
              write("%d\n", a-b);
              break;
       	    case "*":
              write("%d\n", a*b);
              break;
 	    case "/":
              write("%d\n", a/b);
              break;
 	    case "%":
              write("%d\n", a%b);
              break;
 	    case ">":
              write("%d\n", a>b);
              break;
 	    case "<":
              write("%d\n", a<b);
              break;
 	    case "<=":
              write("%d\n", a<=b);
              break;
	    case ">=":
              write("%d\n", a>=b);
              break;
 	    case "&":
              write("%d\n", a&b);
              break;
	    case "|":
              write("%d\n", a|b);
              break;
	    case "^":
              write("%d\n", a^b);
              break;
         }
    }
  }
