import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:main/components/default_screen_container.dart';
import 'package:main/extensions/string.dart';
import 'package:main/screens/stats/stat_item.dart';

import '../model/story_stats.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    const bool _displayName = false;
    const TextStyle headerTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );

    return DefaultScreenContainer(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 200),
          child: Column(
            children: [
              Text(
                localization.statsTitle.toTitleCase(),
                style: Theme.of(context).textTheme.headline4,
              ),
              if (statsTmpData.isEmpty)
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Text(localization.noDataLabel),
                    ],
                  ),
                )
              else
                for (final story in statsTmpData) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 20),
                    child: Text(
                      story.storyName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (story.stats.isEmpty)
                    Center(child: Text(localization.noDataLabel))
                  else
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          if (_displayName)
                            Center(child: Text(localization.statsUsernameColumn.toTitleCase(), style: headerTextStyle)),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(localization.statsCompletedColumn.toTitleCase(), style: headerTextStyle),
                            ),
                          ),
                          Center(child: Text(localization.statsSizeColumn.toTitleCase(), style: headerTextStyle)),
                          Center(child: Text(localization.statsSpeedColumn.toTitleCase(), style: headerTextStyle)),
                        ]),
                        for (final item in story.stats) StatItem(stats: item, displayName: _displayName).build(context),
                      ],
                    )
                ]
            ],
          ),
        ),
      ],
    );
  }
}