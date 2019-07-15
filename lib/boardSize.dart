
class BoardSize {
  int columns;
  int rows;

  BoardSize(this.columns, this.rows);

  BoardSize.square(int size) {
    columns = size;
    rows = size;
  }
}