import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/exceptions/invalidMoveException.dart';
import 'package:sgf_parser/game/move.dart';
import 'package:sgf_parser/game/color.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  group('Moves', () {
    test('Can parse moves', () {
      const sgfString = 'GM[1];B[pd];W[dp];B[pq];W[dc]';
      var parser = SGFParser(sgfString);
      var moves = parser.parseMoves();

      expect(moves.length, equals(4));
    });

    test('Can parse moves in correct order', () {
      const sgfString = 'GM[1];B[pd];W[dp];B[pq];W[dc]';
      var parser = SGFParser(sgfString);
      var moves = parser.parseMoves();

      expect(moves[0], equals(Move(Color.Black, 'p', 'd')));
      expect(moves[1], equals(Move(Color.White, 'd', 'p')));
      expect(moves[2], equals(Move(Color.Black, 'p', 'q')));
      expect(moves[3], equals(Move(Color.White, 'd', 'c')));
    });

    test('Invalid Move throws InvalidMoveException', () {
      const sgfString = 'GM[1];B[pdc];W[dp];B[pq];W[dc]';
      var parser = SGFParser(sgfString);
      expect(() => parser.parseMoves(),
          throwsA(isInstanceOf<InvalidMoveException>()));
    });

    test('Invalid Move (with numbers) throws InvalidMoveException',
        () {
      const sgfString = 'GM[1];B[2c];W[dp];B[pq];W[dc]';
      var parser = SGFParser(sgfString);
      expect(() => parser.parseMoves(),
          throwsA(isInstanceOf<InvalidMoveException>()));
    });

    test('Can parse passes (empty)', () {
      const sgfString = 'GM[1];B[pd];W[];B[pq];W[dc]';
      var parser = SGFParser(sgfString);
      var moves = parser.parseMoves();

      expect(moves[0], equals(Move(Color.Black, 'p', 'd')));
      expect(moves[1], equals(Move.pass(Color.White)));
      expect(moves[2], equals(Move(Color.Black, 'p', 'q')));
      expect(moves[3], equals(Move(Color.White, 'd', 'c')));
    });

    test('Can parse passes (tt)', () {
      const sgfString = 'GM[1];B[pd];W[tt];B[pq];W[dc]';
      var parser = SGFParser(sgfString);
      var moves = parser.parseMoves();

      expect(moves[0], equals(Move(Color.Black, 'p', 'd')));
      expect(moves[1], equals(Move.pass(Color.White)));
      expect(moves[2], equals(Move(Color.Black, 'p', 'q')));
      expect(moves[3], equals(Move(Color.White, 'd', 'c')));
    });
  });
}
