library sgf_parser;

import 'package:sgf_parser/game/player.dart';
import 'package:sgf_parser/properties/boardSize.dart';
import 'package:sgf_parser/exceptions/gameTypeNotSupportedException.dart';
import 'package:sgf_parser/properties/fileFormat.dart';
import 'package:sgf_parser/game/game.dart';
import 'package:sgf_parser/game/gameAttributes.dart';
import 'package:sgf_parser/properties/gameType.dart';
import 'package:sgf_parser/game/move.dart';
import 'package:sgf_parser/game/color.dart';

class SGFParser {
  final List<GameType> supportedGameTypes = <GameType>[
    GameType.Go,
    GameType.Chess
  ];
  final String sgf;

  T _parse<T>(String attribute, T Function(String) converter, [T defaultVal]) {
    var exp = RegExp(attribute + r'\[(.*?)\]');
    var match = exp.firstMatch(sgf)?.group(1);

    if (match == null || match.isEmpty) {
      if (defaultVal == null) {
        return null;
      }
      return defaultVal;
    }
    return converter(match);
  }

  List<Move> parseMoves() {
    var moves = <Move>[];
    var exp = RegExp(r';(.?)\[(.*?)\]');
    var matches = exp.allMatches(sgf);

    matches.forEach((match) {
      Color player = match.group(1) == 'B' ? Color.Black : Color.White;
      String moveString = match.group(2);

      Move move;
      if (moveString == '' || moveString == 'tt') {
        move = Move.pass(player);
      } else {
        move = Move(player, moveString[0], moveString[1]);
      }

      moves.add(move);
    });

    return moves;
  }

  GameAttributes _parseAttributes() {
    FileFormat ff = parseFileFormat();
    GameType type = parseGameType();
    BoardSize size = parseBoardSize(type);
    DateTime date = parseDate();
    String event = parseEvent();
    String application = parseApplication();
    String user = parseUser();
    String place = parsePlace();
    Player blackPlayer = parseBlackPlayer();
    Player whitePlayer = parseWhitePlayer();
    double komi = parseKomi(type);
    String result = parseResult();
    int time = parseTime();

    return GameAttributes(ff, date, type, size, event, application, user, place,
        blackPlayer, whitePlayer, komi, result, time);
  }

  BoardSize parseBoardSize(GameType gameType) {
    BoardSize defaultValue;

    if (gameType == GameType.Go) {
      defaultValue = BoardSize.square(19);
    } else if (gameType == GameType.Chess) {
      defaultValue = BoardSize.square(8);
    }

    BoardSize size = _parse('SZ', (match) {
      if (match.contains(':')) {
        var exp = RegExp(r'(\d+?):(\d+)');
        var col = exp.firstMatch(match).group(1);
        var row = exp.firstMatch(match).group(2);

        return BoardSize(int.parse(col), int.parse(row));
      } else {
        return BoardSize.square(int.parse(match));
      }
    }, defaultValue);

    return size;
  }

  GameType parseGameType() {
    GameType type = _parse(
        'GM', (match) => GameType.values[int.parse(match) - 1], GameType.Go);

    if (!supportedGameTypes.contains(type)) {
      throw GameTypeNotSupportedException(type, supportedGameTypes);
    }
    return type;
  }

  FileFormat parseFileFormat() {
    return _parse('FF', (match) => FileFormat.values[int.parse(match) - 1],
        FileFormat.FF1);
  }

  DateTime parseDate() {
    return _parse('DT', DateTime.parse);
  }

  String parseEvent() {
    return _parse('EV', (match) => match);
  }

  String parseApplication() {
    return _parse('AP', (match) => match);
  }

  String parseUser() {
    return _parse('US', (match) => match);
  }

  String parsePlace() {
    return _parse('PC', (match) => match);
  }

  String parseWhitePlayerName() {
    return _parse('PW', (match) => match);
  }

  String parseWhitePlayerRank() {
    return _parse('WR', (match) => match);
  }

  Player parseWhitePlayer() {
    var name = parseWhitePlayerName();
    var rank = parseWhitePlayerRank();

    return Player(Color.White, name, rank);
  }

  String parseBlackPlayerName() {
    return _parse('PB', (match) => match);
  }

  String parseBlackPlayerRank() {
    return _parse('BR', (match) => match);
  }

  Player parseBlackPlayer() {
    var name = parseBlackPlayerName();
    var rank = parseBlackPlayerRank();

    return Player(Color.Black, name, rank);
  }

  double parseKomi(GameType type) {
    if (type == GameType.Go) {
      return _parse('KM', (match) => double.parse(match), 0);
    }

    return null;
  }

  String parseResult() {
    return _parse('RE', (match) => match, '?');
  }

  int parseTime() {
    return _parse('TM', (match) => int.parse(match));
  }

  Game parse() {
    var attributes = _parseAttributes();
    var moves = parseMoves();

    return Game(attributes, moves);
  }

  SGFParser(this.sgf);
}
