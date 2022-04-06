import 'package:bloc/bloc.dart';
import 'package:business_contract/user/entities/user.dart';
import 'package:business_contract/user/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService;

  AuthenticationBloc({required AuthService authService})
      : _authService = authService,
        super(Loading()) {
    on<Authenticate>((event, emit) {
      emit(Authenticated(user: event.user));
    });

    on<RestoreAuthentication>((event, emit) async {
      User? user = await _authService.restoreAuth();

      if (user != null) {
        emit(Authenticated(user: user, isRestored: true));
        return;
      }

      emit(Unauthenticated(isRestored: true));
    });

    on<RemoveAuthentication>((event, emit) async {
      await _authService.removeAuth();
      emit(Unauthenticated());
    });
  }
}
