import 'package:bloc/bloc.dart';
import 'package:business_contract/story/entities/story/story.dart';
import 'package:business_contract/story/services/story_service.dart';
import 'package:meta/meta.dart';

part 'stories_event.dart';

part 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  final StoryService _storyService;

  StoriesBloc({required StoryService storyService})
      : _storyService = storyService,
        super(StoriesInitial()) {
    on<Load>((event, emit) async {
      Iterable<Story>? stories = await _storyService.getStories();

      emit(StoriesLoaded(stories: stories?.toList() ?? List.empty()));
    });
  }
}
