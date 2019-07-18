import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/exceptions/invalidPropertyValueException.dart';
import 'package:sgf_parser/properties/fileFormat.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('File Format field', () {
    test('Can parse file format', () {
      const sgfString = '(;FF[4]GM[1]SZ[19]';
      var parser = SGFParser(sgfString);
      var ff = parser.parseFileFormat();
      expect(ff, equals(FileFormat.FF4));
    });

    test('File format default value is FF[1]', () {
      const sgfString = '(;GM[1]SZ[19]TM[0]';
      var parser = SGFParser(sgfString);
      var ff = parser.parseFileFormat();
      expect(ff, equals(FileFormat.FF1));
    });
    
    test('Invalid File format throws InvalidPropertyValueException', () {
      const sgfString = '(;FF[abc]GM[1]SZ[19]TM[0]';
      var parser = SGFParser(sgfString);
      expect(() => parser.parseFileFormat(),
          throwsA(isInstanceOf<InvalidPropertyValueException>()));
    });

    test('File format lower than 1 throws InvalidPropertyValueException', () {
      const sgfString = '(;FF[0]GM[1]SZ[19]TM[0]';
      var parser = SGFParser(sgfString);
      expect(() => parser.parseFileFormat(),
          throwsA(isInstanceOf<InvalidPropertyValueException>()));
    });

    test('File format higher than 4 throws InvalidPropertyValueException', () {
      const sgfString = '(;FF[5]GM[1]SZ[19]TM[0]';
      var parser = SGFParser(sgfString);
      expect(() => parser.parseFileFormat(),
          throwsA(isInstanceOf<InvalidPropertyValueException>()));
    });

  });
}
