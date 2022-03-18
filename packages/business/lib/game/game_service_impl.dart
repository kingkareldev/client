import 'dart:collection';

import 'package:business_contract/mission/game/entities/commands/group/if_command.dart';
import 'package:business_contract/mission/game/entities/commands/group/root_command.dart';
import 'package:business_contract/mission/game/entities/commands/group/while_command.dart';
import 'package:business_contract/mission/game/entities/commands/group_command.dart';
import 'package:business_contract/mission/game/entities/commands/single/grab_mark_command.dart';
import 'package:business_contract/mission/game/entities/commands/single/move_command.dart';
import 'package:business_contract/mission/game/entities/commands/single/put_mark_command.dart';
import 'package:business_contract/mission/game/entities/commands/single_command.dart';
import 'package:business_contract/mission/game/entities/common/condition.dart';
import 'package:business_contract/mission/game/entities/common/direction.dart';
import 'package:business_contract/mission/game/entities/game/game.dart';
import 'package:business_contract/mission/game/entities/game/game_board.dart';
import 'package:business_contract/mission/game/entities/game/game_cell.dart';
import 'package:business_contract/mission/game/entities/game/robot_coords.dart';
import 'package:business_contract/mission/game/services/game_service.dart';
import 'package:business_contract/mission/game/services/game_service/process_game_error.dart';
import 'package:business_contract/mission/game/services/game_service/process_game_result.dart';

class GameServiceImpl extends GameService {
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
      _processGroupChildren(processHolder: processHolder, command: command);
      return;
    }

    // Have to pass this section, or is returned.
    if (command is IfCommand) {
      if (_processCondition(processHolder: processHolder, condition: command.condition)) {
        _processGroupChildren(processHolder: processHolder, command: command);
      }
      return;
    }

    // Have to pass this section, or is returned.
    if (command is WhileCommand) {
      while (_processCondition(processHolder: processHolder, condition: command.condition)) {
        // While loop has to have this check,
        // so the loop end properly.
        if (processHolder.shouldFinish) {
          return;
        }
        _processGroupChildren(processHolder: processHolder, command: command);
      }
      return;
    }
  }

  void _processGroupChildren({
    required _ProcessHolder processHolder,
    required GroupCommand command,
  }) {
    for (final c in command.commands) {
      if (c is GroupCommand) {
        _processGroupCommand(processHolder: processHolder, command: c);
      }

      if (c is SingleCommand) {
        _processSingleCommand(processHolder: processHolder, command: c);
      }
    }
  }

  void _processSingleCommand({
    required _ProcessHolder processHolder,
    required SingleCommand command,
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

      processHolder.game = processHolder.game.copyWith(
        robotCoords: moveCoords,
      );
      processHolder.queue.add(
        ProcessGameResult(
          game: processHolder.game,
        ),
      );
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
