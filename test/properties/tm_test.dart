import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Time', () {
    test('Can parse time', () {
      const sgfString = '(;FF[4]TM[90]SZ[19]';
      var parser = SGFParser(sgfString);
      var time = parser.parseTime();
      expect(time, equals(90));
    });

    test('Time can be null', () {
      const sgfString = '(;GM[1]SZ[19]FF[4]';
      var parser = SGFParser(sgfString);
      var time = parser.parseTime();
      expect(time, equals(null));
    });
  });
}
