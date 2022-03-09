import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:main/authentication/authentication_bloc.dart';
import 'package:main/extensions/string.dart';

import '../router/router_bloc.dart';
import 'inline_hover_button.dart';
import 'overlay_button.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => routerBloc.add(ToHomeRoute()),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        localization.appTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (authState is Authenticated) ...[
                      OverlayButton(
                        onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToStoriesRoute()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(TablerIcons.book),
                            const SizedBox(width: 4),
                            Text(localization.storiesButton.toTitleCase())
                          ],
                        ),
                      ),
                      OverlayButton(
                        onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToStatsRoute()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(TablerIcons.crown),
                            SizedBox(width: 4),
                            Text('42'),
                          ],
                        ),
                      ),
                      OverlayButton(
                        overlayWidth: 110,
                        onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToProfileRoute()),
                        child: const Icon(TablerIcons.face_id),
                        overlay: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InlineHoverButton(
                                onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToProfileRoute()),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text(localization.profileButton.toTitleCase()),
                                ),
                              ),
                              InlineHoverButton(
                                onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToSettingsRoute()),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text(localization.settingsButton.toTitleCase()),
                                ),
                              ),
                              InlineHoverButton(
                                onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToInfoRoute()),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text(localization.aboutUsButton.toTitleCase()),
                                ),
                              ),
                              InlineHoverButton(
                                onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(RemoveAuthentication()),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text(localization.signOutButton.toTitleCase()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    if (authState is Unauthenticated) ...[
                      OverlayButton(
                        onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToSignInRoute()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(TablerIcons.login),
                            const SizedBox(width: 4),
                            Text(localization.signInButton.toTitleCase()),
                          ],
                        ),
                      ),
                      OverlayButton(
                        onPressed: () => BlocProvider.of<RouterBloc>(context).add(ToSignUpRoute()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(TablerIcons.user_plus),
                            const SizedBox(width: 4),
                            Text(localization.signUpButton.toTitleCase())
                          ],
                        ),
                      ),
                    ],
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
