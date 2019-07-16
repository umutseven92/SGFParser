import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('White Player rank field', () {
    test('Can parse White Player rank', () {
      const sgfString =
          'RE[W+1.5]WR[15kyu]EV[74th Honinbo challenger decision match]';
      var parser = SGFParser(sgfString);
      var event = parser.parseWhitePlayerRank();
      expect(event, equals('15kyu'));
    });

    test('White Player rank can be null', () {
      const sgfString = 'RE[W+1.5]DT[2019-04-10]';
      var parser = SGFParser(sgfString);
      var event = parser.parseWhitePlayerRank();
      expect(event, equals(null));
    });
  });
}
