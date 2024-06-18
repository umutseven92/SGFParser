class InvalidMoveException implements Exception {
  String? cause;

  InvalidMoveException(String move) {
    cause = 'Invalid move $move.';
  }
}
