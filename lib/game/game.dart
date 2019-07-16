import 'package:sgf_parser/game/gameAttributes.dart';
import 'package:sgf_parser/game/move.dart';

class Game {
  final GameAttributes attributes;
  final List<Move> moves;

  Game(this.attributes, this.moves);
}
