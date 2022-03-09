import 'package:main/model/command.dart';

class Game {
  final RootCommand initialCommands;
  final RootCommand commands;

  final RobotCoords initialRobotCoords;
  final RobotCoords resultRobotCoords;
  final RobotCoords robotCoords;

  final GameBoard initialGrid;
  final GameBoard resultGrid;
  final GameBoard grid;

  final bool completed;

  final int speedLimit;
  final int? speed;

  final int sizeLimit;
  final int? size;

  Game({
    required this.initialCommands,
    RootCommand? commands,
    required this.initialRobotCoords,
    required this.resultRobotCoords,
    RobotCoords? robotCoords,
    required this.initialGrid,
    required this.resultGrid,
    GameBoard? grid,
    this.completed = false,
    required this.speedLimit,
    this.speed,
    required this.sizeLimit,
    this.size,
  })  : commands = commands ?? initialCommands,
        robotCoords = robotCoords ?? initialRobotCoords,
        grid = grid ?? initialGrid;

  Game copyWith({
    RootCommand? commands,
    RobotCoords? robotCoords,
    GameBoard? grid,
    bool? completed,
    int? speed,
    int? size,
  }) {
    return Game(
      initialCommands: initialCommands,
      commands: commands ?? this.commands,
      initialRobotCoords: initialRobotCoords,
      resultRobotCoords: resultRobotCoords,
      robotCoords: robotCoords ?? this.robotCoords,
      initialGrid: initialGrid,
      resultGrid: resultGrid,
      grid: grid ?? this.grid,
      completed: completed ?? this.completed,
      speedLimit: speedLimit,
      speed: speed ?? this.speed,
      sizeLimit: sizeLimit,
      size: size ?? this.size,
    );
  }
}

class GameBoard {
  final List<GameRow> rows;

  GameBoard(this.rows);
}

class GameRow {
  final List<GameCell> cells;

  GameRow(this.cells);
}

abstract class GameCell {}

class WallCell extends GameCell {}

class HiddenCell extends GameCell {}

class WalkableCell extends GameCell {
  int numberOfMarks;

  WalkableCell([this.numberOfMarks = 0]);
}

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

final gameTmp = Game(
  initialCommands: RootCommand([
    SingleCommand('a'),
    SingleCommand('b'),
    SingleCommand('c'),
    SingleCommand('d'),
    SingleCommand('e'),
    GroupCommand('lol', []),
    GroupCommand('lol2', []),
    GroupCommand('lol3', []),
  ]),
  commands: null,
  initialRobotCoords: RobotCoords(x: 1, y: 0),
  resultRobotCoords: RobotCoords(x: 0, y: 2),
  robotCoords: null,
  initialGrid: GameBoard([
    GameRow([
      WalkableCell(),
      WalkableCell(),
      WalkableCell(),
    ]),
    GameRow([
      WalkableCell(),
      WalkableCell(),
      WalkableCell(),
    ]),
    GameRow([
      HiddenCell(),
      WalkableCell(),
      WallCell(),
    ]),
  ]),
  resultGrid: GameBoard([
    GameRow([
      WalkableCell(),
      WalkableCell(),
      WalkableCell(),
    ]),
    GameRow([
      WalkableCell(),
      WalkableCell(),
      WalkableCell(),
    ]),
    GameRow([
      HiddenCell(),
      WalkableCell(),
      WallCell(),
    ]),
  ]),
  grid: null,
  completed: false,
  speedLimit: 10,
  speed: null,
  sizeLimit: 20,
  size: null,
);
