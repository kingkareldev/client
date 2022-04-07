import 'package:business_contract/story/entities/commands/group/root_command.dart';
import 'package:business_contract/story/entities/mission/game_mission.dart';
import 'package:business_contract/story/services/game_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/core/extensions/string.dart';

import '../../../core/l10n/gen/app_localizations.dart';
import '../../../router/blocs/router/router_bloc.dart';
import '../../blocs/game/game_bloc.dart';
import '../../widgets/game/commands/commands_view.dart';
import '../../widgets/game/commands/commands_view_controller.dart';
import '../../widgets/game/game_board/game_board_view.dart';
import '../../widgets/game/mission_dialog.dart';

class GameScreenPart extends StatefulWidget {
  final GameMission mission;
  final String storyUrl;

  const GameScreenPart({required this.storyUrl, required this.mission, Key? key}) : super(key: key);

  @override
  State<GameScreenPart> createState() => _GameScreenPartState();
}

class _GameScreenPartState extends State<GameScreenPart> {
  final ScrollController _descriptionScrollController = ScrollController();
  late final GameBloc _gameBloc;
  late final CommandsViewController _commandsViewController;

  final double leftSideWidth = 400;

  RootCommand? _tmpCommands;

  @override
  void initState() {
    _commandsViewController = CommandsViewController();

    _gameBloc = GameBloc(
      service: GetIt.I<GameService>(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    final event = LoadGame(
      storyUrl: widget.storyUrl,
      missionUrl: widget.mission.url,
      gameMission: widget.mission,
    );

    return BlocProvider(
      create: (context) => _gameBloc..add(event),
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state is GameInProgress && _tmpCommands == null) {
            _tmpCommands = state.game.commands.clone();
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state is GameInProgress)
                Row(
                  children: [
                    Container(
                      width: leftSideWidth,
                      color: Theme.of(context).splashColor,
                      child: Column(
                        children: [
                          Expanded(
                            child: IgnorePointer(
                              ignoring: state.isRunning,
                              child: Stack(
                                fit: StackFit.passthrough,
                                children: [
                                  CommandsView(
                                    gameCommands: _tmpCommands!,
                                    controller: _commandsViewController,
                                    onSave: _onSave,
                                    onRun: _onRun,
                                  ),
                                  if (state.showDescription)
                                    Container(
                                      alignment: Alignment.topLeft,
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(10),
                                      child: ListView(
                                        controller: _descriptionScrollController,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10, bottom: 22),
                                            child: Text(
                                              localization.gameDescriptionTitle.toTitleCase(),
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                                            ),
                                          ),
                                          MarkdownBody(data: state.game.taskDescription),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            color: Colors.amberAccent.shade200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (!state.isRunning) ...[
                                  IconButton(
                                    onPressed: () => _onDescription(),
                                    icon: const Icon(
                                      TablerIcons.book,
                                      color: Colors.black87,
                                    ),
                                    tooltip: state.showDescription
                                        ? localization.gameHideDescriptionButton
                                        : localization.gameShowDescriptionButton,
                                  ),
                                  Expanded(child: Container()),
                                  IconButton(
                                    onPressed: _onReset,
                                    icon: const Icon(
                                      TablerIcons.repeat,
                                      color: Colors.black87,
                                    ),
                                    tooltip: localization.gameResetButton,
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () => _commandsViewController.save(),
                                    icon: const Icon(
                                      TablerIcons.device_floppy,
                                      color: Colors.black87,
                                    ),
                                    tooltip: localization.gameSaveButton,
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () => _commandsViewController.run(),
                                    icon: const Icon(
                                      TablerIcons.player_play,
                                      color: Colors.black87,
                                    ),
                                    tooltip: localization.gameRunButton,
                                  ),
                                ] else ...[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    color: Colors.black87,
                                    child: Text(
                                      localization.gameRunningDescription,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      onPressed: _onStop,
                                      icon: const Icon(
                                        TablerIcons.player_stop,
                                        color: Colors.red,
                                      ),
                                      tooltip: localization.gameStopButton,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GameBoardView(
                        gameBoard: state.game.grid,
                        robotCoords: state.game.robotCoords,
                      ),
                    ),
                  ],
                ),
              // if (state is GameInProgress && state.isRunning)
              //   Container(
              //     color: Colors.black87.withOpacity(0.1),
              //     width: leftSideWidth,
              //     child: Column(
              //       mainAxisSize: MainAxisSize.max,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Container(
              //           padding: const EdgeInsets.all(10),
              //           color: Colors.black87,
              //           child: Text(
              //             localization.gameRunningDescription,
              //             style: const TextStyle(
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              if (state is GameInProgress && state.showDialog)
                MissionDialog(
                  name: widget.mission.name,
                  size: state.game.size,
                  sizeLimit: state.game.sizeLimit,
                  speed: state.game.speed,
                  speedLimit: state.game.speedLimit,
                  isCompleted: state.game.isCompleted(),
                  gameResultError: state.gameResultError,
                  onToStory: () {
                    routerBloc.add(ToStoryRoute(widget.storyUrl));
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

  void _onDescription() {
    if (_gameBloc.state is! GameInProgress) {
      return;
    }

    if ((_gameBloc.state as GameInProgress).showDescription) {
      _gameBloc.add(
        ShowCommands(),
      );
      return;
    }

    _gameBloc.add(
      ShowDescription(),
    );
  }

  void _onSave(RootCommand commands) {
    _gameBloc.add(
      SaveGame(
        commands: commands,
      ),
    );
  }

  void _onRun(RootCommand commands) {
    _gameBloc.add(
      RunGame(
        commands: commands,
      ),
    );
  }

  void _onReset() {
    _gameBloc.add(
      ResetGrid(),
    );
  }

  void _onStop() {
    _gameBloc.add(
      StopGame(),
    );
  }
}
