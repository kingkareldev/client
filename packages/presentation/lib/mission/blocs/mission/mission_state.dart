part of 'mission_bloc.dart';

@immutable
abstract class MissionState {}

class MissionInitial extends MissionState {}

class MissionLoaded extends MissionState {
  final Mission mission;

  MissionLoaded({required this.mission});
}
