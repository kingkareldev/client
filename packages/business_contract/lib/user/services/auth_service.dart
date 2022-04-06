import 'package:business_contract/user/repositories/auth_repository.dart';

import '../entities/user.dart';

abstract class AuthService {
  final AuthRepository authRepository;

  AuthService({required this.authRepository});

  // Checks the local storage for stored auth token and does auto-sign-in.
  Future<User?> restoreAuth();

  // Checks the local storage and remove stored auth token, if existed.
  Future<void> removeAuth();

  // Signs in the user.
  Future<User?> signIn(String username, String password);

  // Signs up the user.
  Future<User?> signUp(String username, String password, String name, String email, String description);
}
