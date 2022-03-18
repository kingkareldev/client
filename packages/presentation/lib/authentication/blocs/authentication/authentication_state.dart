part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final bool isRestored;

  Authenticated([this.isRestored = false]);
}
