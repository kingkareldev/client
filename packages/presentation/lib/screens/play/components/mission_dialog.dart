import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:presentation/extensions/string.dart';

import '../../../l10n/gen/app_localizations.dart';

class MissionDialog extends StatelessWidget {
  final bool isCompleted;
  final String name;
  final int size;
  final int sizeLimit;
  final int speed;
  final int speedLimit;
  final void Function() onTryAgain;
  final void Function() onToStory;

  const MissionDialog({
    required this.name,
    required this.isCompleted,
    required this.size,
    required this.sizeLimit,
    required this.speed,
    required this.speedLimit,
    required this.onTryAgain,
    required this.onToStory,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTryAgain,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          color: Colors.black87.withOpacity(0.5),
          child: Center(
            child: GestureDetector(
              onTap: () => {},
              child: MouseRegion(
                cursor: SystemMouseCursors.basic,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(30),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Icon(
                            TablerIcons.crown,
                            size: 48,
                            color: isCompleted ? Colors.blue : Colors.red,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                            isCompleted ? localization.missionSuccessDescription : localization.missionFailDescription),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: size > sizeLimit ? Colors.red : Colors.black87,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: localization.statsSizeColumn,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ': $size / $sizeLimit'),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: speed > speedLimit ? Colors.red : Colors.black87,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: localization.statsSpeedColumn,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ': $speed / $speedLimit'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (isCompleted) ...[
                            OutlinedButton(
                              onPressed: onTryAgain,
                              child: Text(localization.missionDialogTryAgainButton.toTitleCase()),
                            ),
                            ElevatedButton(
                              onPressed: onToStory,
                              child: Text(localization.missionDialogBackToStoryButton.toTitleCase()),
                            ),
                          ] else ...[
                            OutlinedButton(
                              onPressed: onToStory,
                              child: Text(localization.missionDialogBackToStoryButton.toTitleCase()),
                            ),
                            ElevatedButton(
                              onPressed: onTryAgain,
                              child: Text(localization.missionDialogTryAgainButton.toTitleCase()),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
