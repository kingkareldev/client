import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:business_contract/mission/game/entities/commands/group/root_command.dart';
import 'package:business_contract/mission/game/entities/game/game.dart';
import 'package:business_contract/mission/game/repositories/mission_repository.dart';
import 'package:business_contract/mission/game/services/game_service.dart';
import 'package:business_contract/mission/game/services/game_service/process_game_error.dart';
import 'package:business_contract/mission/game/services/game_service/process_game_result.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final MissionRepository _repository;
  final GameService _service;

  static const int timeDelay = 600;

  GameBloc({required MissionRepository repository, required GameService service})
      : _repository = repository,
        _service = service,
        super(MissionInitial()) {
    on<LoadGame>((event, emit) async {
      // _repository.loadGame(); TODO
      emit(GameInProgress(game: await _repository.getGame()));
    });

    on<SaveGame>((event, emit) {
      if (state is! GameInProgress) {
        return;
      }

      // _repository.saveGame(); TODO
      emit(
        (state as GameInProgress).copyWith(
          game: (state as GameInProgress).game.copyWith(
                commands: event.commands,
              ),
        ),
      );
    });

    on<RunGame>((event, emit) async {
      if (state is! GameInProgress) {
        return;
      }

      // First,
      // init game to defaults
      // and change state to isRunning.
      GameInProgress runGameState = (state as GameInProgress).copyWith(
        game: (state as GameInProgress).game.copyWith(
              commands: event.commands.clone(),
              grid: (state as GameInProgress).game.initialGrid.clone(),
              robotCoords: (state as GameInProgress).game.initialRobotCoords.clone(),
            ),
        isRunning: true,
        gameResultError: null,
      );
      emit(runGameState);

      // Then, save the game.
      // _repository.saveGame(); TODO

      // Process the game commands.
      Queue<ProcessGameResult> gameQueue = _service.processGame(runGameState.game);

      if (gameQueue.isEmpty) {
        return;
      }

      // Extract last result -- that should contain the final state or error.
      ProcessGameResult last = gameQueue.removeLast();

      // On exceeding speed limit,
      // finish without the game animation and show the error dialog immediately.
      if (last.error == ProcessGameError.exceededSpeedLimit) {
        runGameState = runGameState.copyWith(
          isRunning: false,
          showDialog: true,
          gameResultError: last.error,
        );
        emit(runGameState);
        return;
      }

      // Step by step process the game queue.
      for (var step in gameQueue) {
        await Future.delayed(const Duration(milliseconds: timeDelay));

        if (step.error != null) {
          runGameState = runGameState.copyWith(
            game: step.game,
            gameResultError: last.error,
            isRunning: false,
            showDialog: true,
          );
          emit(runGameState);
          return;
        }

        runGameState = runGameState.copyWith(
          game: step.game,
          gameResultError: last.error,
        );
        emit(runGameState);
      }

      await Future.delayed(const Duration(milliseconds: timeDelay));

      // Then process the last result.
      // If it has an error:
      if (last.error != null) {
        runGameState = runGameState.copyWith(
          game: last.game,
          isRunning: false,
          showDialog: true,
          gameResultError: last.error,
        );
        emit(runGameState);
        return;
      }

      // Or a successful one.
      runGameState = runGameState.copyWith(
        game: last.game,
        isRunning: false,
        showDialog: true,
      );
      emit(runGameState);

      return;
    });

    on<ResetGrid>((event, emit) {
      if (state is! GameInProgress) {
        return;
      }

      emit((state as GameInProgress).copyWith(
        game: (state as GameInProgress).game.copyWith(
              grid: (state as GameInProgress).game.initialGrid.clone(),
              robotCoords: (state as GameInProgress).game.initialRobotCoords.clone(),
            ),
        gameResultError: null,
      ));
    });

    on<ShowCommands>((event, emit) {
      if (state is! GameInProgress) {
        return;
      }

      emit((state as GameInProgress).copyWith(
        showDescription: false,
      ));
    });
    on<ShowDescription>((event, emit) {
      if (state is! GameInProgress) {
        return;
      }

      emit((state as GameInProgress).copyWith(
        showDescription: true,
      ));
    });

    on<ShowDialog>((event, emit) {
      if (state is! GameInProgress) {
        return;
      }

      emit((state as GameInProgress).copyWith(
        showDialog: true,
      ));
    });
    on<HideDialog>((event, emit) {
      if (state is! GameInProgress) {
        return;
      }

      emit((state as GameInProgress).copyWith(
        showDialog: false,
      ));
    });
  }
}
