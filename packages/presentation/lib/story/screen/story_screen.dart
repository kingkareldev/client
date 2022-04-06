import 'package:business_contract/story/entities/mission/mission.dart';
import 'package:business_contract/story/services/story_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/l10n/gen/app_localizations.dart';
import '../../core/widgets/default_screen_container.dart';
import '../../router/blocs/router/router_bloc.dart';
import '../bloc/story/story_bloc.dart';
import '../widgets/mission_item.dart';
import '../widgets/mission_overlay.dart';

class StoryScreen extends StatefulWidget {
  final String id;

  const StoryScreen({required this.id, Key? key}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  OverlayEntry? _overlayEntry;
  LayerLink? _layerLink;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void onMissionCircleSelected(BuildContext context, LayerLink link, Mission mission, String storyUrl) {
    _overlayEntry?.remove();
    _overlayEntry = null;

    if (link == _layerLink) {
      _layerLink = null;
      return;
    }

    _layerLink = link;
    _overlayEntry = _createOverlayEntry(context, link, mission, storyUrl);
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(BuildContext context, LayerLink link, Mission mission, String storyUrl) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    const double overlayWidth = 200;

    // By default align with center.
    Offset offset = Offset(size.width / 2 - overlayWidth / 2, size.height + 5);

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: overlayWidth,
          child: CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: offset,
            child: Material(
              elevation: 1,
              color: Colors.white,
              child: MissionOverlay(storyUrl: storyUrl, mission: mission),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return DefaultScreenContainer(
      children: [
        BlocProvider(
          create: (context) =>
              StoryBloc(storyService: GetIt.I<StoryService>(), routerBloc: routerBloc)..add(Load(storyUrl: widget.id)),
          child: BlocBuilder<StoryBloc, StoryState>(
            builder: (context, state) {
              if (state is StoryLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          state.story.name,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: Column(
                            children: [
                              for (int i = 0; i < state.story.missions.length; i++) ...[
                                MissionItem(
                                  mission: state.story.missions[i],
                                  onPressed: (BuildContext context, LayerLink link, Mission mission) =>
                                      onMissionCircleSelected(context, link, mission, state.story.url),
                                ),
                                if (i != state.story.missions.length - 1)
                                  Container(
                                    color: Colors.black87,
                                    width: 4,
                                    height: 100,
                                    margin: const EdgeInsets.only(right: 225),
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Center(
                child: Text(localization.loadingText),
              );
            },
          ),
        ),
      ],
    );
  }
}
