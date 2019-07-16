import 'package:flutter_test/flutter_test.dart';
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
  });
}
