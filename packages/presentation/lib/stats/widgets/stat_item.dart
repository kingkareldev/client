import 'package:flutter/material.dart';

import '../../model/stats.dart';

class StatItem {
  final Stats stats;
  final bool displayName;
  const StatItem({required this.stats, this.displayName = false});

  TableRow build(BuildContext context) {
    return TableRow(
      children: [
        if (displayName)
          Center(child: Text(stats.username ?? '--')),
        Center(child: Text(stats.completed ? "YAY" : "NO")),
        Center(child: Text("${stats.sizeAchieved} / ${stats.sizeLimit}")),
        Center(child: Text("${stats.speedAchieved} / ${stats.speedLimit}")),
      ],
    );
  }
}
