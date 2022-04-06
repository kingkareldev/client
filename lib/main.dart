import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:business/game/game_service_impl.dart';
import 'package:business/game/story_service_impl.dart';
import 'package:business/user/auth_service_impl.dart';
import 'package:business_contract/story/repositories/mission_repository.dart';
import 'package:business_contract/story/repositories/story_repository.dart';
import 'package:business_contract/story/services/game_service.dart';
import 'package:business_contract/story/services/story_service.dart';
import 'package:business_contract/user/repositories/auth_repository.dart';
import 'package:business_contract/user/services/auth_service.dart';
import 'package:data/repositories/auth_repository_impl.dart';
import 'package:data/repositories/mission_repository_impl.dart';
import 'package:data/repositories/story_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/app.dart';
import 'package:presentation_contract/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Run the app.
void main() async {
  await setup();

  runApp(await GetIt.I<App>().getApp());

  doWhenWindowReady(() {
    const initialSize = Size(900, 600);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'King Karel';
    appWindow.show();
  });
}

/// Setup all the dependencies.
Future<void> setup() async {
  await dotenv.load(fileName: 'king_karel.env');
  SharedPreferences preferences = await SharedPreferences.getInstance();

  // Presentation
  GetIt.I.registerSingleton<App>(AppImpl());

  // Repositories
  GetIt.I.registerSingleton<MissionRepository>(MissionRepositoryImpl());
  GetIt.I.registerSingleton<StoryRepository>(StoryRepositoryImpl());
  GetIt.I.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Services
  GetIt.I.registerSingleton<AuthService>(
    AuthServiceImpl(
      authRepository: GetIt.I<AuthRepository>(),
      storage: preferences,
    ),
  );
  GetIt.I.registerSingleton<GameService>(GameServiceImpl(
    missionRepository: GetIt.I<MissionRepository>(),
    storage: preferences,
  ));
  GetIt.I.registerSingleton<StoryService>(
    StoryServiceImpl(
      missionRepository: GetIt.I<MissionRepository>(),
      storyRepository: GetIt.I<StoryRepository>(),
      storage: preferences,
    ),
  );
}
