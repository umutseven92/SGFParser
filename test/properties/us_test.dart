import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('User field', () {
    test('Can parse user', () {
      const sgfString =
          'RE[W+1.5]US[Rick James]EV[74th Honinbo challenger decision match]';
      var parser = SGFParser(sgfString);
      var event = parser.parseUser();
      expect(event, equals('Rick James'));
    });

    test('User can be null', () {
      const sgfString = 'RE[W+1.5]DT[2019-04-10]';
      var parser = SGFParser(sgfString);
      var event = parser.parseUser();
      expect(event, equals(null));
    });
  });
}
