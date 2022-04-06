import '../mission/mission.dart';

class StoryWithMissions {
  final String url;
  final String name;
  final String description;
  final List<Mission> missions;

  StoryWithMissions({required this.url, required this.name, required this.description, required this.missions});

  factory StoryWithMissions.fromJson(Map<String, dynamic> json) {
    List<Mission> missions = List.from([]);
    List<dynamic> missionsData = json['missions'];

    for (var element in missionsData) {
      missions.add(Mission.fromJson(element));
    }

    return StoryWithMissions(
      url: json['url'],
      name: json['name'],
      description: json['description'],
      missions: missions,
    );
  }
}
