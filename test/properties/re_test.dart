import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Result', () {
    test('Can parse result', () {
      const sgfString = '(;FF[4]RE[W+1.5]SZ[19]';
      var parser = SGFParser(sgfString);
      var result = parser.parseResult();
      expect(result, equals('W+1.5'));
    });

    test('Result default value is ?', () {
      const sgfString = '(;GM[1]SZ[19]TM[0]';
      var parser = SGFParser(sgfString);
      var result = parser.parseResult();
      expect(result, equals('?'));
    });

  });

}
