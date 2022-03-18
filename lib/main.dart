import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:business/game/game_service_impl.dart';
import 'package:business_contract/mission/game/repositories/mission_repository.dart';
import 'package:business_contract/mission/game/services/game_service.dart';
import 'package:data/repositories/game_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/app.dart';
import 'package:presentation_contract/app.dart';

/// Run the app.
void main() async {
  setup();

  runApp(await GetIt.I<App>().getApp());

  doWhenWindowReady(() {
    const initialSize = Size(900, 600);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "King Karel";
    appWindow.show();
  });
}

/// Setup all the dependencies.
void setup() {
  // Presentation
  GetIt.I.registerSingleton<App>(AppImpl());

  // Business
  GetIt.I.registerLazySingleton<GameService>(() => GameServiceImpl());

  // Data
  GetIt.I.registerLazySingleton<MissionRepository>(() => MissionRepositoryImpl());
}
