import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:business_contract/mission/game/repositories/game_repository.dart';
import 'package:data/repositories/game_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/app.dart';
import 'package:presentation_contract/app.dart';


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

void setup() {
  GetIt.I.registerSingleton<App>(AppImpl());

  GetIt.I.registerSingleton<GameRepository>(GameRepositoryImpl());
}