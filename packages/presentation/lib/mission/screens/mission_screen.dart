import 'package:business_contract/story/entities/mission/game_mission.dart';
import 'package:business_contract/story/entities/mission/learning_mission.dart';
import 'package:business_contract/story/services/story_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/l10n/gen/app_localizations.dart';
import '../../router/blocs/router/router_bloc.dart';
import '../blocs/mission/mission_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) =>
      MissionBloc(storyService: GetIt.I<StoryService>(), routerBloc: routerBloc)
        ..add(Load(storyUrl: widget.storyId, missionUrl: widget.missionId)),
      child: BlocBuilder<MissionBloc, MissionState>(
        builder: (context, state) {
          if (state is MissionLoaded) {
            if (state.mission is GameMission) {
              return GameScreenPart(storyUrl: widget.storyId, mission: state.mission as GameMission);
            }

            if (state.mission is LearningMission && !(state.mission as LearningMission).isStory) {
              return LearningScreenPart(storyUrl: widget.storyId, mission: state.mission as LearningMission);
            }

            if (state.mission is LearningMission && (state.mission as LearningMission).isStory) {
              return StoryScreenPart(storyUrl: widget.storyId, mission: state.mission as LearningMission);
            }
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Center(
              child: Text(localization.loadingText),
            ),
          );
        },
      ),
    );
  }
}
