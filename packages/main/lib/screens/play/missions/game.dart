import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:main/screens/play/components/mission_dialog.dart';

import '../../../mission_blocks/mission_bloc.dart';
import '../../../model/mission.dart';
import '../../../model/story.dart';
import '../../../router/router_bloc.dart';
import '../commands/commands_view.dart';

class GameView extends StatefulWidget {
  final GameMission mission;
  final Story story;

  GameView({required this.story, required this.mission, Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final ButtonStyle _buttonStyle = TextButton.styleFrom(
    backgroundColor: Colors.black87.withAlpha(20),
    shape: const CircleBorder(),
  );

  late final MissionBloc _missionBloc;

  @override
  void initState() {
    _missionBloc = MissionBloc();
    _missionBloc.add(LoadMission());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);

    return BlocProvider(
      create: (context) => _missionBloc,
      child: BlocBuilder<MissionBloc, MissionState>(
        bloc: _missionBloc,
        builder: (context, missionState) {
          return Stack(
            children: [
              if (missionState is MissionPlaying)
                Container(
                  width: 400,
                  color: Theme.of(context).splashColor,
                  child: Column(
                    children: [
                      const Expanded(
                        child: CommandsView(),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        color: Colors.amberAccent.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: _buttonStyle,
                              onPressed: () => _missionBloc.add(SaveProgress()),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  TablerIcons.device_floppy,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              style: _buttonStyle,
                              onPressed: () => _missionBloc.add(RunMission()),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  TablerIcons.player_play,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              style: _buttonStyle,
                              onPressed: () => _missionBloc.add(ShowDialog()),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  TablerIcons.diamond,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (missionState is MissionPlaying && missionState.showDialog)
                MissionDialog(
                  name: widget.mission.name,
                  size: 3,
                  sizeLimit: 20,
                  speed: 21,
                  speedLimit: 12,
                  isCompleted: true,
                  onToStory: () {
                    routerBloc.add(ToStoryRoute(widget.story.id));
                  },
                  onTryAgain: () {
                    _missionBloc.add(HideDialog());
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
