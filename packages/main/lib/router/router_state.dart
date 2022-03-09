part of 'router_bloc.dart';

/// Marks a route so only the authenticated users can access it.
abstract class RequiresAuthentication {}

/// Marks a route so only the unauthenticated users can access it.
abstract class ForbiddenAfterAuthentication {}

@immutable
abstract class RouterState {}

class HomeRoute extends RouterState {}

class UnknownRoute extends RouterState {}

// Sign

abstract class SignRoute extends RouterState {}

class SignInRoute extends SignRoute implements ForbiddenAfterAuthentication {}

class SignUpRoute extends SignRoute implements ForbiddenAfterAuthentication {}

// Play

abstract class PlayRoute extends RouterState implements RequiresAuthentication {}

class StoriesRoute extends PlayRoute {}

class StoryRoute extends PlayRoute {
  final String id;

  StoryRoute(this.id);
}

class MissionRoute extends PlayRoute {
  final String storyId;
  final String missionId;

  MissionRoute(this.storyId, this.missionId);
}

// Other

class StatsRoute extends RouterState implements RequiresAuthentication {}

class ProfileRoute extends RouterState implements RequiresAuthentication {}

class SettingsRoute extends RouterState implements RequiresAuthentication {}

// About

abstract class AboutRoute extends RouterState {}

class InfoRoute extends AboutRoute {}

class ApproachRoute extends AboutRoute {}

class PressRoute extends AboutRoute {}

class ContactRoute extends AboutRoute {}

class AppsRoute extends AboutRoute {}

class HelpRoute extends AboutRoute {}

class GuidelinesRoute extends AboutRoute {}

class TermsRoute extends AboutRoute {}

class PrivacyRoute extends AboutRoute {}
