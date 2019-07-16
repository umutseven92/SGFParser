import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/properties/boardSize.dart';
import 'package:sgf_parser/properties/gameType.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Board Size field', () {
    test('Can parse square Board Size', () {
      const sgfString = '(;FF[4]GM[3]SZ[19]';
      var parser = SGFParser(sgfString);
      var boardSize = parser.parseBoardSize(GameType.Go);
      expect(boardSize, equals(BoardSize.square(19)));
    });

    test('Can parse rectangle Board Size', () {
      const sgfString = '(;FF[4]GM[3]SZ[12:14]';
      var parser = SGFParser(sgfString);
      var boardSize = parser.parseBoardSize(GameType.Go);
      expect(boardSize, equals(BoardSize(12, 14)));
    });

    test('Board Size default value is 19 if game is go', () {
      const sgfString = '(;FF[4]TM[0]GM[1]';
      var parser = SGFParser(sgfString);
      var boardSize = parser.parseBoardSize(GameType.Go);
      expect(boardSize, equals(BoardSize.square(19)));
    });

    test('Board Size default value is 8 if game is chess', () {
      const sgfString = '(;FF[4]GM[2]TM[0]';
      var parser = SGFParser(sgfString);
      var boardSize = parser.parseBoardSize(GameType.Chess);
      expect(boardSize, equals(BoardSize.square(8)));
    });
  });
}
