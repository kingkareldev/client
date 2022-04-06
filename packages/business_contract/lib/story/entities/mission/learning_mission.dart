import 'dart:convert';

import 'package:business_contract/story/entities/mission/mission.dart';

class LearningMission extends Mission {
  final List<String> data;
  final bool isStory;

  LearningMission({
    required this.data,
    required this.isStory,
    required String url,
    required String name,
    required String description,
  }) : super(url: url, name: name, description: description);

  factory LearningMission.fromJson(Map<String, dynamic> json) {
    return LearningMission(
      data: (jsonDecode(json['data']) as List<dynamic>).cast<String>(),
      isStory: json['isStory'],
      url: json['url'],
      name: json['name'],
      description: json['description'],
    );
  }
}
