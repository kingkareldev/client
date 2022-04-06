import 'package:business_contract/story/entities/mission/mission.dart';

class GameMission extends Mission {
  final String taskDescription;
  final String commandsInitial;
  final String commands;
  final String boardInitial;
  final String boardResult;
  final int speedLimit;
  final int speed;
  final int sizeLimit;
  final int size;
  final String robotInitial;
  final String robotResult;
  final bool completed;

  GameMission({
    required this.taskDescription,
    required this.commandsInitial,
    required this.commands,
    required this.boardInitial,
    required this.boardResult,
    required this.speedLimit,
    required this.speed,
    required this.sizeLimit,
    required this.size,
    required this.robotInitial,
    required this.robotResult,
    required this.completed,
    required String url,
    required String name,
    required String description,
  }) : super(url: url, name: name, description: description);

  factory GameMission.fromJson(Map<String, dynamic> json) {
    return GameMission(
      taskDescription: json['taskDescription'],
      commandsInitial: json['commandsInitial'],
      commands: json['commands'],
      boardInitial: json['boardInitial'],
      boardResult: json['boardResult'],
      speedLimit: json['speedLimit'],
      speed: json['speed'],
      sizeLimit: json['sizeLimit'],
      size: json['size'],
      robotInitial: json['robotInitial'],
      robotResult: json['robotResult'],
      completed: json['completed'],
      url: json['url'],
      name: json['name'],
      description: json['description'],
    );
  }
}
