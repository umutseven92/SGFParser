import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Black Player name field', () {
    test('Can parse Black Player name', () {
      const sgfString =
          'RE[W+1.5]PB[Rick James]EV[74th Honinbo challenger decision match]';
      var parser = SGFParser(sgfString);
      var event = parser.parseBlackPlayerName();
      expect(event, equals('Rick James'));
    });

    test('Black Player name can be null', () {
      const sgfString = 'RE[W+1.5]DT[2019-04-10]';
      var parser = SGFParser(sgfString);
      var event = parser.parseBlackPlayerName();
      expect(event, equals(null));
    });
  });
}
