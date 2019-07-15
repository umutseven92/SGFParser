
import 'package:sgf_parser/gameAttributes.dart';
import 'package:sgf_parser/move.dart';

class Game {
  final GameAttributes attributes;
  final List<Move> moves;

  Game(this.attributes, this.moves);
}