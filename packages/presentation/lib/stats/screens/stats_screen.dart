import 'package:business_contract/story/entities/mission/game_mission.dart';
import 'package:business_contract/story/services/story_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/authentication/blocs/authentication/authentication_bloc.dart';

import '../../core/extensions/string.dart';
import '../../core/l10n/gen/app_localizations.dart';
import '../../core/widgets/default_screen_container.dart';
import '../bloc/stats/stats_bloc.dart';
import '../widgets/stat_item.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);

    const bool _shouldDisplayName = true;
    const TextStyle headerTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );

    return DefaultScreenContainer(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: BlocProvider(
            create: (context) => StatsBloc(storyService: GetIt.I<StoryService>())..add(Load()),
            child: BlocBuilder<StatsBloc, StatsState>(
              builder: (context, state) {
                if (state is StatsLoaded) {
                  return Column(
                    children: [
                      Text(
                        localization.statsTitle.toTitleCase(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      if (state.stories.isEmpty)
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 50),
                              Text(localization.noDataLabel),
                            ],
                          ),
                        )
                      else
                        for (final story in state.stories) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 50, bottom: 20),
                            child: Text(
                              story.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (story.missions.whereType<GameMission>().isEmpty)
                            Center(child: Text(localization.noDataLabel))
                          else
                            Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(children: [
                                  if (_shouldDisplayName)
                                    Center(
                                        child: Text(localization.statsUsernameColumn.toTitleCase(),
                                            style: headerTextStyle)),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child:
                                      Text(localization.statsMissionNameColumn.toTitleCase(), style: headerTextStyle),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child:
                                          Text(localization.statsCompletedColumn.toTitleCase(), style: headerTextStyle),
                                    ),
                                  ),
                                  Center(
                                      child: Text(localization.statsSizeColumn.toTitleCase(), style: headerTextStyle)),
                                  Center(
                                      child: Text(localization.statsSpeedColumn.toTitleCase(), style: headerTextStyle)),
                                ]),
                                for (final item in story.missions.whereType<GameMission>())
                                  StatItem(
                                    user: (authBloc.state as Authenticated).user,
                                    mission: item,
                                    displayName: _shouldDisplayName,
                                  ).build(context),
                              ],
                            )
                        ]
                    ],
                  );
                }

                return Center(
                  child: Text(localization.loadingText),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
