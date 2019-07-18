import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/game/color.dart';
import 'package:sgf_parser/game/move.dart';
import 'package:sgf_parser/game/player.dart';
import 'package:sgf_parser/properties/boardSize.dart';
import 'package:sgf_parser/properties/fileFormat.dart';
import 'package:sgf_parser/game/gameAttributes.dart';
import 'package:sgf_parser/properties/gameType.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  test('Can parse full game', () {
    // This is a (shortened) real example, of the 74th Honinbo challenger decision match played by Shibano Toramaru 7d as Black and Kono Rin as White 9d.
    const sgfString =
        '(;FF[4]GM[1]SZ[19]AP[]US[]EV[74th Honinbo challenger decision match]PC[]PB[Shibano Toramaru]BR[7d]PW[Kono Rin]WR[9d]KM[6.5]RE[W+1.5]DT[2019-04-10]TM[0];B[pd];W[dp];B[pq];W[dc];B[ce];W[cg];B[cq];W[cp];B[dq];W[fq])';

    var parser = SGFParser(sgfString);
    var game = parser.parse();

    GameAttributes attributes = game.attributes;
    List<Move> moves = game.moves;

    FileFormat expectedFormat = FileFormat.FF4;
    DateTime expectedDate = DateTime(2019, 4, 10);
    GameType expectedGameType = GameType.Go;
    BoardSize expectedBoardSize = BoardSize.square(19);
    String expectedEvent = '74th Honinbo challenger decision match';
    Player expectedBlackPlayer = Player(Color.Black, 'Shibano Toramaru', '7d');
    Player expectedWhitePlayer = Player(Color.White, 'Kono Rin', '9d');
    double expectedKomi = 6.5;
    String expectedResult = 'W+1.5';
    int expectedTime = 0;

    List<Move> expectedMoves = [
      Move(Color.Black, 'p', 'd'),
      Move(Color.White, 'd', 'p'),
      Move(Color.Black, 'p', 'q'),
      Move(Color.White, 'd', 'c'),
      Move(Color.Black, 'c', 'e'),
      Move(Color.White, 'c', 'g'),
      Move(Color.Black, 'c', 'q'),
      Move(Color.White, 'c', 'p'),
      Move(Color.Black, 'd', 'q'),
      Move(Color.White, 'f', 'q'),
    ];

    expect(attributes.fileFormat, equals(expectedFormat));
    expect(attributes.date, equals(expectedDate));
    expect(attributes.gameType, equals(expectedGameType));
    expect(attributes.boardSize.rows, equals(expectedBoardSize.rows));
    expect(attributes.boardSize.columns, equals(expectedBoardSize.columns));
    expect(attributes.event, equals(expectedEvent));
    expect(attributes.blackPlayer, equals(expectedBlackPlayer));
    expect(attributes.whitePlayer, equals(expectedWhitePlayer));
    expect(attributes.komi, equals(expectedKomi));
    expect(attributes.result, equals(expectedResult));
    expect(attributes.time, equals(expectedTime));

    expect(attributes.application, equals(null));
    expect(attributes.user, equals(null));
    expect(attributes.place, equals(null));

    expect(moves, equals(expectedMoves));
  });
}
