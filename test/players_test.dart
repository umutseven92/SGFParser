import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/game/color.dart';
import 'package:sgf_parser/game/player.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  test('Can parse players', () {
    const sgfString =
        '(;FF[4]GM[1]SZ[19]AP[]US[]EV[74th Honinbo challenger decision match]PC[]PB[Shibano Toramaru]PW[]WR[9d]KM[6.5]RE[W+1.5]DT[2019-04-10]TM[0];';

    var parser = SGFParser(sgfString);
    var blackPlayer = parser.parseBlackPlayer();
    var whitePlayer = parser.parseWhitePlayer();

    expect(blackPlayer, equals(Player(Color.Black, 'Shibano Toramaru', null)));
    expect(whitePlayer, equals(Player(Color.White, null, '9d')));
  });
}
