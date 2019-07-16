import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('White Player name field', () {
    test('Can parse White Player name', () {
      const sgfString =
          'RE[W+1.5]PW[Rick James]EV[74th Honinbo challenger decision match]';
      var parser = SGFParser(sgfString);
      var event = parser.parseWhitePlayerName();
      expect(event, equals('Rick James'));
    });

    test('White Player name can be null', () {
      const sgfString = 'RE[W+1.5]DT[2019-04-10]';
      var parser = SGFParser(sgfString);
      var event = parser.parseWhitePlayerName();
      expect(event, equals(null));
    });
  });
}
