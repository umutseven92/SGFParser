import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/exceptions/gameTypeNotSupportedException.dart';
import 'package:sgf_parser/properties/gameType.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Game Type field', () {
    test('Can parse Game Type', () {
      const sgfString = '(;FF[4]GM[3]SZ[19]';
      var parser = SGFParser(sgfString);
      var gameType = parser.parseGameType();
      expect(gameType, equals(GameType.Chess));
    });

    test('Game Type default value is Go', () {
      const sgfString = '(;FF[4]SZ[19]TM[0]';
      var parser = SGFParser(sgfString);
      var gameType = parser.parseGameType();
      expect(gameType, equals(GameType.Go));
    });

    test('Unsupported Game Types should throw GameTypeNotSupportedException',
        () {
      const sgfString = '(;FF[4]GM[2]SZ[19]';
      var parser = SGFParser(sgfString);
      expect(() => parser.parseGameType(),
          throwsA(isInstanceOf<GameTypeNotSupportedException>()));
    });
  });
}
