import 'package:bloc/bloc.dart';
import 'package:business_contract/story/entities/story/story_with_missions.dart';
import 'package:business_contract/story/services/story_service.dart';
import 'package:meta/meta.dart';
import 'package:presentation/router/blocs/router/router_bloc.dart';

part 'story_event.dart';

part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryService _storyService;
  final RouterBloc _routerBloc;

  StoryBloc({required StoryService storyService, required RouterBloc routerBloc})
      : _storyService = storyService,
        _routerBloc = routerBloc,
        super(StoryInitial()) {
    on<Load>((event, emit) async {
      StoryWithMissions? story = await _storyService.getStory(event.storyUrl);

      if (story == null) {
        _routerBloc.add(ToUnknownRoute());
        return;
      }

      emit(StoryLoaded(story: story));
    });
  }
}
