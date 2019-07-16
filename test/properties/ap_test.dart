import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Application field', () {
    test('Can parse application', () {
      const sgfString =
          'RE[W+1.5]AP[CGoban:1.6.2]EV[74th Honinbo challenger decision match]';
      var parser = SGFParser(sgfString);
      var event = parser.parseApplication();
      expect(event, equals('CGoban:1.6.2'));
    });

    test('Application can be null', () {
      const sgfString = 'RE[W+1.5]DT[2019-04-10]';
      var parser = SGFParser(sgfString);
      var event = parser.parseApplication();
      expect(event, equals(null));
    });
  });
}
