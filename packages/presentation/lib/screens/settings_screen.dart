import 'package:flutter/material.dart';

import '../components/default_screen_container.dart';
import '../l10n/gen/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return DefaultScreenContainer(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  localization.settingsTitle,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
