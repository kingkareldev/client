import 'game_cell.dart';

class GameRow {
  final List<GameCell> cells;

  GameRow(this.cells);

  bool isEqual(GameRow other) {
    if (cells.length != other.cells.length) {
      return false;
    }

    for (int i = 0; i < cells.length; i++) {
      if (!cells[i].isEqual(other.cells[i])) {
        return false;
      }
    }

    return true;
  }

  GameRow clone() {
    List<GameCell> cellsTmp = [];

    for (var element in cells) {
      cellsTmp.add(element.clone());
    }

    return GameRow(cellsTmp);
  }

  factory GameRow.fromJson(Map<String, dynamic> json) {
    List<GameCell> cells = [];

    for (var cellData in json['cells']) {
      cells.add(GameCell.fromJson(cellData));
    }

    return GameRow(
      cells,
    );
  }
}
