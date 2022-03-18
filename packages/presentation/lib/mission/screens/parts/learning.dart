import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../../model/mission.dart';
import '../../../../model/story.dart';
import '../../../core/widgets/default_screen_container.dart';
import '../../../router/blocs/router/router_bloc.dart';

class LearningScreenPart extends StatelessWidget {
  final LearningMission mission;
  final Story story;

  const LearningScreenPart({required this.story, required this.mission, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);

    return DefaultScreenContainer(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: [
              Text(
                mission.name,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 50,
              ),
              MarkdownBody(data: mission.description),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () => routerBloc.add(ToStoryRoute(story.id)),
                child: const Text('back to story'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
