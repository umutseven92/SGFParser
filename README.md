# SGF Parser

![Pub](https://img.shields.io/pub/v/sgf_parser.svg)

[Smart Game Format](https://en.wikipedia.org/wiki/Smart_Game_Format) parser for Flutter & Dart. Currently only supports Go.

## Supported Properties

AP, BR, DT, EV, FF, GM, KM, PB, PC, PW, RE, SZ, TM, US, WR, W, B

## Usage

```dart
// Initialize the parser with the SGF contents
SGFParser parser = SGFParser(sgfString);
Game game = parser.parse();

// Attributes contain all non-move properties
GameAttributes attributes = game.attributes;

// Moves are listed in order
List<Move> moves = game.moves;
```

Please see [here](https://github.com/umutseven92/SGFParser/blob/master/lib/example/example.dart) for a more concrete example.

## Todo

- Support for rest of the properties
- Variations
- Handicap
