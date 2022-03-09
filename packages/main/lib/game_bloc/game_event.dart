part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class LoadMission extends GameEvent {}

class SaveProgress extends GameEvent {}

class RunGame extends GameEvent {}

class UpdateGame extends GameEvent {
  final RootCommand? commands;
  final RobotCoords? robotCoords;
  final GameBoard? grid;

  UpdateGame({this.commands, this.robotCoords, this.grid});
}

class ShowDialog extends GameEvent {}

class HideDialog extends GameEvent {}
