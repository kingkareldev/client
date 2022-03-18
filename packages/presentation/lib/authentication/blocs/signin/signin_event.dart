part of 'signin_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignIn extends SignInEvent {
  final String username;
  final String password;

  SignIn({
    required this.username,
    required this.password,
  });
}
