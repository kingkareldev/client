enum Direction {
  up,
  right,
  down,
  left,
}

class RobotCoords {
  final int x;
  final int y;

  RobotCoords({required this.x, required this.y});

  RobotCoords move(Direction moveDirection) {
    switch (moveDirection) {
      case Direction.up:
        return RobotCoords(x: x, y: y - 1);
      case Direction.right:
        return RobotCoords(x: x + 1, y: y);
      case Direction.down:
        return RobotCoords(x: x, y: y + 1);
      case Direction.left:
        return RobotCoords(x: x - 1, y: y);
    }
  }

  @override
  String toString() {
    return 'x: $x, y: $y';
  }
}
