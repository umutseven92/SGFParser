import 'package:equatable/equatable.dart';
import 'package:sgf_parser/game/player.dart';

class Move extends Equatable {
  final Player player;
  final String column;
  final String row;

  Move(this.player, this.column, this.row) : super([player, column, row]);

  factory Move.pass(Player player) {
    return Move(player, null, null);
  }
}
