import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../authentication/blocs/authentication/authentication_bloc.dart';

part 'router_event.dart';

part 'router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  final AuthenticationBloc _authBloc;

  RouterBloc({required AuthenticationBloc authBloc})
      : _authBloc = authBloc,
        super(HomeRoute()) {
    authBloc.stream.forEach(_authBlocUpdated);

    on<ToHomeRoute>((event, emit) {
      _authEmitMiddleware(nextState: HomeRoute(), emit: emit);
    });
    on<ToUnknownRoute>((event, emit) {
      _authEmitMiddleware(nextState: UnknownRoute(), emit: emit);
    });

    // Sign

    on<ToSignInRoute>((event, emit) {
      _authEmitMiddleware(nextState: SignInRoute(), emit: emit);
    });
    on<ToSignUpRoute>((event, emit) {
      _authEmitMiddleware(nextState: SignUpRoute(), emit: emit);
    });

    // Play
    // TODO: signed in

    on<ToStoriesRoute>((event, emit) {
      _authEmitMiddleware(nextState: StoriesRoute(), emit: emit);
    });
    on<ToStoryRoute>((event, emit) {
      _authEmitMiddleware(nextState: StoryRoute(event.id), emit: emit);
    });
    on<ToMissionRoute>((event, emit) {
      _authEmitMiddleware(nextState: MissionRoute(event.storyId, event.missionId), emit: emit);
    });

    // Other
    // TODO: signed in

    on<ToStatsRoute>((event, emit) {
      _authEmitMiddleware(nextState: StatsRoute(), emit: emit);
    });
    on<ToProfileRoute>((event, emit) {
      _authEmitMiddleware(nextState: ProfileRoute(), emit: emit);
    });
    on<ToSettingsRoute>((event, emit) {
      _authEmitMiddleware(nextState: SettingsRoute(), emit: emit);
    });

    // About

    on<ToInfoRoute>((event, emit) {
      _authEmitMiddleware(nextState: InfoRoute(), emit: emit);
    });
    on<ToApproachRoute>((event, emit) {
      _authEmitMiddleware(nextState: ApproachRoute(), emit: emit);
    });
    on<ToPressRoute>((event, emit) {
      _authEmitMiddleware(nextState: PressRoute(), emit: emit);
    });
    on<ToContactRoute>((event, emit) {
      _authEmitMiddleware(nextState: ContactRoute(), emit: emit);
    });
    on<ToAppsRoute>((event, emit) {
      _authEmitMiddleware(nextState: AppsRoute(), emit: emit);
    });
    on<ToHelpRoute>((event, emit) {
      _authEmitMiddleware(nextState: HelpRoute(), emit: emit);
    });
    on<ToGuidelinesRoute>((event, emit) {
      _authEmitMiddleware(nextState: GuidelinesRoute(), emit: emit);
    });
    on<ToTermsRoute>((event, emit) {
      _authEmitMiddleware(nextState: TermsRoute(), emit: emit);
    });
    on<ToPrivacyRoute>((event, emit) {
      _authEmitMiddleware(nextState: PrivacyRoute(), emit: emit);
    });
  }

  // Calls the [callback] if authentication state allows it.
  void _authEmitMiddleware({required RouterState? nextState, required Emitter emit}) {
    final AuthenticationState authState = _authBloc.state;

    if (nextState is RequiresAuthentication && authState is Unauthenticated) {
      emit(SignInRoute());
      return;
    }

    if (nextState is ForbiddenAfterAuthentication && authState is Authenticated) {
      emit(HomeRoute());
      return;
    }

    if (nextState != null) {
      emit(nextState);
    }
  }

  void _authBlocUpdated(AuthenticationState authState) {
    if (authState is Authenticated) {
      if (!authState.isRestored) {
        add(ToProfileRoute());
      }
      return;
    }

    if (authState is Unauthenticated && authState.isRestored) {
      return;
    }

    add(ToHomeRoute());
  }
}
