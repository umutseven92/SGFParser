import 'package:sgf_parser/player.dart';

class Move {
  final Player player;
  String column;
  String row;

  Move(this.player, this.column, this.row);

  Move.pass(this.player);
}
