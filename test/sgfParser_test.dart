import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/game/color.dart';
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

    FileFormat expectedFormat = FileFormat.FF4;
    DateTime expectedDate = DateTime(2019, 4, 10);
    GameType expectedGameType = GameType.Go;
    BoardSize expectedBoardSize = BoardSize.square(19);
    String event = '74th Honinbo challenger decision match';
    Player blackPlayer = Player(Color.Black, 'Shibano Toramaru', '7d');
    Player whitePlayer = Player(Color.White, 'Kono Rin', '9d');
    double komi = 6.5;
    String result = 'W+1.5';

    expect(attributes.fileFormat, equals(expectedFormat));
    expect(attributes.date, equals(expectedDate));
    expect(attributes.gameType, equals(expectedGameType));
    expect(attributes.boardSize.rows, equals(expectedBoardSize.rows));
    expect(attributes.boardSize.columns, equals(expectedBoardSize.columns));
    expect(attributes.event, equals(event));
    expect(attributes.blackPlayer, equals(blackPlayer));
    expect(attributes.whitePlayer, equals(whitePlayer));
    expect(attributes.komi, equals(komi));
    expect(attributes.result, equals(result));

    expect(attributes.application, equals(null));
    expect(attributes.user, equals(null));
    expect(attributes.place, equals(null));
  });
}
