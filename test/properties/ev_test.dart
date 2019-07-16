import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Event field', () {
    test('Can parse event', () {
      const sgfString =
          'RE[W+1.5]DT[2019-04-10]EV[74th Honinbo challenger decision match]';
      var parser = SGFParser(sgfString);
      var event = parser.parseEvent();
      expect(event, equals('74th Honinbo challenger decision match'));
    });

    test('Event can be null', () {
      const sgfString = 'RE[W+1.5]DT[2019-04-10]';
      var parser = SGFParser(sgfString);
      var event = parser.parseEvent();
      expect(event, equals(null));
    });
  });
}
