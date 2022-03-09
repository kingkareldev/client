import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/screens/play/stories_screen.dart';
import 'package:main/screens/play/mission_screen.dart';
import 'package:main/screens/play/story_screen.dart';

import '../router/no_animation_transition_delegate.dart';
import '../router/router_bloc.dart';

class PlayScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> _playNavigatorKey = GlobalKey<NavigatorState>();
  final TransitionDelegate transitionDelegate = NoAnimationTransitionDelegate();

  PlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RouterBloc, RouterState>(
        builder: (context, routerState) {
          return Navigator(
            key: _playNavigatorKey,
            transitionDelegate: transitionDelegate,
            onPopPage: (_, __) => false,
            pages: [
              const MaterialPage(
                key: ValueKey('play stories'),
                child: StoriesScreen(),
              ),
              if (routerState is StoryRoute)
                MaterialPage(
                  key: const ValueKey('play story'),
                  child: StoryScreen(id: routerState.id),
                ),
              if (routerState is MissionRoute)
                MaterialPage(
                  key: const ValueKey('play mission'),
                  child: MissionScreen(storyId: routerState.storyId, missionId: routerState.missionId),
                ),
            ],
          );
        },
      ),
    );
  }
}
