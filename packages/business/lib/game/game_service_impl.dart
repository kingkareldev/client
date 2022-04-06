import 'dart:collection';
import 'dart:convert';

import 'package:business_contract/story/entities/commands/group/if_command.dart';
import 'package:business_contract/story/entities/commands/group/root_command.dart';
import 'package:business_contract/story/entities/commands/group/while_command.dart';
import 'package:business_contract/story/entities/commands/group_command.dart';
import 'package:business_contract/story/entities/commands/single/grab_mark_command.dart';
import 'package:business_contract/story/entities/commands/single/move_command.dart';
import 'package:business_contract/story/entities/commands/single/put_mark_command.dart';
import 'package:business_contract/story/entities/commands/single_command.dart';
import 'package:business_contract/story/entities/common/condition.dart';
import 'package:business_contract/story/entities/common/direction.dart';
import 'package:business_contract/story/entities/game/game.dart';
import 'package:business_contract/story/entities/game/game_board.dart';
import 'package:business_contract/story/entities/game/game_cell.dart';
import 'package:business_contract/story/entities/game/robot_coords.dart';
import 'package:business_contract/story/entities/mission/game_mission.dart';
import 'package:business_contract/story/repositories/mission_repository.dart';
import 'package:business_contract/story/services/game_service.dart';
import 'package:business_contract/story/services/game_service/process_game_error.dart';
import 'package:business_contract/story/services/game_service/process_game_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameServiceImpl extends GameService {
  final SharedPreferences storage;

  GameServiceImpl({required this.storage, required MissionRepository missionRepository})
      : super(missionRepository: missionRepository);

  @override
  Future<Game> parseGame(GameMission gameMission) {
    final initialCommandsData = RootCommand.fromJson(jsonDecode(gameMission.commandsInitial));
    final commandsData = RootCommand.fromJson(jsonDecode(gameMission.commands));

    final initialBoardData = GameBoard.fromJson(jsonDecode(gameMission.boardInitial));
    final resultBoardData = GameBoard.fromJson(jsonDecode(gameMission.boardResult));

    final initialRobotData = Coords.fromJson(jsonDecode(gameMission.robotInitial));
    final resultRobotData = Coords.fromJson(jsonDecode(gameMission.robotResult));

    return Future.value(Game(
      description: gameMission.description,
      taskDescription: gameMission.taskDescription,
      initialCommands: initialCommandsData,
      commands: commandsData,
      initialRobotCoords: initialRobotData,
      resultRobotCoords: resultRobotData,
      initialGrid: initialBoardData,
      resultGrid: resultBoardData,
      completed: gameMission.completed,
      speedLimit: gameMission.speedLimit,
      speed: gameMission.speed,
      sizeLimit: gameMission.sizeLimit,
      size: gameMission.size,
    ));
  }

  @override
  Future<bool> saveGame(Game game, String storyUlr, String gameUrl) async {
    String? token = _getToken();
    if (token == null) {
      return Future.value(false);
    }

    String commandsJson = jsonEncode(game.commands);

    bool success = await missionRepository.saveGame(
      token,
      storyUlr,
      gameUrl,
      commandsJson,
      game.size ?? 0,
      game.speed ?? 0,
      game.completed,
    );
    if (!success) {
      return Future.value(false);
    }

    return Future.value(true);
  }

  String? _getToken() {
    String? token = storage.getString('jwt');
    return token;
  }

  @override
  Queue<ProcessGameResult> processGame(Game game) {
    _ProcessHolder holder = _ProcessHolder(game: game.clone(), size: game.commands.countSize());

    if (!game.commands.isValid()) {
      return Queue.of([
        ProcessGameResult(
          game: holder.game.clone(),
          error: ProcessGameError.hasInvalidCommands,
        ),
      ]);
    }

    _processGroupCommand(
      processHolder: holder,
      command: holder.game.commands,
      index: [],
    );

    if (holder.shouldFinish) {
      return holder.queue;
    }

    // Add a last result that has all the data about whether the conditions are met.
    holder.game = holder.game.copyWith(
      size: holder.size,
      speed: holder.speed,
      completed: holder.game.isCompleted(),
    );
    holder.queue.add(
      ProcessGameResult(
        game: holder.game,
      ),
    );

    return holder.queue;
  }

  void _processGroupCommand({
    required _ProcessHolder processHolder,
    required GroupCommand command,
    required List<int> index,
  }) {
    if (processHolder.shouldFinish) {
      return;
    }

    processHolder.speed++;

    if (processHolder.speed > _ProcessHolder.speedLimit) {
      _failOnSpeed(processHolder: processHolder);
      return;
    }

    // Process root command with no restriction.
    if (command is RootCommand) {
      _processGroupChildren(processHolder: processHolder, command: command, index: index);
      return;
    }

    // Have to pass this section, or is returned.
    if (command is IfCommand) {
      processHolder.queue.add(
        ProcessGameResult(
          game: processHolder.game,
          commandIndex: index,
        ),
      );

      if (_processCondition(processHolder: processHolder, condition: command.condition)) {
        _processGroupChildren(processHolder: processHolder, command: command, index: index);
      }
      return;
    }

    // Have to pass this section, or is returned.
    if (command is WhileCommand) {
      while (_processCondition(processHolder: processHolder, condition: command.condition)) {
        processHolder.queue.add(
          ProcessGameResult(
            game: processHolder.game,
            commandIndex: index,
          ),
        );

        // While loop has to have this check,
        // so the loop end properly.
        if (processHolder.shouldFinish) {
          return;
        }
        _processGroupChildren(processHolder: processHolder, command: command, index: index);
      }

      processHolder.queue.add(
        ProcessGameResult(
          game: processHolder.game,
          commandIndex: index,
        ),
      );

      return;
    }
  }

  void _processGroupChildren({
    required _ProcessHolder processHolder,
    required GroupCommand command,
    required List<int> index,
  }) {
    int i = 0;

    for (final c in command.commands) {
      final tmpIndex = List<int>.from(index);
      tmpIndex.add(i);
      i++;

      if (c is GroupCommand) {
        _processGroupCommand(processHolder: processHolder, command: c, index: tmpIndex);
      }

      if (c is SingleCommand) {
        _processSingleCommand(processHolder: processHolder, command: c, index: tmpIndex);
      }
    }
  }

  void _processSingleCommand({
    required _ProcessHolder processHolder,
    required SingleCommand command,
    required List<int> index,
  }) {
    if (processHolder.shouldFinish) {
      return;
    }

    processHolder.speed++;

    if (processHolder.speed > _ProcessHolder.speedLimit) {
      _failOnSpeed(processHolder: processHolder);
      return;
    }

    if (command is MoveCommand) {
      // Direction is not null because all commands are valid at this point.
      final Coords moveCoords = processHolder.game.robotCoords.move(command.direction!);

      processHolder.game = processHolder.game.copyWith(
        robotCoords: moveCoords,
      );

      processHolder.queue.add(
        ProcessGameResult(
          game: processHolder.game,
          commandIndex: index,
        ),
      );

      if (!_isWalkableCell(board: processHolder.game.grid, coords: moveCoords)) {
        processHolder
          ..shouldFinish = true
          ..queue.add(
            ProcessGameResult(
              game: processHolder.game.clone(),
              error: ProcessGameError.invalidMove,
            ),
          );
        return;
      }
      return;
    }

    if (command is GrabMarkCommand) {
      if (!_canGrabMark(board: processHolder.game.grid, coords: processHolder.game.robotCoords)) {
        processHolder
          ..shouldFinish = true
          ..queue.add(
            ProcessGameResult(
              game: processHolder.game.clone(),
              error: ProcessGameError.invalidGrabMark,
            ),
          );
        return;
      }

      processHolder.game = processHolder.game.copyWith(
        grid: processHolder.game.grid.withGrabMark(processHolder.game.robotCoords),
      );
      processHolder.queue.add(
        ProcessGameResult(
          game: processHolder.game,
          commandIndex: index,
        ),
      );
      return;
    }

    if (command is PutMarkCommand) {
      if (!_canPutMark(board: processHolder.game.grid, coords: processHolder.game.robotCoords)) {
        processHolder
          ..shouldFinish = true
          ..queue.add(
            ProcessGameResult(
              game: processHolder.game.clone(),
              error: ProcessGameError.invalidPutMark,
            ),
          );
        return;
      }

      processHolder.game = processHolder.game.copyWith(
        grid: processHolder.game.grid.withPutMark(processHolder.game.robotCoords),
      );
      processHolder.queue.add(
        ProcessGameResult(
          game: processHolder.game,
          commandIndex: index,
        ),
      );
      return;
    }
  }

  bool _isWalkableCell({required GameBoard board, required Coords coords}) {
    // Out of the board to the top or to the left.
    if (coords.x < 0 || coords.y < 0) {
      return false;
    }

    // Out of the board to the bottom or to the right.
    if (coords.y >= board.rows.length || coords.x >= board.rows.first.cells.length) {
      return false;
    }

    GameCell cellToCheck = board.rows[coords.y].cells[coords.x];
    if (cellToCheck is WalkableCell) {
      return true;
    }

    return false;
  }

  bool _canPutMark({required GameBoard board, required Coords coords}) {
    if (!_isWalkableCell(board: board, coords: coords)) {
      return false;
    }

    WalkableCell cellToCheck = board.rows[coords.y].cells[coords.x] as WalkableCell;
    return cellToCheck.numberOfMarks < WalkableCell.maxNumberOfMarks;
  }

  bool _canGrabMark({required GameBoard board, required Coords coords}) {
    if (!_isWalkableCell(board: board, coords: coords)) {
      return false;
    }

    WalkableCell cellToCheck = board.rows[coords.y].cells[coords.x] as WalkableCell;
    return cellToCheck.numberOfMarks > 0;
  }

  bool _processCondition({
    required _ProcessHolder processHolder,
    required Condition? condition,
  }) {
    if (condition == null) {
      return false;
    }

    switch (condition) {
      case Condition.canMoveUp:
        final moveCoords = processHolder.game.robotCoords.move(Direction.up);
        return _isWalkableCell(board: processHolder.game.grid, coords: moveCoords);
      case Condition.canMoveRight:
        final moveCoords = processHolder.game.robotCoords.move(Direction.right);
        return _isWalkableCell(board: processHolder.game.grid, coords: moveCoords);
      case Condition.canMoveDown:
        final moveCoords = processHolder.game.robotCoords.move(Direction.down);
        return _isWalkableCell(board: processHolder.game.grid, coords: moveCoords);
      case Condition.canMoveLeft:
        final moveCoords = processHolder.game.robotCoords.move(Direction.left);
        return _isWalkableCell(board: processHolder.game.grid, coords: moveCoords);
      case Condition.canPutMark:
        return _canPutMark(board: processHolder.game.grid, coords: processHolder.game.robotCoords);
      case Condition.canGrabMark:
        return _canGrabMark(board: processHolder.game.grid, coords: processHolder.game.robotCoords);
    }
  }

  void _failOnSpeed({required _ProcessHolder processHolder}) {
    processHolder
      ..shouldFinish = true
      ..queue.add(
        ProcessGameResult(
          game: processHolder.game.clone(),
          error: ProcessGameError.exceededSpeedLimit,
        ),
      );
  }
}

class _ProcessHolder {
  Game game;
  Queue<ProcessGameResult> queue = Queue();
  int speed = 0;
  final int size;

  bool shouldFinish = false;
  static const int speedLimit = 1000;

  _ProcessHolder({required this.game, required this.size});
}
