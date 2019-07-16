import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Place field', () {
    test('Can parse place', () {
      const sgfString =
          'RE[W+1.5]PC[Tokyo]EV[74th Honinbo challenger decision match]';
      var parser = SGFParser(sgfString);
      var event = parser.parsePlace();
      expect(event, equals('Tokyo'));
    });

    test('Place can be null', () {
      const sgfString = 'RE[W+1.5]DT[2019-04-10]';
      var parser = SGFParser(sgfString);
      var event = parser.parsePlace();
      expect(event, equals(null));
    });
  });
}
