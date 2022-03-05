abstract class Mission {
  final String id;
  final String name;
  final String description;

  Mission({required this.id, required this.name, required this.description});
}

class GameMission extends Mission {
  // TODO: game json
  // TODO: default commands json

  GameMission({
    required String id,
    required String name,
    required String description,
  }) : super(id: id, name: name, description: description);
}

class StoryMission extends Mission {
  final List<String> data; // TODO: markdown

  StoryMission({
    required this.data,
    required String id,
    required String name,
    required String description,
  }) : super(id: id, name: name, description: description);
}

class LearningMission extends Mission {
  final String data; // TODO: markdown

  LearningMission({
    required this.data,
    required String id,
    required String name,
    required String description,
  }) : super(id: id, name: name, description: description);
}
