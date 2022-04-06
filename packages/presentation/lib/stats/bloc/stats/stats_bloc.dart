import 'package:bloc/bloc.dart';
import 'package:business_contract/story/entities/story/story_with_missions.dart';
import 'package:business_contract/story/services/story_service.dart';
import 'package:meta/meta.dart';

part 'stats_event.dart';

part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final StoryService _storyService;

  StatsBloc({required StoryService storyService})
      : _storyService = storyService,
        super(StatsInitial()) {
    on<Load>((event, emit) async {
      Iterable<StoryWithMissions>? stories = await _storyService.getStoriesStats();
      if (stories == null) {
        return;
      }

      emit(StatsLoaded(stories: stories.toList()));
    });
  }
}
