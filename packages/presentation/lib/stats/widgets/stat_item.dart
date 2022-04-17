import 'package:business_contract/story/entities/mission/game_mission.dart';
import 'package:business_contract/user/entities/user.dart';
import 'package:flutter/material.dart';

import '../../core/l10n/gen/app_localizations.dart';

class StatItem {
  final User user;
  final GameMission mission;
  final bool displayName;
  const StatItem({required this.user, required this.mission, this.displayName = false});

  TableRow build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return TableRow(
      children: [
        if (displayName)
          Center(child: Text(user.username)),
        Center(child: Text(mission.name)),
        Center(child: Text(mission.completed ? localization.statsCompletedTrue : localization.statsCompletedFalse)),
        Center(child: Text("${mission.size} / ${mission.sizeLimit}")),
        Center(child: Text("${mission.speed} / ${mission.speedLimit}")),
      ],
    );
  }
}
