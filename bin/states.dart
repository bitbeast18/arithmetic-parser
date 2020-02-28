import 'utils.dart';

void S(var parser) {
  if (parser.isValid && !parser.reachedEnd) {
    var head = parser.tape[parser.head];

    if (isINT(head)) {
      parser.incrementHead();
      B(parser);
    } else if (isSGN(head)) {
      parser.incrementHead();
      A(parser);
    } else {
      parser.isValid = false;
    }
  } else {
    parser.isValid = false;
  }
}

void A(var parser) {
  if (parser.isValid && !parser.reachedEnd) {
    var head = parser.tape[parser.head];

    if (isINT(head)) {
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

void B(var parser) {
  if (parser.isValid && !parser.reachedEnd) {
    var head = parser.tape[parser.head];

    if (isOPR(head)) {
      parser.tokens.add(Token('INT'));
      parser.incrementHead();
      C(parser);
    } else if (isINT(head)) {
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

void C(var parser) {
  if (parser.isValid && !parser.reachedEnd) {
    var head = parser.tape[parser.head];

    if (isINT(head)) {
      parser.tokens.add(Token('OPR'));
      parser.incrementHead();
      B(parser);
    } else if (isSGN(head)) {
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
