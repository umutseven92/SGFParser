import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/exceptions/invalidPropertyValueException.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Date field', () {
    test('Can parse date', () {
      const sgfString = 'RE[W+1.5]DT[2019-04-10]TM[0]';
      var parser = SGFParser(sgfString);
      var date = parser.parseDate();
      expect(date, equals(DateTime(2019, 4, 10)));
    });

    test('Date can be null', () {
      const sgfString = 'RE[W+1.5]TM[0]';
      var parser = SGFParser(sgfString);
      var date = parser.parseDate();
      expect(date, equals(null));
    });

    test('Invalid Date should throw InvalidPropertyValueException', () {
      const sgfString = 'RE[W+1.5]TM[0]DT[abc]';
      var parser = SGFParser(sgfString);
      expect(() => parser.parseDate(), throwsA(isInstanceOf<InvalidPropertyValueException>()));
    });
  });
}
