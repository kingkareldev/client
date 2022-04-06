part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {
  final User user;

  Authenticate({required this.user});
}

class RestoreAuthentication extends AuthenticationEvent {}

class RemoveAuthentication extends AuthenticationEvent {}
