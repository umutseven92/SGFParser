import 'package:equatable/equatable.dart';

class BoardSize extends Equatable {
  final int columns;
  final int rows;

  BoardSize(this.columns, this.rows) : super([columns, rows]);

  factory BoardSize.square(int size) {
    return BoardSize(size, size);
  }
}
