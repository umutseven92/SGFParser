import 'package:equatable/equatable.dart';
import 'package:sgf_parser/game/color.dart';

class Player extends Equatable {
  final Color color;
  final String? name;
  final String? rank;

  Player(this.color, this.name, this.rank);

  @override
  // TODO: implement props
  List<Object?> get props => [color, name, rank];
}
