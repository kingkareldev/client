import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../core/widgets/default_screen_container.dart';
import '../../../model/mission.dart';
import '../../../model/story.dart';
import '../../../router/blocs/router/router_bloc.dart';

class StoryScreenPart extends StatefulWidget {
  final StoryMission mission;
  final Story story;

  const StoryScreenPart({required this.story, required this.mission, Key? key}) : super(key: key);

  @override
  State<StoryScreenPart> createState() => _StoryScreenPartState();
}

class _StoryScreenPartState extends State<StoryScreenPart> {
  int progress = 0;

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
                widget.mission.name,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 50,
              ),
              for (int i = 0; i < widget.mission.data.length; i++)
                if (i <= progress)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: MarkdownBody(data: widget.mission.data[i]),
                  ),
              if (progress != widget.mission.data.length - 1)
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      progress++;
                    });
                  },
                  child: const Text('next'),
                )
              else
                ElevatedButton(
                  onPressed: () => routerBloc.add(ToStoryRoute(widget.story.id)),
                  child: const Text('back to story'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
