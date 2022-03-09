import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mission_event.dart';

part 'mission_state.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  MissionBloc() : super(MissionInitial()) {
    on<LoadMission>((event, emit) {
      // TODO
      emit(MissionPlaying());
    });
    on<SaveProgress>((event, emit) {
      // TODO: implement event handler
    });
    on<RunMission>((event, emit) {
      // TODO: implement event handler
    });
    on<ShowDialog>((event, emit) {
      if (state is MissionPlaying) {
        emit((state as MissionPlaying).copyWith(showDialog: true));
      }
    });
    on<HideDialog>((event, emit) {
      emit((state as MissionPlaying).copyWith(showDialog: false));
    });
  }
}
