part of 'story_bloc.dart';

@immutable
abstract class StoryEvent {}

class Load extends StoryEvent {
  final String storyUrl;

  Load({required this.storyUrl});
}
