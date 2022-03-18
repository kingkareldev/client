part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class MissionInitial extends GameState {}

class GameInProgress extends GameState {
  final Game game;
  final bool showDialog;
  final bool isRunning;
  final bool showDescription;
  final ProcessGameError? gameResultError;

  GameInProgress({
    required this.game,
    this.showDialog = false,
    this.isRunning = false,
    this.showDescription = false,
    this.gameResultError,
  });

  GameInProgress copyWith({
    Game? game,
    bool? showDialog,
    bool? isRunning,
    bool? showDescription,
    ProcessGameError? gameResultError,
  }) {
    return GameInProgress(
      game: game ?? this.game.clone(),
      showDialog: showDialog ?? this.showDialog,
      isRunning: isRunning ?? this.isRunning,
      showDescription: showDescription ?? this.showDescription,
      gameResultError: gameResultError,
    );
  }
}
