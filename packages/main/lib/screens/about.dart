import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:main/components/default_screen_container.dart';
import 'package:main/extensions/string.dart';

import '../components/hover_button.dart';
import '../router/router_bloc.dart';
import 'about/approach.dart';
import 'about/apps.dart';
import 'about/contact.dart';
import 'about/guidelines.dart';
import 'about/help.dart';
import 'about/info.dart';
import 'about/press.dart';
import 'about/privacy.dart';
import 'about/terms.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return DefaultScreenContainer(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 40, left: 15),
          child: Text(
            localization.aboutUsTitle.toTitleCase(),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const _BuildAboutMenu(),
        Divider(
          thickness: 1,
          height: 0,
          color: Colors.grey.shade300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _BuildScreens(),
            ],
          ),
        ),
      ],
    );
  }
}

class _BuildScreens extends StatelessWidget {
  const _BuildScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouterBloc, RouterState>(
      builder: (context, routerState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (routerState is ApproachRoute) const ApproachScreen(),
            if (routerState is AppsRoute) const AppsScreen(),
            if (routerState is ContactRoute) const ContactScreen(),
            if (routerState is GuidelinesRoute) const GuidelinesScreen(),
            if (routerState is HelpRoute) const HelpScreen(),
            if (routerState is InfoRoute) const InfoScreen(),
            if (routerState is PressRoute) const PressScreen(),
            if (routerState is PrivacyRoute) const PrivacyScreen(),
            if (routerState is TermsRoute) const TermsScreen(),
          ],
        );
      },
    );
  }
}

class _BuildAboutMenu extends StatelessWidget {
  const _BuildAboutMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return BlocBuilder<RouterBloc, RouterState>(
      bloc: routerBloc,
      builder: (context, routerState) {
        return Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: [
            HoverButton(
              isActive: routerState is ApproachRoute,
              onPressed: () => routerBloc.add(ToApproachRoute()),
              child: Text(localization.aboutUsApproachButton.toUpperCase()),
            ),
            HoverButton(
              isActive: routerState is AppsRoute,
              onPressed: () => routerBloc.add(ToAppsRoute()),
              child: Text(localization.aboutUsAppsButton.toUpperCase()),
            ),
            HoverButton(
              isActive: routerState is ContactRoute,
              onPressed: () => routerBloc.add(ToContactRoute()),
              child: Text(localization.aboutUsContactButton.toUpperCase()),
            ),
            HoverButton(
              isActive: routerState is GuidelinesRoute,
              onPressed: () => routerBloc.add(ToGuidelinesRoute()),
              child: Text(localization.aboutUsGuidelinesButton.toUpperCase()),
            ),
            HoverButton(
              isActive: routerState is HelpRoute,
              onPressed: () => routerBloc.add(ToHelpRoute()),
              child: Text(localization.aboutUsHelpButton.toUpperCase()),
            ),
            HoverButton(
              isActive: routerState is InfoRoute,
              onPressed: () => routerBloc.add(ToInfoRoute()),
              child: Text(localization.aboutUsInfoButton.toUpperCase()),
            ),
            HoverButton(
              isActive: routerState is PressRoute,
              onPressed: () => routerBloc.add(ToPressRoute()),
              child: Text(localization.aboutUsPressButton.toUpperCase()),
            ),
            HoverButton(
              isActive: routerState is PrivacyRoute,
              onPressed: () => routerBloc.add(ToPrivacyRoute()),
              child: Text(localization.aboutUsPrivacyButton.toUpperCase()),
            ),
            HoverButton(
              isActive: routerState is TermsRoute,
              onPressed: () => routerBloc.add(ToTermsRoute()),
              child: Text(localization.aboutUsTermsButton.toUpperCase()),
            ),
          ],
        );
      },
    );
  }
}
