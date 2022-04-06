import '../entities/user.dart';
import 'auth/sign_data_response.dart';

abstract class AuthRepository {
  Future<SignDataResponse?> signIn(String username, String password);

  Future<SignDataResponse?> signUp(String username, String password, String name, String email, String description);

  Future<User?> getCurrentUser(String token);
}
