import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../l10n/gen/app_localizations.dart';

class PressScreen extends StatelessWidget {
  const PressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return Column(
      children: [
        MarkdownBody(data: localization.aboutUsPressContent),
      ],
    );
  }
}
