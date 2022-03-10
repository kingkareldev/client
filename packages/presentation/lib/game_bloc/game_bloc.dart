import 'package:bloc/bloc.dart';
import 'package:business_contract/mission/game/entities/commands/command.dart';
import 'package:business_contract/mission/game/entities/game.dart';
import 'package:business_contract/mission/game/entities/game_board.dart';
import 'package:business_contract/mission/game/entities/robot_coords.dart';
import 'package:business_contract/mission/game/repositories/game_repository.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _repository;

  GameBloc({required GameRepository repository})
      : _repository = repository,
        super(MissionInitial()) {
    on<LoadMission>((event, emit) async {
      print(event);
      // TODO load from repository
      emit(GameInProgress(game: await _repository.getGame()));
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
      emit((state as GameInProgress).copyWith(
        commands: event.commands,
        robotCoords: event.robotCoords,
        grid: event.grid,
      ));
    });
    on<ShowDialog>((event, emit) {
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
