part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class MissionInitial extends GameState {}

class GameInProgress extends GameState {
  final String storyUrl;
  final String missionUrl;
  final Game game;
  final bool showDialog;
  final bool isRunning;
  final bool showDescription;
  final ProcessGameError? gameResultError;
  final List<int>? commandIndex;

  GameInProgress({
    required this.storyUrl,
    required this.missionUrl,
    required this.game,
    this.showDialog = false,
    this.isRunning = false,
    this.showDescription = false,
    this.gameResultError,
    this.commandIndex,
  });

  GameInProgress copyWith({
    Game? game,
    bool? showDialog,
    bool? isRunning,
    bool? showDescription,
    ProcessGameError? gameResultError,
    List<int>? commandIndex,
  }) {
    return GameInProgress(
      storyUrl: storyUrl,
      missionUrl: missionUrl,
      game: game ?? this.game.clone(),
      showDialog: showDialog ?? this.showDialog,
      isRunning: isRunning ?? this.isRunning,
      showDescription: showDescription ?? this.showDescription,
      gameResultError: gameResultError,
      commandIndex: commandIndex,
    );
  }
}
