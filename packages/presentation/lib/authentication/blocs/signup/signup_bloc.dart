import 'package:bloc/bloc.dart';
import 'package:business_contract/user/entities/user.dart';
import 'package:business_contract/user/services/auth_service.dart';
import 'package:meta/meta.dart';

import '../../../authentication/blocs/authentication/authentication_bloc.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationBloc _authBloc;
  final AuthService _authService;

  SignUpBloc({required AuthenticationBloc authBloc, required AuthService authService})
      : _authBloc = authBloc,
        _authService = authService,
        super(SignUpInitial()) {
    on<SignUp>((event, emit) async {
      User? user = await _authService.signUp(event.username, event.password, event.realName, event.email, event.description);

      if (user == null) {
        emit(SignUpFailure());
        return;
      }

      _authBloc.add(Authenticate(user: user));
      emit(SignUpSuccess());
    });
  }
}
