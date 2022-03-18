import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/blocs/authentication/authentication_bloc.dart';
import '../../core/extensions/string.dart';
import '../../router/blocs/router/router_bloc.dart';
import '../l10n/gen/app_localizations.dart';
import 'inline_hover_button.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);
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
                  child: const Text('home'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToUnknownRoute()),
                  child: const Text('unknown'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToStoriesRoute()),
                  child: const Text('play'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToMissionRoute('the-story-continues', 'x3')),
                  child: const Text('mission'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToProfileRoute()),
                  child: const Text('profile'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => routerBloc.add(ToSettingsRoute()),
                  child: const Text('settings'),
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
                  onPressed: () => authBloc.add(RestoreAuthentication()),
                  child: const Text('restore-authentication'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => authBloc.add(Authenticate()),
                  child: const Text('authenticate'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InlineHoverButton(
                  onPressed: () => authBloc.add(RemoveAuthentication()),
                  child: const Text('unauthenticate'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return Text("$state");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
