import 'package:sgf_parser/game/player.dart';
import 'package:sgf_parser/properties/boardSize.dart';
import 'package:sgf_parser/properties/fileFormat.dart';
import 'package:sgf_parser/properties/gameType.dart';

class GameAttributes {
  final DateTime date;
  final GameType gameType;
  final BoardSize boardSize;
  final FileFormat fileFormat;
  final String event;
  final String application;
  final String user;
  final String place;
  final Player whitePlayer;
  final Player blackPlayer;

  GameAttributes(
      this.fileFormat,
      this.date,
      this.gameType,
      this.boardSize,
      this.event,
      this.application,
      this.user,
      this.place,
      this.whitePlayer,
      this.blackPlayer);
}
