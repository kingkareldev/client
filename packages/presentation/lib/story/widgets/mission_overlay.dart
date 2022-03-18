import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../model/mission.dart';
import '../../model/story.dart';
import '../../router/blocs/router/router_bloc.dart';

class MissionOverlay extends StatelessWidget {
  final Story story;
  final Mission mission;

  const MissionOverlay({required this.story, required this.mission, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (mission is GameMission) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // TODO: load from user progress
              children: const [
                Icon(TablerIcons.crown),
                Icon(TablerIcons.crown),
                Icon(TablerIcons.crown),
                Icon(TablerIcons.crown),
                Opacity(child: Icon(TablerIcons.crown), opacity: 0.2),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
          ],
          Text(
            mission.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(mission.description),
          const SizedBox(
            height: 12,
          ),
          if (mission is GameMission)
            ElevatedButton(
              onPressed: () => routerBloc.add(ToMissionRoute(story.id, mission.id)),
              child: const Text('PLAY'),
            ),
          if (mission is StoryMission)
            ElevatedButton(
              onPressed: () => routerBloc.add(ToMissionRoute(story.id, mission.id)),
              child: const Text('READ'),
            ),
          if (mission is LearningMission)
            ElevatedButton(
              onPressed: () => routerBloc.add(ToMissionRoute(story.id, mission.id)),
              child: const Text('LEARN'),
            ),
        ],
      ),
    );
  }
}
