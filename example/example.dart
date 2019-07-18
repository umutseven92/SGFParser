import 'package:sgf_parser/game/game.dart';
import 'package:sgf_parser/game/gameAttributes.dart';
import 'package:sgf_parser/game/move.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  // This is a (shortened) real example, of the 74th Honinbo challenger decision match played by Shibano Toramaru 7d as Black and Kono Rin as White 9d.
  const sgfString =
      '(;FF[4]GM[1]SZ[19]AP[]US[]EV[74th Honinbo challenger decision match]PC[]PB[Shibano Toramaru]BR[7d]PW[Kono Rin]WR[9d]KM[6.5]RE[W+1.5]DT[2019-04-10]TM[0];B[pd];W[dp];B[pq];W[dc];B[ce];W[cg];B[cq];W[cp];B[dq];W[fq])';

  // Initialize the parser with the SGF contents
  SGFParser parser = SGFParser(sgfString);
  Game game = parser.parse();

  // Attributes contain all non-move properties
  GameAttributes attributes = game.attributes;

  // Moves are listed in order
  List<Move> moves = game.moves;

  print(attributes);
  print(moves);
}
