import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/router/route_config.dart';
import 'package:main/router/router_bloc.dart';
import 'package:main/window/app_window.dart';

import '../screens/about_screen.dart';
import '../screens/home_screen.dart';
import '../screens/play_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/sign_screen.dart';
import '../screens/stats_screen.dart';
import '../screens/unknown_screen.dart';
import 'no_animation_transition_delegate.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class AppRouterDelegate extends RouterDelegate<RouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfig> {
  final RouterBloc routerBloc;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  final TransitionDelegate transitionDelegate = NoAnimationTransitionDelegate();

  AppRouterDelegate({required this.routerBloc}) {
    routerBloc.stream.forEach((_) => notifyListeners());
  }

  // ADT to State
  @override
  Future<void> setNewRoutePath(RouteConfig configuration) async {
    if (configuration is HomeRouteConfig) {
      return routerBloc.add(ToHomeRoute());
    }

    if (configuration is UnknownRouteConfig) {
      return routerBloc.add(ToUnknownRoute());
    }

    // Sign

    if (configuration is SignInRouteConfig) {
      return routerBloc.add(ToSignInRoute());
    }

    if (configuration is SignUpRouteConfig) {
      return routerBloc.add(ToSignUpRoute());
    }

    // Play

    if (configuration is StoriesRouteConfig) {
      return routerBloc.add(ToStoriesRoute());
    }

    if (configuration is StoryRouteConfig) {
      return routerBloc.add(ToStoryRoute(configuration.id));
    }

    if (configuration is MissionRouteConfig) {
      return routerBloc.add(ToMissionRoute(configuration.storyId, configuration.missionId));
    }

    // Other

    if (configuration is StatsRouteConfig) {
      return routerBloc.add(ToStatsRoute());
    }

    if (configuration is ProfileRouteConfig) {
      return routerBloc.add(ToProfileRoute());
    }

    if (configuration is SettingsRouteConfig) {
      return routerBloc.add(ToSettingsRoute());
    }

    // About

    if (configuration is InfoRouteConfig) {
      return routerBloc.add(ToInfoRoute());
    }

    if (configuration is ApproachRouteConfig) {
      return routerBloc.add(ToApproachRoute());
    }

    if (configuration is PressRouteConfig) {
      return routerBloc.add(ToPressRoute());
    }

    if (configuration is ContactRouteConfig) {
      return routerBloc.add(ToContactRoute());
    }

    if (configuration is AppsRouteConfig) {
      return routerBloc.add(ToAppsRoute());
    }

    if (configuration is HelpRouteConfig) {
      return routerBloc.add(ToHelpRoute());
    }

    if (configuration is GuidelinesRouteConfig) {
      return routerBloc.add(ToGuidelinesRoute());
    }

    if (configuration is TermsRouteConfig) {
      return routerBloc.add(ToTermsRoute());
    }

    if (configuration is PrivacyRouteConfig) {
      return routerBloc.add(ToPrivacyRoute());
    }

    return routerBloc.add(ToUnknownRoute());
  }

  // State to ADT
  @override
  RouteConfig get currentConfiguration {
    if (routerBloc.state is HomeRoute) {
      return HomeRouteConfig();
    }

    if (routerBloc.state is UnknownRoute) {
      return UnknownRouteConfig();
    }

    // Sign

    if (routerBloc.state is SignInRoute) {
      return SignInRouteConfig();
    }

    if (routerBloc.state is SignUpRoute) {
      return SignUpRouteConfig();
    }

    // Play

    if (routerBloc.state is StoriesRoute) {
      return StoriesRouteConfig();
    }

    if (routerBloc.state is StoryRoute) {
      return StoryRouteConfig((routerBloc.state as StoryRoute).id);
    }

    if (routerBloc.state is MissionRoute) {
      final missionState = routerBloc.state as MissionRoute;
      return MissionRouteConfig(missionState.storyId, missionState.missionId);
    }

    // Other

    if (routerBloc.state is StatsRoute) {
      return StatsRouteConfig();
    }

    if (routerBloc.state is ProfileRoute) {
      return ProfileRouteConfig();
    }

    if (routerBloc.state is SettingsRoute) {
      return SettingsRouteConfig();
    }

    // About

    if (routerBloc.state is InfoRoute) {
      return InfoRouteConfig();
    }

    if (routerBloc.state is ApproachRoute) {
      return ApproachRouteConfig();
    }

    if (routerBloc.state is PressRoute) {
      return PressRouteConfig();
    }

    if (routerBloc.state is ContactRoute) {
      return ContactRouteConfig();
    }

    if (routerBloc.state is AppsRoute) {
      return AppsRouteConfig();
    }

    if (routerBloc.state is HelpRoute) {
      return HelpRouteConfig();
    }

    if (routerBloc.state is GuidelinesRoute) {
      return GuidelinesRouteConfig();
    }

    if (routerBloc.state is TermsRoute) {
      return TermsRouteConfig();
    }

    if (routerBloc.state is PrivacyRoute) {
      return PrivacyRouteConfig();
    }

    return UnknownRouteConfig();
  }

  bool onPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) return false;
    routerBloc.add(ToHomeRoute());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AppWindow(
      child: BlocBuilder<RouterBloc, RouterState>(
        builder: (context, routerState) {
          return Navigator(
            key: navigatorKey,
            onPopPage: onPopPage,
            transitionDelegate: transitionDelegate,
            pages: [
              const MaterialPage(
                key: ValueKey('home'),
                child: HomeScreen(title: 'Home Page toto je'),
              ),
              if (routerState is UnknownRoute)
                const MaterialPage(
                  key: ValueKey('unknown'),
                  child: UnknownScreen(),
                ),

              // Sign

              if (routerState is SignRoute)
                MaterialPage(
                  key: const ValueKey('sign'),
                  child: SignScreen(),
                ),

              // Play

              if (routerState is PlayRoute)
                MaterialPage(
                  key: const ValueKey('play'),
                  child: PlayScreen(),
                ),

              // Other


              if (routerState is StatsRoute)
                const MaterialPage(
                  key: ValueKey('stats'),
                  child: StatsScreen(),
                ),
              if (routerState is ProfileRoute)
                const MaterialPage(
                  key: ValueKey('profile'),
                  child: ProfileScreen(),
                ),
              if (routerState is SettingsRoute)
                const MaterialPage(
                  key: ValueKey('settings'),
                  child: SettingsScreen(),
                ),

              // About

              if (routerState is AboutRoute)
                const MaterialPage(
                  key: ValueKey('about'),
                  child: AboutScreen(),
                ),
            ],
          );
        },
      ),
    );
  }
}
