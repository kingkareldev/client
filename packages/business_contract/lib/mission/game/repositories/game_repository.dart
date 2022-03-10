import '../entities/game.dart';

abstract class GameRepository {
  Future<Game> getGame(); // TODO id of story and mission ?
}
