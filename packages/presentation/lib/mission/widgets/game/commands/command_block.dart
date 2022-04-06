import 'package:business_contract/story/entities/commands/command.dart';
import 'package:business_contract/story/entities/commands/condition_command.dart';
import 'package:business_contract/story/entities/commands/direction_command.dart';
import 'package:business_contract/story/entities/common/condition.dart';
import 'package:business_contract/story/entities/common/direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:presentation/core/utils/direction.dart';
import 'package:presentation/core/widgets/overlay_button.dart';

import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/utils/condition.dart';

class CommandBlock extends StatelessWidget {
  final bool isRunningActive;
  final int color;
  final String name;
  final void Function(BuildContext, PointerDownEvent) onPointerDown;
  final Command command;
  final bool isPalette;

  const CommandBlock({
    this.isRunningActive = false,
    required this.color,
    required this.name,
    required this.onPointerDown,
    required this.command,
    this.isPalette = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.grab,
          child: Listener(
            onPointerDown: (event) => onPointerDown(context, event),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 50,
              ),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(color),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  _CommandCondition(command: command, ignore: isPalette),
                ],
              ),
            ),
          ),
        ),
        if (isRunningActive) const Icon(TablerIcons.arrow_big_left, color: Colors.red),
      ],
    );
  }
}

class _CommandCondition extends StatefulWidget {
  final Command command;
  final bool ignore;

  const _CommandCondition({
    required this.command,
    this.ignore = false,
    Key? key,
  }) : super(key: key);

  @override
  State<_CommandCondition> createState() => _CommandConditionState();
}

class _CommandConditionState extends State<_CommandCondition> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    if (widget.command is ConditionCommand) {
      final ConditionCommand conditionCommand = widget.command as ConditionCommand;
      return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: OverlayButton(
          inactiveOpacity: 0.8,
          ignore: widget.ignore,
          overlayWidth: 120,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(convertConditionToString(condition: conditionCommand.condition, localization: localization)),
          ),
          overlay: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final option in Condition.values)
                TextButton(
                  onPressed: () {
                    setState(() {
                      conditionCommand.condition = option;
                    });
                  },
                  child: Text(convertConditionToString(condition: option, localization: localization)),
                ),
            ],
          ),
        ),
      );
    }

    if (widget.command is DirectionCommand) {
      final DirectionCommand directionCommand = widget.command as DirectionCommand;
      return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: OverlayButton(
          inactiveOpacity: 0.8,
          ignore: widget.ignore,
          overlayWidth: 70,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(convertDirectionToString(direction: directionCommand.direction, localization: localization)),
          ),
          overlay: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (final option in Direction.values)
                TextButton(
                  onPressed: () {
                    setState(() {
                      directionCommand.direction = option;
                    });
                  },
                  child: Text(convertDirectionToString(direction: option, localization: localization)),
                ),
            ],
          ),
        ),
      );
    }

    return Container();
  }
}
