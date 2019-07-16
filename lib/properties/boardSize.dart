class BoardSize {
  final int columns;
  final int rows;

  BoardSize(this.columns, this.rows);

  factory BoardSize.square(int size) {
    return BoardSize(size, size);
  }
}
