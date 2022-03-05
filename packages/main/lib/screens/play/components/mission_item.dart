import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../model/mission.dart';

class MissionItem extends StatefulWidget {
  final Mission mission;
  final void Function(BuildContext, LayerLink, Mission)? onPressed;

  MissionItem({required this.mission, this.onPressed, Key? key}) : super(key: key);

  @override
  State<MissionItem> createState() => _MissionItemState();
}

class _MissionItemState extends State<MissionItem> {
  final LayerLink _layerLink = LayerLink();
  bool isHovered = false;

  void onHoverChanged(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }

  IconData getMissionIcon() {
    if (widget.mission is GameMission) {
      return TablerIcons.sailboat;
    } else if (widget.mission is StoryMission) {
      return TablerIcons.book;
    }

    return TablerIcons.school;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 25),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              width: 5,
              color: isHovered ? Colors.blue.shade100 : Colors.black87,
            ),
          ),
          child: Builder(
            builder: (context) {
              return CompositedTransformTarget(
                link: _layerLink,
                child: GestureDetector(
                  onTap: () => widget.onPressed?.call(context, _layerLink, widget.mission),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => onHoverChanged(true),
                    onExit: (_) => onHoverChanged(false),
                    child: Center(
                      child: Icon(
                        getMissionIcon(),
                        size: 48,
                        color: isHovered ? Colors.blue : Colors.black87,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: 200,
          child: Text(
            widget.mission.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100, color: Colors.black38),
          ),
        ),
      ],
    );
  }
}
