import 'dart:io';

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

class Token {
  String type;

  Token(String input) {
    type = input;
  }
}

class Utils {
  static bool isOPR(String input) {
    return ['+', '-', '*', '/'].contains(input);
  }

  static bool isINT(String input) {
    return 48 <= input.codeUnitAt(0) && input.codeUnitAt(0) <= 57;
  }

  static bool isSGN(String input) {
    return ['+', '-'].contains(input);
  }

  static bool isEND(Parser parser) {
    return parser.head >= parser.tapeLength;
  }
}

class States {
  static void S(Parser parser) {
    if (parser.isValid && !parser.reachedEnd) {
      var head = parser.tape[parser.head];

      if (Utils.isINT(head)) {
        parser.incrementHead();
        B(parser);
      } else if (Utils.isSGN(head)) {
        parser.incrementHead();
        A(parser);
      } else {
        parser.isValid = false;
      }
    } else {
      parser.isValid = false;
    }
  }

  static void A(Parser parser) {
    if (parser.isValid && !parser.reachedEnd) {
      var head = parser.tape[parser.head];

      if (Utils.isINT(head)) {
        parser.tokens.add(Token('SGN'));
        parser.incrementHead();
        B(parser);
      } else {
        parser.isValid = false;
      }
    } else {
      parser.isValid = false;
    }
  }

  static void B(Parser parser) {
    if (parser.isValid && !parser.reachedEnd) {
      var head = parser.tape[parser.head];

      if (Utils.isOPR(head)) {
        parser.tokens.add(Token('INT'));
        parser.incrementHead();
        C(parser);
      } else if (Utils.isINT(head)) {
        parser.incrementHead();
        B(parser);
      } else {
        parser.isValid = false;
      }
    } else {
      if (parser.reachedEnd) {
        parser.tokens.add(Token('INT'));
      }
    }
  }

  static void C(Parser parser) {
    if (parser.isValid && !parser.reachedEnd) {
      var head = parser.tape[parser.head];

      if (Utils.isINT(head)) {
        parser.tokens.add(Token('OPR'));
        parser.incrementHead();
        B(parser);
      } else if (Utils.isSGN(head)) {
        parser.tokens.add(Token('OPR'));
        parser.incrementHead();
        A(parser);
      } else {
        parser.isValid = false;
      }
    } else {
      parser.isValid = false;
    }
  }
}

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
    States.S(this);
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
