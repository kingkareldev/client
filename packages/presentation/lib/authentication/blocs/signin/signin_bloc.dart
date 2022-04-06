import 'package:bloc/bloc.dart';
import 'package:business_contract/user/entities/user.dart';
import 'package:business_contract/user/services/auth_service.dart';
import 'package:meta/meta.dart';

import '../../../authentication/blocs/authentication/authentication_bloc.dart';

part 'signin_event.dart';

part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationBloc _authBloc;
  final AuthService _authService;

  SignInBloc({required AuthenticationBloc authBloc, required AuthService authService})
      : _authBloc = authBloc,
        _authService = authService,
        super(SignInInitial()) {
    on<SignIn>((event, emit) async {
      User? user = await _authService.signIn(event.username, event.password);

      if (user == null) {
        emit(SignInFailure());
        return;
      }

      _authBloc.add(Authenticate(user: user));
      emit(SignInSuccess());
    });
  }
}
