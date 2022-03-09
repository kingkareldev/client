import 'package:bloc/bloc.dart';
import 'package:main/model/game.dart';
import 'package:meta/meta.dart';

import '../model/command.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {

  GameBloc() : super(MissionInitial()) {
    on<LoadMission>((event, emit) {
      print(event);
      // TODO load from repository
      emit(GameInProgress(game: gameTmp // TODO
          ));
    });
    on<SaveProgress>((event, emit) {
      print(event);
      // TODO: implement event handler
    });
    on<RunGame>((event, emit) {
      print(event);
      // TODO: implement event handler
    });
    on<UpdateGame>((event, emit) {
      print(event);
      emit((state as GameInProgress).copyWith(
        commands: event.commands,
        robotCoords: event.robotCoords,
        grid: event.grid,
      ));
    });
    on<ShowDialog>((event, emit) {
      print(event);
      if (state is GameInProgress) {
        emit((state as GameInProgress).copyWith(showDialog: true));
      }
    });
    on<HideDialog>((event, emit) {
      print(event);
      if (state is GameInProgress) {
        emit((state as GameInProgress).copyWith(showDialog: false));
      }
    });
  }
}
