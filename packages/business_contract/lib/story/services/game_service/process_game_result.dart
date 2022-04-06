import '../../entities/game/game.dart';
import 'process_game_error.dart';

class ProcessGameResult {
  final Game game;
  final ProcessGameError? error;
  final List<int>? commandIndex;

  ProcessGameResult({
    required this.game,
    this.error,
    this.commandIndex,
  });
}
