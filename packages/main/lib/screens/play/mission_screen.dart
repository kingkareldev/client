import 'package:flutter/material.dart';
import 'package:main/extensions/iterable.dart';
import 'package:main/screens/play/missions/game_screen.dart';
import 'package:main/screens/play/missions/story_screen.dart';

import '../../model/mission.dart';
import '../../model/story.dart';
import 'missions/learning_screen.dart';

class MissionScreen extends StatefulWidget {
  final String storyId;
  final String missionId;

  const MissionScreen({required this.storyId, required this.missionId, Key? key}) : super(key: key);

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  Story? story;
  Mission? mission;

  @override
  void initState() {
    // TODO probably only pass the IDs
    story = storiesDataTmp.firstWhereOrNull((element) => element.id == widget.storyId);
    mission = story?.missions.firstWhereOrNull((element) => element.id == widget.missionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (mission is GameMission) {
      return GameScreen(story: story!, mission: mission as GameMission);
    }

    if (mission is LearningMission) {
      return LearningScreen(story: story!, mission: mission as LearningMission);
    }

    if (mission is StoryMission) {
      return StoryScreen(story: story!, mission: mission as StoryMission);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: const Center(
        child: Text("neznámé"),
      ),
    );
  }
}
