part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class LoadGame extends GameEvent {
  final String storyUrl;
  final String missionUrl;
  final GameMission gameMission;

  LoadGame({required this.storyUrl, required this.missionUrl, required this.gameMission});
}

class SaveGame extends GameEvent {
  final RootCommand commands;

  SaveGame({required this.commands});
}

class RunGame extends GameEvent {
  final RootCommand commands;

  RunGame({required this.commands});
}

class StopGame extends GameEvent {}

class ResetGrid extends GameEvent {}

class ShowCommands extends GameEvent {}

class ShowDescription extends GameEvent {}

class ShowDialog extends GameEvent {}

class HideDialog extends GameEvent {}
