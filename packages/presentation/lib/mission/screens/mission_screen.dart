import 'package:flutter/material.dart';

import '../../core/extensions/iterable.dart';
import '../../model/mission.dart';
import '../../model/story.dart';
import 'parts/game.dart';
import 'parts/learning.dart';
import 'parts/story.dart';

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
      return GameScreenPart(story: story!, mission: mission as GameMission);
    }

    if (mission is LearningMission) {
      return LearningScreenPart(story: story!, mission: mission as LearningMission);
    }

    if (mission is StoryMission) {
      return StoryScreenPart(story: story!, mission: mission as StoryMission);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: const Center(
        child: Text("neznámé"),
      ),
    );
  }
}
