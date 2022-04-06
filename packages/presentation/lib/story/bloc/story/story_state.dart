part of 'story_bloc.dart';

@immutable
abstract class StoryState {}

class StoryInitial extends StoryState {}

class StoryLoaded extends StoryState {
  final StoryWithMissions story;

  StoryLoaded({required this.story});
}
