import '../entities/game/game.dart';

abstract class MissionRepository {
  // Future<Game> getMissions(); // TODO id of story and mission ?
  Future<Game> getGame(); // TODO id of story and mission ?

  // saveGame();
}
