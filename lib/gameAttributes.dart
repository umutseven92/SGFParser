import 'package:sgf_parser/boardSize.dart';
import 'package:sgf_parser/fileFormat.dart';
import 'package:sgf_parser/gameType.dart';

class GameAttributes {
  final DateTime date;
  final GameType gameType;
  final BoardSize boardSize;
  final FileFormat fileFormat;
  final String event;

  GameAttributes(
      this.fileFormat, this.date, this.gameType, this.boardSize, this.event);
}
