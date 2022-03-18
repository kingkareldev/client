import 'dart:collection';

import '../entities/game/game.dart';
import 'game_service/process_game_result.dart';

abstract class GameService {
  Queue<ProcessGameResult> processGame(Game game);
}
