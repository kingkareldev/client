part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class Loading extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {
  final bool isRestored;

  Unauthenticated({this.isRestored = false});
}

class Authenticated extends AuthenticationState {
  final bool isRestored;
  final User user;

  Authenticated({required this.user, this.isRestored = false});
}
