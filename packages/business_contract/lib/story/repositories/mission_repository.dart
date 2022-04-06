import '../entities/mission/mission.dart';

abstract class MissionRepository {
  Future<Mission?> getMission(String token, String storyUrl, String missionUrl);

  Future<bool> saveGame(
    String token,
    String storyUrl,
    String gameUrl,
    String commandsJson,
    int size,
    int speed,
    bool completed,
  );
}
