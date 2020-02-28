import 'dart:io';
import 'states.dart';
import 'utils.dart';

// Deterministic Finite Automata to parse arithmetic expressions.
// Has 4 states S, A, B, C and is a minimal DFA.
// S is the starting state and B is the accepting state.
// The dead state is omitted and a property `isValid` is used.
// Look for Grammar.md for details.

// Usage: Enter integers and operators. Integers can be signed.
//        When finished enter 'exit' to end the program.
//        Note: Spaces are not allowed.

// Tokens: INT => Integer. [0,..,9]
//         SGN => Sign of Integer. ['+', '-']
//         OPR => Operator. ['+', '-', '*', '/']

class Parser {
  int head;
  int tapeLength;

  bool isValid = true;
  bool reachedEnd = false;

  String tape;
  List<Token> tokens = [];

  Parser(String input) {
    tape = input;
    head = 0;
    tapeLength = input.length;
  }

  void parse() {
    S(this);
  }

  void incrementHead() {
    head++;
    if (head >= tapeLength) {
      reachedEnd = true;
    }
  }
}

void main(List<String> arguments) {
  while (true) {
    var input = stdin.readLineSync().trim();

    if (input == 'exit') {
      return;
    }

    if (input.contains(' ')) {
      print('Spaces are not allowed!');
      continue;
    }

    var parser = Parser(input);

    parser.parse();

    if (parser.isValid) {
      print('Accepted');
      for (var token in parser.tokens) {
        stdout.write(token.type + ' ');
      }
      print('');
    } else {
      print('Expected Integer at ${parser.head + 1}');
      print(parser.tape);
      print((' ' * parser.head) + '^');
    }
  }
}
