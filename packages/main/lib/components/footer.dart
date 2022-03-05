import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:main/components/inline_hover_button.dart';
import 'package:main/extensions/string.dart';

import '../router/router_bloc.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToInfoRoute()),
                  child: Text(localization.aboutUsButton.toCapitalized()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToHelpRoute()),
                  child: Text(localization.aboutUsHelpButton.toCapitalized()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToContactRoute()),
                  child: Text(localization.aboutUsContactButton.toCapitalized()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToGuidelinesRoute()),
                  child: Text(localization.aboutUsGuidelinesButton.toCapitalized()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToTermsRoute()),
                  child: Text(localization.aboutUsTermsButton.toCapitalized()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToPrivacyRoute()),
                  child: Text(localization.aboutUsPrivacyButton.toCapitalized()),
                ),
              ),
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToHomeRoute()),
                  child: Text('home'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToUnknownRoute()),
                  child: Text('unknown'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToStoriesRoute()),
                  child: Text('play'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToMissionRoute('someStory', 'someMission')),
                  child: Text('mission'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToProfileRoute()),
                  child: Text('profile'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToSettingsRoute()),
                  child: Text('settings'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
