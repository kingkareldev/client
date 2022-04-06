import '../common/direction.dart';

class Coords {
  final int x;
  final int y;

  Coords({required this.x, required this.y});

  Coords move(Direction moveDirection) {
    switch (moveDirection) {
      case Direction.up:
        return Coords(x: x, y: y - 1);
      case Direction.right:
        return Coords(x: x + 1, y: y);
      case Direction.down:
        return Coords(x: x, y: y + 1);
      case Direction.left:
        return Coords(x: x - 1, y: y);
    }
  }

  @override
  String toString() {
    return 'x: $x, y: $y';
  }

  bool isEqual(Coords other) {
    return x == other.x && y == other.y;
  }

  Coords clone() {
    return Coords(x: x, y: y);
  }

  factory Coords.fromJson(Map<String, dynamic> json) {
    return Coords(
      x: json['x'],
      y: json['y'],
    );
  }
}
