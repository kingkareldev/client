import '../common/direction.dart';

abstract class DirectionCommand {
  Direction? direction;

  static Direction? directionFromJson(String? direction) {
    switch (direction) {
      case 'up':
        return Direction.up;
      case 'right':
        return Direction.right;
      case 'down':
        return Direction.down;
      case 'left':
        return Direction.left;
      default:
        return null;
    }
  }

  static String? directionToJson(Direction? direction) {
    switch (direction) {
      case Direction.up:
        return 'up';
      case Direction.right:
        return 'right';
      case Direction.down:
        return 'down';
      case Direction.left:
        return 'left';
      default:
        return null;
    }
  }
}
