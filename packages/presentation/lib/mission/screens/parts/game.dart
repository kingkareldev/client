import 'package:business_contract/mission/game/entities/commands/group/root_command.dart';
import 'package:business_contract/mission/game/repositories/mission_repository.dart';
import 'package:business_contract/mission/game/services/game_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/core/extensions/string.dart';

import '../../../../model/mission.dart';
import '../../../../model/story.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../router/blocs/router/router_bloc.dart';
import '../../blocs/game/game_bloc.dart';
import '../../widgets/game/commands/commands_view.dart';
import '../../widgets/game/commands/commands_view_controller.dart';
import '../../widgets/game/game_board/game_board_view.dart';
import '../../widgets/game/mission_dialog.dart';

class GameScreenPart extends StatefulWidget {
  final GameMission mission;
  final Story story;

  const GameScreenPart({required this.story, required this.mission, Key? key}) : super(key: key);

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
      repository: GetIt.I<MissionRepository>(),
      service: GetIt.I<GameService>(),
    );
    _gameBloc.stream.forEach((gameState) {
      if (gameState is GameInProgress) {
        setState(() {});
      }
    });
    _gameBloc.add(LoadGame());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => _gameBloc,
      child: BlocListener<GameBloc, GameState>(
        listener: (context, state) {
          if (state is GameInProgress && _tmpCommands == null) {
            _tmpCommands = state.game.commands.clone();
          }
        },
        child: BlocBuilder<GameBloc, GameState>(
          bloc: _gameBloc,
          builder: (context, missionState) {
            return Stack(
              children: [
                if (missionState is GameInProgress)
                  Row(
                    children: [
                      Container(
                        width: leftSideWidth,
                        color: Theme.of(context).splashColor,
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                fit: StackFit.passthrough,
                                children: [
                                  CommandsView(
                                    gameCommands: _tmpCommands!,
                                    controller: _commandsViewController,
                                    onSave: _onSave,
                                    onRun: _onRun,
                                    onReset: _onReset,
                                  ),
                                  if (missionState.showDescription)
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
                                          MarkdownBody(data: missionState.game.description),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              color: Colors.amberAccent.shade200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => _onDescription(),
                                    icon: const Icon(
                                      TablerIcons.book,
                                      color: Colors.black87,
                                    ),
                                    tooltip: missionState.showDescription
                                        ? localization.gameHideDescriptionButton
                                        : localization.gameShowDescriptionButton,
                                  ),
                                  Expanded(child: Container()),
                                  IconButton(
                                    onPressed: () => _commandsViewController.reset(),
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
                if (missionState is GameInProgress && missionState.isRunning)
                  Container(
                    color: Colors.black87.withOpacity(0.5),
                    width: leftSideWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                      ],
                    ),
                  ),
                if (missionState is GameInProgress && missionState.showDialog)
                  MissionDialog(
                    name: widget.mission.name,
                    size: missionState.game.size,
                    sizeLimit: missionState.game.sizeLimit,
                    speed: missionState.game.speed,
                    speedLimit: missionState.game.speedLimit,
                    isCompleted: missionState.game.isCompleted(),
                    gameResultError: missionState.gameResultError,
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
        commands: commands.clone(),
      ),
    );
  }

  void _onRun(RootCommand commands) {
    _gameBloc.add(
      RunGame(
        commands: commands.clone(),
      ),
    );
  }

  void _onReset() {
    _gameBloc.add(
      ResetGrid(),
    );
  }
}
