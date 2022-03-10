import 'package:flutter/material.dart';
import 'package:presentation/extensions/iterable.dart';

import '../../components/default_screen_container.dart';
import '../../model/mission.dart';
import '../../model/story.dart';
import 'components/mission_item.dart';
import 'components/mission_overlay.dart';

class StoryScreen extends StatefulWidget {
  final String id;

  const StoryScreen({required this.id, Key? key}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  Story? story;

  OverlayEntry? _overlayEntry;
  LayerLink? _layerLink;

  @override
  void initState() {
    // TODO
    story = storiesDataTmp.firstWhereOrNull((element) => element.id == widget.id);
    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void onMissionCircleSelected(BuildContext context, LayerLink link, Mission mission) {
    _overlayEntry?.remove();
    _overlayEntry = null;

    if (link == _layerLink) {
      _layerLink = null;
      return;
    }

    _layerLink = link;
    _overlayEntry = _createOverlayEntry(context, link, mission);
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(BuildContext context, LayerLink link, Mission mission) {
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
              child: MissionOverlay(story: story!, mission: mission),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer(
      children: [
        if (story == null)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text("not a valid story"),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    story!.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Column(
                      children: [
                        for (int i = 0; i < story!.missions.length; i++) ...[
                          MissionItem(
                            mission: story!.missions[i],
                            onPressed: onMissionCircleSelected,
                          ),
                          if (i != story!.missions.length - 1)
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
          ),
      ],
    );
  }
}
