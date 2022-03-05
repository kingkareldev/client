import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:main/components/default_screen_container.dart';

import '../../../model/mission.dart';
import '../../../model/story.dart';

class LearningView extends StatelessWidget {
  final LearningMission mission;
  final Story story;

  const LearningView({required this.story, required this.mission, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer(
      children: [
        const Text("learning view"),
        MarkdownBody(data: mission.description),
      ],
    );
  }
}
