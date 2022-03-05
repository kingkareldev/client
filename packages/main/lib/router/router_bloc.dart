import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'router_event.dart';

part 'router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc() : super(HomeRoute()) {
    on<ToHomeRoute>((event, emit) {
      emit(HomeRoute());
    });
    on<ToUnknownRoute>((event, emit) {
      emit(UnknownRoute());
    });

    // Sign

    on<ToSignInRoute>((event, emit) {
      emit(SignInRoute());
    });
    on<ToSignUpRoute>((event, emit) {
      emit(SignUpRoute());
    });
    on<ToSignOutRoute>((event, emit) {
      emit(SignOutRoute());
    });

    // Play
    // TODO: signed in

    on<ToStoriesRoute>((event, emit) {
      emit(StoriesRoute());
    });
    on<ToStoryRoute>((event, emit) {
      emit(StoryRoute(event.id));
    });
    on<ToMissionRoute>((event, emit) {
      emit(MissionRoute(event.storyId, event.missionId));
    });

    // Other
    // TODO: signed in

    on<ToStatsRoute>((event, emit) {
      emit(StatsRoute());
    });
    on<ToProfileRoute>((event, emit) {
      emit(ProfileRoute());
    });
    on<ToSettingsRoute>((event, emit) {
      emit(SettingsRoute());
    });

    // About

    on<ToInfoRoute>((event, emit) {
      emit(InfoRoute());
    });
    on<ToApproachRoute>((event, emit) {
      emit(ApproachRoute());
    });
    on<ToPressRoute>((event, emit) {
      emit(PressRoute());
    });
    on<ToContactRoute>((event, emit) {
      emit(ContactRoute());
    });
    on<ToAppsRoute>((event, emit) {
      emit(AppsRoute());
    });
    on<ToHelpRoute>((event, emit) {
      emit(HelpRoute());
    });
    on<ToGuidelinesRoute>((event, emit) {
      emit(GuidelinesRoute());
    });
    on<ToTermsRoute>((event, emit) {
      emit(TermsRoute());
    });
    on<ToPrivacyRoute>((event, emit) {
      emit(PrivacyRoute());
    });
  }
}
