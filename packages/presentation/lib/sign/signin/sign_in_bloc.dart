import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../authentication/authentication_bloc.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationBloc _authBloc;

  SignInBloc({required AuthenticationBloc authBloc})
      : _authBloc = authBloc,
        super(SignInInitial()) {
    on<SignIn>((event, emit) {
      const bool validated = true; // TODO: validate

      if (!validated) {
        emit(SignInFailure());
        return;
      }

      emit(SignInSuccess());
      _authBloc.add(Authenticate());
    });
  }
}
