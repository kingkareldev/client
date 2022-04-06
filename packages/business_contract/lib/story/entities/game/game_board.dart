import 'game_cell.dart';
import 'game_row.dart';
import 'robot_coords.dart';

class GameBoard {
  final List<GameRow> rows;

  GameBoard(this.rows);

  GameBoard clone() {
    List<GameRow> rowsTmp = [];

    for (var element in rows) {
      rowsTmp.add(element.clone());
    }

    return GameBoard(rowsTmp);
  }

  GameBoard withGrabMark(Coords coords) {
    GameBoard tmp = clone();
    GameCell cell = tmp.rows[coords.y].cells[coords.x];
    if (cell is WalkableCell) {
      cell.numberOfMarks--;
    }
    return tmp;
  }

  GameBoard withPutMark(Coords coords) {
    GameBoard tmp = clone();
    GameCell cell = tmp.rows[coords.y].cells[coords.x];
    if (cell is WalkableCell) {
      cell.numberOfMarks++;
    }
    return tmp;
  }

  bool isEqual(GameBoard other) {
    if (rows.length != other.rows.length) {
      return false;
    }

    for (int i = 0; i < rows.length; i++) {
      if (!rows[i].isEqual(other.rows[i])) {
        return false;
      }
    }

    return true;
  }

  factory GameBoard.fromJson(Map<String, dynamic> json) {
    List<GameRow> rows = [];

    for (var rowData in json['rows']) {
      rows.add(GameRow.fromJson(rowData));
    }

    return GameBoard(
      rows,
    );
  }
}
