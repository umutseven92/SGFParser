library sgf_parser;

import 'package:sgf_parser/exceptions/gameTypeNotSupportedException.dart';
import 'package:sgf_parser/exceptions/invalidMoveException.dart';
import 'package:sgf_parser/exceptions/invalidPropertyValueException.dart';
import 'package:sgf_parser/game/color.dart';
import 'package:sgf_parser/game/game.dart';
import 'package:sgf_parser/game/gameAttributes.dart';
import 'package:sgf_parser/game/move.dart';
import 'package:sgf_parser/game/player.dart';
import 'package:sgf_parser/properties/boardSize.dart';
import 'package:sgf_parser/properties/fileFormat.dart';
import 'package:sgf_parser/properties/gameType.dart';

class SGFParser {
  final List<GameType> supportedGameTypes = <GameType>[GameType.Go, GameType.Chess];
  final String sgf;
  static const int fiftyTwo = 52;
  static const int intMaxValue = 9223372036854775807;

  T _parse<T>(String attribute, T Function(String)? converter, {required T defaultVal}) {
    var exp = RegExp(attribute + r'\[(.*?)\]');
    var match = exp.firstMatch(sgf)?.group(1);

    if (match == null || match.isEmpty) {
      return defaultVal;
    }

    if (converter == null) {
      return match as T;
    }
    return converter(match);
  }

  int _parseWithRange(String property, String match, int min, int max) {
    var result = int.tryParse(match);
    if (result == null || result < min || result > max) {
      throw InvalidPropertyValueException(property, match);
    }
    return result;
  }

  List<Move> parseMoves() {
    var moves = <Move>[];
    var exp = RegExp(r';(.?)\[(.*?)\]');
    var matches = exp.allMatches(sgf);

    matches.forEach((match) {
      Color player = match.group(1) == 'B' ? Color.Black : Color.White;
      String? moveString = match.group(2);

      var moveExp = RegExp(r'^[a-zA-Z]{2}$');

      if (moveString != '' && !moveExp.hasMatch(moveString!)) {
        throw InvalidMoveException(moveString);
      }

      Move move;
      if (moveString == '' || moveString == 'tt') {
        move = Move.pass(player);
      } else {
        move = Move(player, moveString?[0], moveString?[1]);
      }

      moves.add(move);
    });

    return moves;
  }

  GameAttributes _parseAttributes() {
    FileFormat ff = parseFileFormat();
    GameType type = parseGameType();
    BoardSize size = parseBoardSize(type);
    DateTime? date = parseDate();
    String? event = parseEvent();
    String? application = parseApplication();
    String? user = parseUser();
    String? place = parsePlace();
    Player blackPlayer = parseBlackPlayer();
    Player whitePlayer = parseWhitePlayer();
    double? komi = parseKomi(type);
    String result = parseResult();
    int? time = parseTime();

    return GameAttributes(
        ff, date, type, size, event, application, user, place, blackPlayer, whitePlayer, komi, result, time);
  }

  BoardSize parseBoardSize(GameType gameType) {
    BoardSize defaultValue = BoardSize.square(0);

    if (gameType == GameType.Go) {
      defaultValue = BoardSize.square(19);
    } else if (gameType == GameType.Chess) {
      defaultValue = BoardSize.square(8);
    }

    BoardSize size = _parse('SZ', (match) {
      if (match.contains(':')) {
        var exp = RegExp(r'(\d+?):(\d+)');
        var col = exp.firstMatch(match)?.group(1);
        var row = exp.firstMatch(match)?.group(2);

        var colResult = _parseWithRange('SZ', col!, 1, gameType == GameType.Go ? 52 : intMaxValue);
        var rowResult = _parseWithRange('SZ', row!, 1, gameType == GameType.Go ? 52 : intMaxValue);

        if (colResult == rowResult) {
          throw InvalidPropertyValueException('SZ', match);
        }

        return BoardSize(colResult, rowResult);
      } else {
        var result = _parseWithRange('SZ', match, 1, gameType == GameType.Go ? 52 : intMaxValue);

        return BoardSize.square(result);
      }
    }, defaultVal: defaultValue);

    return size;
  }

  GameType parseGameType() {
    GameType type = _parse('GM', (match) {
      var result = _parseWithRange('GM', match, 1, 40);
      return GameType.values[result - 1];
    }, defaultVal: GameType.Go);

    if (!supportedGameTypes.contains(type)) {
      throw GameTypeNotSupportedException(type, supportedGameTypes);
    }
    return type;
  }

  FileFormat parseFileFormat() {
    return _parse('FF', (match) {
      var result = _parseWithRange('FF', match, 1, 4);
      return FileFormat.values[result - 1];
    }, defaultVal: FileFormat.FF1);
  }

  DateTime? parseDate() {
    return _parse('DT', (match) {
      var result = DateTime.tryParse(match);
      if (result == null) {
        throw InvalidPropertyValueException('DT', match);
      }
      return result;
    }, defaultVal: null);
  }

  String? parseEvent() {
    return _parse('EV', (match) {
      return match;
    }, defaultVal: null);
  }

  String? parseApplication() {
    return _parse('AP', (match) {
      return match;
    }, defaultVal: null);
  }

  String? parseUser() {
    return _parse('US', (match) {
      return match;
    }, defaultVal: null);
  }

  String? parsePlace() {
    return _parse('PC', (match) {
      return match;
    }, defaultVal: null);
  }

  String? parseWhitePlayerName() {
    return _parse('PW', (match) {
      return match;
    }, defaultVal: null);
  }

  String? parseWhitePlayerRank() {
    return _parse('WR', (match) {
      return match;
    }, defaultVal: null);
  }

  Player parseWhitePlayer() {
    var name = parseWhitePlayerName();
    var rank = parseWhitePlayerRank();

    return Player(Color.White, name, rank);
  }

  String? parseBlackPlayerName() {
    return _parse('PB', (match) {
      return match;
    }, defaultVal: null);
  }

  String? parseBlackPlayerRank() {
    return _parse('BR', (match) {
      return match;
    }, defaultVal: null);
  }

  Player parseBlackPlayer() {
    var name = parseBlackPlayerName();
    var rank = parseBlackPlayerRank();

    return Player(Color.Black, name, rank);
  }

  double? parseKomi(GameType type) {
    if (type == GameType.Go) {
      return _parse('KM', (match) {
        var result = double.tryParse(match);

        if (result == null || result < 0) {
          throw InvalidPropertyValueException('KM', match);
        }
        return result;
      }, defaultVal: null);
    }

    return null;
  }

  String parseResult() {
    return _parse('RE', (match) {
      var exp = RegExp(
          r'^Draw|^Void|^\?|^0|^B\+\d\.*\d*|^W\+\d\.*\d*|^B\+R$|^W\+R$|^B\+Resign|^W\+Resign|^B\+T$|^W\+T$|^B\+Time$|^W\+Time$|^B\+F$|^W\+F$|^B\+Forfeit|^W\+Forfeit');
      if (exp.hasMatch(match)) {
        return match;
      } else {
        throw InvalidPropertyValueException('RE', match);
      }
    }, defaultVal: '?');
  }

  int? parseTime() {
    return _parse('TM', (match) => int.parse(match), defaultVal: null);
  }

  Game parse() {
    var attributes = _parseAttributes();
    var moves = parseMoves();

    return Game(attributes, moves);
  }

  SGFParser(this.sgf);
}
