import 'package:business_contract/mission/game/entities/commands/command.dart';
import 'package:business_contract/mission/game/entities/game.dart';
import 'package:business_contract/mission/game/entities/game_board.dart';
import 'package:business_contract/mission/game/entities/game_cell.dart';
import 'package:business_contract/mission/game/entities/game_row.dart';
import 'package:business_contract/mission/game/entities/robot_coords.dart';
import 'package:business_contract/mission/game/repositories/game_repository.dart';

class GameRepositoryImpl extends GameRepository {
  @override
  Future<Game> getGame() {
    // TODO
    return Future.value(Game(
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
    ));
  }
}
