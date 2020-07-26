import std.stdio;
import std.string;
import std.bigint;
import std.conv;

void main() {
    foreach (line; stdin.byLine) {
        auto s = line.split(" ");
        BigInt a = s[0];
        if(s.length == 1) {
          writeln(a);
          continue;
        }
        BigInt b = s[2];
        switch(s[1]) {
         case "+":  writeln(a + b); break;
         case "-":  writeln(a - b); break;
         case "*":  writeln(a * b); break;
         case "/":  writeln(a / b); break;
         case "%":  writeln(a % b); break;
         case "&":  writeln(a & b); break;
         case "|":  writeln(a | b); break;
         case "^":  writeln(a ^ b); break;
         case ">":  writeln(a > b); break;
         case ">=":  writeln(a >= b); break;
         case "<":  writeln(a < b); break;
         case "<=":  writeln(a <= b); break;
         case "=":  writeln(a == b); break;
         case "<<": writeln(a << b.to!int); break;
         case ">>": writeln(a >> b.to!int); break;
         default: break;
        }
    }
}

