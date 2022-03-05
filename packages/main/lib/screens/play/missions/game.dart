import 'package:flutter/material.dart';

import '../../../model/mission.dart';
import '../../../model/story.dart';
import '../commands/commands_view.dart';

class GameView extends StatelessWidget {
  final GameMission mission;
  final Story story;

  const GameView({required this.story, required this.mission, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      color: Theme.of(context).splashColor,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            color: Colors.amberAccent.shade200,
            child: const Text("mission screen"),
          ),
          const Expanded(
            child: CommandsView(),
          ),
        ],
      ),
    );
  }
}
