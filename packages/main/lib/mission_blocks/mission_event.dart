part of 'mission_bloc.dart';

@immutable
abstract class MissionEvent {}

class LoadMission extends MissionEvent {}

class SaveProgress extends MissionEvent {}

class RunMission extends MissionEvent {}

class ShowDialog extends MissionEvent {}

class HideDialog extends MissionEvent {}
