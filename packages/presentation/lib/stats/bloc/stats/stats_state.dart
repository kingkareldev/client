part of 'stats_bloc.dart';

@immutable
abstract class StatsState {}

class StatsInitial extends StatsState {}

class StatsLoaded extends StatsState {
  final List<StoryWithMissions> stories;

  StatsLoaded({required this.stories});
}
