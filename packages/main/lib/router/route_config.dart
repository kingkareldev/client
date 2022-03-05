abstract class RouteConfig {}

class HomeRouteConfig extends RouteConfig {}

class UnknownRouteConfig extends RouteConfig {}

// Sign

class SignInRouteConfig extends RouteConfig {}

class SignUpRouteConfig extends RouteConfig {}

class SignOutRouteConfig extends RouteConfig {}

// Play

class StoriesRouteConfig extends RouteConfig {}

class StoryRouteConfig extends RouteConfig {
  final String id;

  StoryRouteConfig(this.id);
}

class MissionRouteConfig extends RouteConfig {
  final String storyId;
  final String missionId;

  MissionRouteConfig(this.storyId, this.missionId);
}

// Other

class StatsRouteConfig extends RouteConfig {}

class ProfileRouteConfig extends RouteConfig {}

class SettingsRouteConfig extends RouteConfig {}

// About

abstract class AboutRouteConfig extends RouteConfig {}

class InfoRouteConfig extends AboutRouteConfig {}

class ApproachRouteConfig extends AboutRouteConfig {}

class PressRouteConfig extends AboutRouteConfig {}

class ContactRouteConfig extends AboutRouteConfig {}

class AppsRouteConfig extends AboutRouteConfig {}

class HelpRouteConfig extends AboutRouteConfig {}

class GuidelinesRouteConfig extends AboutRouteConfig {}

class TermsRouteConfig extends AboutRouteConfig {}

class PrivacyRouteConfig extends AboutRouteConfig {}
