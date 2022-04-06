part of 'stories_bloc.dart';

@immutable
abstract class StoriesState {}

class StoriesInitial extends StoriesState {}

class StoriesLoaded extends StoriesState {
  final List<Story> stories;

  StoriesLoaded({required this.stories});
}
