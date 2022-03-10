abstract class GameCell {}

class WallCell extends GameCell {}

class HiddenCell extends GameCell {}

class WalkableCell extends GameCell {
  int numberOfMarks;

  WalkableCell([this.numberOfMarks = 0]);
}