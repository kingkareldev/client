import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:business_contract/story/entities/commands/group/root_command.dart';
import 'package:business_contract/story/entities/game/game.dart';
import 'package:business_contract/story/entities/mission/game_mission.dart';
import 'package:business_contract/story/services/game_service.dart';
import 'package:business_contract/story/services/game_service/process_game_error.dart';
import 'package:business_contract/story/services/game_service/process_game_result.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameService _service;

  static const int timeDelay = 600;

  GameBloc({required GameService service})
      : _service = service,
        super(MissionInitial()) {
    on<LoadGame>((event, emit) async {
      Game game = await _service.parseGame(event.gameMission);
      emit(GameInProgress(
        storyUrl: event.storyUrl,
        missionUrl: event.missionUrl,
        game: game,
      ));
    });

    on<SaveGame>((event, emit) {
      if (state is! GameInProgress) {
        return;
      }

      Queue<ProcessGameResult> gameQueue =
          _service.processGame((state as GameInProgress).game.copyWith(commands: event.commands));

      ProcessGameResult last = gameQueue.removeLast();

      final gameState = state as GameInProgress;

      _service.saveGame(last.game, gameState.storyUrl, gameState.missionUrl);

      emit(
        (state as GameInProgress).copyWith(
          game: (state as GameInProgress).game.copyWith(
                commands: event.commands,
              ),
        ),
      );
    });

    on<StopGame>((event, emit) {
      if (state is! GameInProgress) {
        return;
      }

      emit((state as GameInProgress).copyWith(
        isRunning: false,
        showDialog: false,
      ));
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
      ProcessGameResult last = gameQueue.last;

      // On exceeding speed limit,
      // finish without the game animation and show the error dialog immediately.
      // if (last.error == ProcessGameError.exceededSpeedLimit) {
      //   runGameState = runGameState.copyWith(
      //     isRunning: false,
      //     showDialog: true,
      //     gameResultError: last.error,
      //   );
      //
      //   if (!(state as GameInProgress).isRunning) {
      //     return;
      //   }
      //   emit(runGameState);
      //   return;
      // }

      // Step by step process the game queue.
      for (var step in gameQueue) {
        await Future.delayed(const Duration(milliseconds: timeDelay));

        if (step.error != null) {
          runGameState = runGameState.copyWith(
            game: step.game,
            gameResultError: step.error,
            isRunning: false,
            showDialog: true,
          );
          if (!(state as GameInProgress).isRunning) {
            return;
          }
          emit(runGameState);
          return;
        }

        runGameState = runGameState.copyWith(
          game: step.game,
          gameResultError: last.error,
          commandIndex: step.commandIndex,
        );
        if (!(state as GameInProgress).isRunning) {
          return;
        }
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
        if (!(state as GameInProgress).isRunning) {
          return;
        }
        emit(runGameState);
        return;
      }

      // Or a successful one.
      runGameState = runGameState.copyWith(
        game: last.game,
        isRunning: false,
        showDialog: true,
      );
      if (!(state as GameInProgress).isRunning) {
        return;
      }
      emit(runGameState);

      final gameState = state as GameInProgress;
      _service.saveGame(runGameState.game, gameState.storyUrl, gameState.missionUrl);

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
