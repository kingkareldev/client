part of 'router_bloc.dart';

@immutable
abstract class RouterState {}

class HomeRoute extends RouterState {}

class UnknownRoute extends RouterState {}

// Sign

abstract class SignRoute extends RouterState {}

class SignInRoute extends SignRoute {}

class SignUpRoute extends SignRoute {}

class SignOutRoute extends SignRoute {}

// Play

abstract class PlayRoute extends RouterState {}

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

class StatsRoute extends RouterState {}

class ProfileRoute extends RouterState {}

class SettingsRoute extends RouterState {}

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
