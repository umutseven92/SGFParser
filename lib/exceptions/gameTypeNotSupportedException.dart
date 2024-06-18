import 'package:sgf_parser/properties/gameType.dart';

class GameTypeNotSupportedException implements Exception {
  String? cause;

  GameTypeNotSupportedException(
      GameType type, List<GameType> supportedGameTypes) {
    cause = 'Game Type $type is not supported. (Supported games: ${supportedGameTypes.toString()})';
  }
}
