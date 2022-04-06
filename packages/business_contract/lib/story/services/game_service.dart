import 'dart:collection';

import 'package:business_contract/story/entities/mission/game_mission.dart';
import 'package:business_contract/story/repositories/mission_repository.dart';

import '../entities/game/game.dart';
import 'game_service/process_game_result.dart';

abstract class GameService {
  final MissionRepository missionRepository;

  GameService({required this.missionRepository});

  Queue<ProcessGameResult> processGame(Game game);

  Future<Game> parseGame(GameMission gameMission);

  Future<bool> saveGame(Game game, String storyUlr, String gameUrl);
}
