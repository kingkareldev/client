abstract class GameCell {
  bool isEqual(GameCell other) {
    // If both are walkable cells, compare it's attributes.
    if (this is WalkableCell && other is WalkableCell) {
      return (this as WalkableCell).numberOfMarks == other.numberOfMarks;
    }

    // Don't care about the specific sub classes of non walkable cell.
    if (this is NonWalkableCell && other is NonWalkableCell) {
      return true;
    }

    return false;
  }

  GameCell clone();
}

/// The robot can walk to this position.
class WalkableCell extends GameCell {
  int numberOfMarks;
  static const maxNumberOfMarks = 8;

  WalkableCell({this.numberOfMarks = 0});

  @override
  WalkableCell clone() {
    return WalkableCell(numberOfMarks: numberOfMarks);
  }
}

/// The robot cannot walk to this position.
abstract class NonWalkableCell extends GameCell {}

class WallCell extends NonWalkableCell {
  @override
  WallCell clone() {
    return WallCell();
  }
}

class ForestCell extends NonWalkableCell {
  @override
  ForestCell clone() {
    return ForestCell();
  }
}

class WaterCell extends NonWalkableCell {
  @override
  WaterCell clone() {
    return WaterCell();
  }
}
