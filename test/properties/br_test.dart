import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Black Player rank field', () {
    test('Can parse Black Player rank', () {
      const sgfString =
          'RE[W+1.5]BR[3d]EV[74th Honinbo challenger decision match]';
      var parser = SGFParser(sgfString);
      var event = parser.parseBlackPlayerRank();
      expect(event, equals('3d'));
    });

    test('Black Player rank can be null', () {
      const sgfString = 'RE[W+1.5]DT[2019-04-10]';
      var parser = SGFParser(sgfString);
      var event = parser.parseBlackPlayerRank();
      expect(event, equals(null));
    });
  });
}
