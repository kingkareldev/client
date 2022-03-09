import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../authentication/authentication_bloc.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationBloc _authBloc;

  SignUpBloc({required AuthenticationBloc authBloc})
      : _authBloc = authBloc,
        super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {
      const bool validated = true; // TODO: validate

      if (!validated) {
        emit(SignUpFailure());
        return;
      }

      emit(SignUpSuccess());
      _authBloc.add(Authenticate());
    });
  }
}
