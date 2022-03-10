import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Unauthenticated()) {
    on<Authenticate>((event, emit) {
      print("auth");
      emit(Authenticated());
    });
    on<RestoreAuthentication>((event, emit) {
      print("auth restore");
      emit(Authenticated(true));
    });
    on<RemoveAuthentication>((event, emit) {
      print("auth remove");
      emit(Unauthenticated());
    });
  }
}
