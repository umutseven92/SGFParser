import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/exceptions/invalidPropertyValueException.dart';
import 'package:sgf_parser/properties/gameType.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Komi field', () {
    test('Can parse komi', () {
      const sgfString = '(;FF[4]KM[6.5]SZ[19]';
      var parser = SGFParser(sgfString);
      var komi = parser.parseKomi(GameType.Go);
      expect(komi, equals(6.5));
    });

    test('Komi default value is 0 if GM[1]', () {
      const sgfString = '(;GM[1]SZ[19]TM[0]';
      var parser = SGFParser(sgfString);
      var komi = parser.parseKomi(GameType.Go);
      expect(komi, equals(null));
    });

    test('Komi is ignored if game type is not GM[1]', () {
      const sgfString = '(;GM[2]SZ[19]KM[6.5]TM[0]';
      var parser = SGFParser(sgfString);
      var komi = parser.parseKomi(GameType.Chess);
      expect(komi, equals(null));
    });

    test('Invalid Komi throws InvalidPropertyValueException', () {
      const sgfString = '(;GM[1]SZ[19]KM[abv]';
      var parser = SGFParser(sgfString);
      expect(() => parser.parseKomi(GameType.Go), throwsA(isInstanceOf<InvalidPropertyValueException>()));
    });

    test('Komi lower than 0 throws InvalidPropertyValueException', () {
      const sgfString = '(;GM[1]SZ[19]KM[-1]';
      var parser = SGFParser(sgfString);
      expect(() => parser.parseKomi(GameType.Go), throwsA(isInstanceOf<InvalidPropertyValueException>()));
    });
  });
}
