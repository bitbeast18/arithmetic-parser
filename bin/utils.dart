class Token {
  String type;

  Token(String input) {
    type = input;
  }
}

bool isOPR(String input) {
  return ['+', '-', '*', '/'].contains(input);
}

bool isINT(String input) {
  return 48 <= input.codeUnitAt(0) && input.codeUnitAt(0) <= 57;
}

bool isSGN(String input) {
  return ['+', '-'].contains(input);
}

bool isEND(var parser) {
  return parser.head >= parser.tapeLength;
}
