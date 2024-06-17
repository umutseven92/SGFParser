import 'package:equatable/equatable.dart';
import 'package:sgf_parser/game/color.dart';

class Move extends Equatable {
  final Color player;
  final String? column;
  final String? row;

  Move(this.player, this.column, this.row);

  factory Move.pass(Color player) {
    return Move(player, null, null);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [player, column, row];
}
