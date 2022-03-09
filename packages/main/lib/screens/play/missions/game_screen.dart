import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:main/model/command.dart';
import 'package:main/model/game.dart';
import 'package:main/screens/play/commands/commands_view_controller.dart';
import 'package:main/screens/play/components/mission_dialog.dart';

import '../../../game_bloc/game_bloc.dart';
import '../../../model/mission.dart';
import '../../../model/story.dart';
import '../../../router/router_bloc.dart';
import '../commands/commands_view.dart';
import '../commands/game_board_view.dart';

class GameScreen extends StatefulWidget {
  final GameMission mission;
  final Story story;

  const GameScreen({required this.story, required this.mission, Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ButtonStyle _buttonStyle = TextButton.styleFrom(
    backgroundColor: Colors.black87.withAlpha(20),
    shape: const CircleBorder(),
  );

  late final GameBloc _gameBloc;
  late final CommandsViewController _commandsViewController;

  RootCommand _tmpCommands = RootCommand([]);

  @override
  void initState() {
    _commandsViewController = CommandsViewController();

    _gameBloc = GameBloc();
    _gameBloc.stream.forEach((gameState) {
      if (gameState is GameInProgress) {
        print("update state ${gameState.game.commands}");
        setState(() {
          _tmpCommands = gameState.game.commands;
        });
      }
    });
    _gameBloc.add(LoadMission());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);

    return BlocProvider(
      create: (context) => _gameBloc,
      child: BlocBuilder<GameBloc, GameState>(
        bloc: _gameBloc,
        builder: (context, missionState) {
          return Stack(
            children: [
              if (missionState is GameInProgress)
                Row(
                  children: [
                    Container(
                      width: 400,
                      color: Theme.of(context).splashColor,
                      child: Column(
                        children: [
                          Expanded(
                            child: CommandsView(
                              gameCommands: missionState.game.commands.clone(),
                              controller: _commandsViewController,
                              onSave: _onSave,
                              onRun: _onRun,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            color: Colors.amberAccent.shade200,
                            child: Column(
                              children: [
                                Text("$_tmpCommands"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      style: _buttonStyle,
                                      onPressed: () => _commandsViewController.save(),
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
                                      onPressed: () => _commandsViewController.run(),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          TablerIcons.player_play,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GameBoardView(
                        gameBoard: missionState.game.grid,
                        robotCoords: missionState.game.robotCoords,
                      ),
                    ),
                  ],
                ),
              if (missionState is GameInProgress && missionState.showDialog)
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
                    _gameBloc.add(HideDialog());
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  void _onSave(RootCommand commands) {
    print("commands 2: $commands");
    _gameBloc.add(
      UpdateGame(
        commands: commands.clone(),
      ),
    );
    _gameBloc.add(SaveProgress());
  }

  void _onRun(RootCommand commands) {
    _gameBloc.add(
      UpdateGame(
        commands: commands.clone(),
      ),
    );
    _gameBloc.add(RunGame());
  }
}
