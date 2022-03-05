import 'package:flutter/material.dart';

import 'route_config.dart';

class AppRouteInformationParser extends RouteInformationParser<RouteConfig> {
  // URL to ADT
  @override
  Future<RouteConfig> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');

    if (uri.pathSegments.isEmpty) {
      return HomeRouteConfig();
    }

    if (uri.pathSegments[0] == '404' && uri.pathSegments.length == 1) {
      return UnknownRouteConfig();
    }

    // Sign

    if (uri.pathSegments[0] == 'signin' && uri.pathSegments.length == 1) {
      return SignInRouteConfig();
    }

    if (uri.pathSegments[0] == 'signup' && uri.pathSegments.length == 1) {
      return SignUpRouteConfig();
    }

    if (uri.pathSegments[0] == 'signout' && uri.pathSegments.length == 1) {
      return SignOutRouteConfig();
    }

    // Play

    if (uri.pathSegments[0] == 'play') {
      if (uri.pathSegments.length == 1) {
        return StoriesRouteConfig();
      } else if (uri.pathSegments.length == 2) {
        final id = uri.pathSegments[1];
        return StoryRouteConfig(id);
      } else if (uri.pathSegments.length == 3) {
        final storyId = uri.pathSegments[1];
        final missionId = uri.pathSegments[2];
        return MissionRouteConfig(storyId, missionId);
      }
    }

    // Other

    if (uri.pathSegments[0] == 'stats' && uri.pathSegments.length == 1) {
      return StatsRouteConfig();
    }

    if (uri.pathSegments[0] == 'profile' && uri.pathSegments.length == 1) {
      return ProfileRouteConfig();
    }

    if (uri.pathSegments[0] == 'settings' && uri.pathSegments.length == 1) {
      return SettingsRouteConfig();
    }

    // About

    if (uri.pathSegments[0] == 'info' && uri.pathSegments.length == 1) {
      return InfoRouteConfig();
    }

    if (uri.pathSegments[0] == 'approach' && uri.pathSegments.length == 1) {
      return ApproachRouteConfig();
    }

    if (uri.pathSegments[0] == 'press' && uri.pathSegments.length == 1) {
      return PressRouteConfig();
    }

    if (uri.pathSegments[0] == 'contact' && uri.pathSegments.length == 1) {
      return ContactRouteConfig();
    }

    if (uri.pathSegments[0] == 'apps' && uri.pathSegments.length == 1) {
      return AppsRouteConfig();
    }

    if (uri.pathSegments[0] == 'help' && uri.pathSegments.length == 1) {
      return HelpRouteConfig();
    }

    if (uri.pathSegments[0] == 'guidelines' && uri.pathSegments.length == 1) {
      return GuidelinesRouteConfig();
    }

    if (uri.pathSegments[0] == 'terms' && uri.pathSegments.length == 1) {
      return TermsRouteConfig();
    }

    if (uri.pathSegments[0] == 'privacy' && uri.pathSegments.length == 1) {
      return PrivacyRouteConfig();
    }

    return UnknownRouteConfig();
  }

  // ADT to URL
  @override
  RouteInformation? restoreRouteInformation(RouteConfig configuration) {
    if (configuration is HomeRouteConfig) {
      return const RouteInformation(location: '/');
    }

    if (configuration is UnknownRouteConfig) {
      return const RouteInformation(location: '/404');
    }

    // Sign

    if (configuration is SignInRouteConfig) {
      return const RouteInformation(location: '/signin');
    }

    if (configuration is SignUpRouteConfig) {
      return const RouteInformation(location: '/signup');
    }

    if (configuration is SignOutRouteConfig) {
      return const RouteInformation(location: '/signout');
    }

    // Play

    if (configuration is StoriesRouteConfig) {
      return const RouteInformation(location: '/play');
    }

    if (configuration is StoryRouteConfig) {
      return RouteInformation(location: '/play/${configuration.id}');
    }

    if (configuration is MissionRouteConfig) {
      return RouteInformation(location: '/play/${configuration.storyId}/${configuration.missionId}');
    }

    // Other

    if (configuration is StatsRouteConfig) {
      return const RouteInformation(location: '/stats');
    }

    if (configuration is ProfileRouteConfig) {
      return const RouteInformation(location: '/profile');
    }

    if (configuration is SettingsRouteConfig) {
      return const RouteInformation(location: '/settings');
    }

    // About

    if (configuration is InfoRouteConfig) {
      return const RouteInformation(location: '/info');
    }

    if (configuration is ApproachRouteConfig) {
      return const RouteInformation(location: '/approach');
    }

    if (configuration is PressRouteConfig) {
      return const RouteInformation(location: '/press');
    }

    if (configuration is ContactRouteConfig) {
      return const RouteInformation(location: '/contact');
    }

    if (configuration is AppsRouteConfig) {
      return const RouteInformation(location: '/apps');
    }

    if (configuration is HelpRouteConfig) {
      return const RouteInformation(location: '/help');
    }

    if (configuration is GuidelinesRouteConfig) {
      return const RouteInformation(location: '/guidelines');
    }

    if (configuration is TermsRouteConfig) {
      return const RouteInformation(location: '/terms');
    }

    if (configuration is PrivacyRouteConfig) {
      return const RouteInformation(location: '/privacy');
    }

    return const RouteInformation(location: '/404');
  }
}
