part of 'signup_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUp extends SignUpEvent {
  final String username;
  final String password;
  final String realName;
  final String email;
  final String description;

  SignUp({
    required this.username,
    required this.password,
    required this.realName,
    required this.email,
    required this.description,
  });
}
