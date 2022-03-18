import 'package:business_contract/mission/game/entities/commands/group/if_command.dart';
import 'package:business_contract/mission/game/entities/commands/group/root_command.dart';
import 'package:business_contract/mission/game/entities/commands/single/grab_mark_command.dart';
import 'package:business_contract/mission/game/entities/commands/single/move_command.dart';
import 'package:business_contract/mission/game/entities/commands/single/put_mark_command.dart';
import 'package:business_contract/mission/game/entities/common/condition.dart';
import 'package:business_contract/mission/game/entities/common/direction.dart';
import 'package:business_contract/mission/game/entities/game/game.dart';
import 'package:business_contract/mission/game/entities/game/game_board.dart';
import 'package:business_contract/mission/game/entities/game/game_cell.dart';
import 'package:business_contract/mission/game/entities/game/game_row.dart';
import 'package:business_contract/mission/game/entities/game/robot_coords.dart';
import 'package:business_contract/mission/game/repositories/mission_repository.dart';

class MissionRepositoryImpl extends MissionRepository {
  @override
  Future<Game> getGame() {
    // TODO
    return Future.value(Game(
      description: """
Put a mark on B;2 and walk to D;2.
      """,
      initialCommands: RootCommand([
        MoveCommand(),
        PutMarkCommand(),
        PutMarkCommand(),
        IfCommand(
          condition: Condition.canMoveRight,
          commands: [
            MoveCommand(direction: Direction.right),
          ],
        ),
        GrabMarkCommand(),
      ]),
      commands: null,
      initialRobotCoords: Coords(x: 1, y: 0),
      resultRobotCoords: Coords(x: 3, y: 2),
      robotCoords: null,
      initialGrid: GameBoard([
        GameRow([
          WalkableCell(numberOfMarks: 3),
          WalkableCell(),
          WalkableCell(),
          WaterCell(),
        ]),
        GameRow([
          WalkableCell(),
          WalkableCell(numberOfMarks: 1),
          WalkableCell(),
          ForestCell(),
        ]),
        GameRow([
          ForestCell(),
          WalkableCell(),
          WalkableCell(),
          WalkableCell(),
        ]),
      ]),
      resultGrid: GameBoard([
        GameRow([
          WalkableCell(numberOfMarks: 3),
          WalkableCell(),
          WalkableCell(),
          WaterCell(),
        ]),
        GameRow([
          WalkableCell(),
          WalkableCell(numberOfMarks: 1),
          WalkableCell(),
          ForestCell(),
        ]),
        GameRow([
          ForestCell(),
          WalkableCell(numberOfMarks: 1),
          WalkableCell(),
          WalkableCell(),
        ]),
      ]),
      grid: null,
      completed: false,
      speedLimit: 7,
      speed: null,
      sizeLimit: 20,
      size: null,
    ));
  }
}
