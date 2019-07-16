import 'package:sgf_parser/properties/boardSize.dart';
import 'package:sgf_parser/properties/fileFormat.dart';
import 'package:sgf_parser/properties/gameType.dart';

class GameAttributes {
  final DateTime date;
  final GameType gameType;
  final BoardSize boardSize;
  final FileFormat fileFormat;
  final String event;

  GameAttributes(
      this.fileFormat, this.date, this.gameType, this.boardSize, this.event);
}
