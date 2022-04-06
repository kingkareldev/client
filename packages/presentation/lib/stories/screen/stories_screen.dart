import 'package:business_contract/story/entities/story/story.dart';
import 'package:business_contract/story/services/story_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/stories/bloc/stories/stories_bloc.dart';

import '../../core/extensions/string.dart';
import '../../core/l10n/gen/app_localizations.dart';
import '../../core/widgets/default_screen_container.dart';
import '../../router/blocs/router/router_bloc.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return DefaultScreenContainer(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Align(
            alignment: Alignment.center,
            child: BlocProvider(
              create: (context) => StoriesBloc(storyService: GetIt.I<StoryService>())..add(Load()),
              child: BlocBuilder<StoriesBloc, StoriesState>(
                builder: (context, state) {
                  if (state is StoriesInitial) {
                    return Center(
                      child: Text(localization.loadingText),
                    );
                  }

                  if (state is StoriesLoaded && state.stories.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          localization.storiesTitle.toTitleCase(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(localization.storiesDescription),
                        const SizedBox(height: 60),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (final Story story in state.stories)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: GestureDetector(
                                  onTap: () => routerBloc.add(ToStoryRoute(story.url)),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              story.name,
                                              style: Theme.of(context).textTheme.headline4,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              child: Text(story.description),
                                            ),
                                            Text(
                                              localization.storiesMissionCountDescription(story.missionCount),
                                              style: const TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      ],
                    );
                  }

                  return const Text("no story available");
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
