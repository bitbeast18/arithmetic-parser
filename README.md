- ### A more concrete Format Preserving List parser lives [here](https://github.com/bitbeast18/fpl-parser).
- ### Also, the package:yaml [fork](https://github.com/bitbeast18/yaml) has a prototype for dumping mechanism.

- Both of the above tasks are targetted to be completed before 4th of May, 2020.

> This is a "Getting started" task for GSoC 2020. You can refer to the code but please DO NOT COPY it. 
> Also, there is a attached license that says the same!

---

# What's this about?
A simple parser that does lexical analysis and validates the arithmetic expression according to the prescribed grammar.

# How do I run it on my machine?
Just `clone` the repo and run `bin/main.dart` file

# Code structure

```bash
bin
  |-- main.dart
  |-- utils.dart # defines the 'Token' class and utilities that implement the 'Scanner'.
  |-- states.dart # defines the embeddings for DFA.
```

# Examples
```bash 
$ dart bin/main.dart

>> 3
Accepted
INT

>> 3+33/3-3
Accepted
INT OPR INT OPR INT OPR INT OPR INT

>> -3+2
Accepted
SGN INT OPR INT

>> -3+-2
Accepted
SGN INT OPR SGN INT

>> 2*/2+3
Expected Integer at 3
2*/2+3
  ^
>> exit
```
