import 'commands/command.dart';
import 'game_board.dart';
import 'game_cell.dart';
import 'game_row.dart';
import 'robot_coords.dart';

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
