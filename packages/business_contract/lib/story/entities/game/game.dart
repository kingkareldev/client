import '../commands/group/root_command.dart';
import 'game_board.dart';
import 'robot_coords.dart';

class Game {
  final String description;
  final String taskDescription;

  final RootCommand initialCommands;
  final RootCommand commands;

  final Coords initialRobotCoords;
  final Coords resultRobotCoords;
  final Coords robotCoords;

  final GameBoard initialGrid;
  final GameBoard resultGrid;
  final GameBoard grid;

  final bool completed;

  final int speedLimit;
  final int? speed;

  final int sizeLimit;
  final int? size;

  Game({
    required this.description,
    required this.taskDescription,
    required this.initialCommands,
    RootCommand? commands,
    required this.initialRobotCoords,
    required this.resultRobotCoords,
    Coords? robotCoords,
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
    Coords? robotCoords,
    GameBoard? grid,
    bool? completed,
    int? speed,
    int? size,
  }) {
    return Game(
      description: description,
      taskDescription: taskDescription,
      initialCommands: initialCommands.clone(),
      commands: commands ?? this.commands.clone(),
      initialRobotCoords: initialRobotCoords.clone(),
      resultRobotCoords: resultRobotCoords.clone(),
      robotCoords: robotCoords ?? this.robotCoords.clone(),
      initialGrid: initialGrid.clone(),
      resultGrid: resultGrid.clone(),
      grid: grid ?? this.grid.clone(),
      completed: completed ?? this.completed,
      speedLimit: speedLimit,
      speed: speed,
      sizeLimit: sizeLimit,
      size: size,
    );
  }

  Game clone() {
    return copyWith();
  }

  bool isCompleted() {
    if (!robotCoords.isEqual(resultRobotCoords)) {
      return false;
    }

    if (!grid.isEqual(resultGrid)) {
      return false;
    }

    return true;
  }
}
