import 'package:flutter/material.dart';
import 'package:presentation_contract/app.dart';

import 'king_karel.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_service.dart';

class AppImpl implements App {
  @override
  Future<Widget> getApp() async {
    final settingsController = SettingsController(SettingsService());
    await settingsController.loadSettings();

    return KingKarel(settingsController: settingsController);
  }
}
