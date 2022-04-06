import 'package:bloc/bloc.dart';
import 'package:business_contract/story/entities/mission/mission.dart';
import 'package:business_contract/story/services/story_service.dart';
import 'package:meta/meta.dart';
import 'package:presentation/router/blocs/router/router_bloc.dart';

part 'mission_event.dart';

part 'mission_state.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  final StoryService _storyService;
  final RouterBloc _routerBloc;

  MissionBloc({required StoryService storyService, required RouterBloc routerBloc})
      : _storyService = storyService,
        _routerBloc = routerBloc,
        super(MissionInitial()) {
    on<Load>((event, emit) async {
      Mission? mission = await _storyService.getMission(event.storyUrl, event.missionUrl);

      if (mission == null) {
        _routerBloc.add(ToUnknownRoute());
        return;
      }

      emit(MissionLoaded(mission: mission));
    });
  }
}
