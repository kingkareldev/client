import 'package:business_contract/story/entities/mission/game_mission.dart';
import 'package:business_contract/story/entities/mission/learning_mission.dart';

class Mission {
  final String url;
  final String name;
  final String description;

  Mission({required this.url, required this.name, required this.description});

  factory Mission.fromJson(Map<String, dynamic> json) {
    if (json['game'] != null) {
      return GameMission.fromJson(json['game']);
    }

    return LearningMission.fromJson(json['learning']);
  }
}
