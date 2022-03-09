part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {}
class RestoreAuthentication extends AuthenticationEvent {}
class RemoveAuthentication extends AuthenticationEvent {}

// class SignUp extends AuthenticationEvent {
//   final String realName;
//   final String username;
//   final String password;
//   final String description;
//
//   SignUp(this.realName, this.username, this.password, this.description);
// }
//
// class SignIn extends AuthenticationEvent {
//   final String username;
//   final String password;
//
//   SignIn(this.username, this.password);
// }
//
// class SignOut extends AuthenticationEvent {}
