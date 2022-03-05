part of 'router_bloc.dart';

@immutable
abstract class RouterEvent {}

class ToHomeRoute extends RouterEvent {}

class ToUnknownRoute extends RouterEvent {}

// Sign

class ToSignInRoute extends RouterEvent {}

class ToSignUpRoute extends RouterEvent {}

class ToSignOutRoute extends RouterEvent {}

// Play

class ToStoriesRoute extends RouterEvent {}

class ToStoryRoute extends RouterEvent {
  final String id;

  ToStoryRoute(this.id);
}

class ToMissionRoute extends RouterEvent {
  final String storyId;
  final String missionId;

  ToMissionRoute(this.storyId, this.missionId);
}

// Other

class ToStatsRoute extends RouterEvent {}

class ToProfileRoute extends RouterEvent {}

class ToSettingsRoute extends RouterEvent {}

// About

class ToInfoRoute extends RouterEvent {}

class ToApproachRoute extends RouterEvent {}

class ToPressRoute extends RouterEvent {}

class ToContactRoute extends RouterEvent {}

class ToAppsRoute extends RouterEvent {}

class ToHelpRoute extends RouterEvent {}

class ToGuidelinesRoute extends RouterEvent {}

class ToTermsRoute extends RouterEvent {}

class ToPrivacyRoute extends RouterEvent {}
