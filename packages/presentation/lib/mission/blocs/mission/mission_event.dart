part of 'mission_bloc.dart';

@immutable
abstract class MissionEvent {}

class Load extends MissionEvent {
  final String storyUrl;
  final String missionUrl;

  Load({required this.storyUrl, required this.missionUrl});
}
