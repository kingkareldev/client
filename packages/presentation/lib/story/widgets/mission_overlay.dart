import 'package:business_contract/story/entities/mission/game_mission.dart';
import 'package:business_contract/story/entities/mission/learning_mission.dart';
import 'package:business_contract/story/entities/mission/mission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../core/l10n/gen/app_localizations.dart';
import '../../router/blocs/router/router_bloc.dart';

class MissionOverlay extends StatelessWidget {
  final String storyUrl;
  final Mission mission;

  const MissionOverlay({required this.storyUrl, required this.mission, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (mission is GameMission) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // size
                Column(
                  children: [
                    Icon(
                      TablerIcons.crown,
                      color: ((mission as GameMission).completed &&
                              (mission as GameMission).size != 0 &&
                              (mission as GameMission).size < (mission as GameMission).sizeLimit)
                          ? Colors.blue
                          : Colors.grey.shade300,
                    ),
                    Text(localization.statsSizeColumn, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                // completed
                Column(
                  children: [
                    Icon(
                      TablerIcons.crown,
                      color: (mission as GameMission).completed ? Colors.blue : Colors.grey.shade300,
                      size: 60,
                    ),
                    Text(localization.statsCompletedColumn, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                // speed
                Column(
                  children: [
                    Icon(
                      TablerIcons.crown,
                      color: ((mission as GameMission).completed &&
                              (mission as GameMission).speed != 0 &&
                              (mission as GameMission).speed < (mission as GameMission).speedLimit)
                          ? Colors.blue
                          : Colors.grey.shade300,
                    ),
                    Text(localization.statsSpeedColumn, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                )
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
              onPressed: () => routerBloc.add(ToMissionRoute(storyUrl, mission.url)),
              child: const Text('PLAY'),
            ),
          if (mission is LearningMission && (mission as LearningMission).isStory)
            ElevatedButton(
              onPressed: () => routerBloc.add(ToMissionRoute(storyUrl, mission.url)),
              child: const Text('READ'),
            ),
          if (mission is LearningMission && !(mission as LearningMission).isStory)
            ElevatedButton(
              onPressed: () => routerBloc.add(ToMissionRoute(storyUrl, mission.url)),
              child: const Text('LEARN'),
            ),
        ],
      ),
    );
  }
}
