part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class MissionInitial extends GameState {}

class GameInProgress extends GameState {
  final bool showDialog;
  final Game game;

  // final MissionDialogData? dialog;

  GameInProgress({
    this.showDialog = false,
    required this.game
  });

  GameInProgress copyWith({
    bool? showDialog,
    RootCommand? commands,
    RobotCoords? robotCoords,
    GameBoard? grid,
  }) {
    return GameInProgress(
      showDialog: showDialog ?? this.showDialog,
      game: game.copyWith(
        commands: commands,
        robotCoords: robotCoords,
        grid: grid,
      ),
    );
  }
}
