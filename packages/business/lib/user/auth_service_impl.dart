import 'package:business_contract/user/entities/user.dart';
import 'package:business_contract/user/repositories/auth/sign_data_response.dart';
import 'package:business_contract/user/repositories/auth_repository.dart';
import 'package:business_contract/user/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceImpl extends AuthService {
  final SharedPreferences storage;

  AuthServiceImpl({required AuthRepository authRepository, required this.storage})
      : super(authRepository: authRepository);

  @override
  Future<User?> restoreAuth() async {
    String? jwt = _getToken();
    if (jwt == null) {
      return null;
    }

    User? user = await authRepository.getCurrentUser(jwt);

    if (user == null) {
      return null;
    }

    return user;
  }

  @override
  Future removeAuth() async {
    await storage.clear();
  }

  @override
  Future<User?> signIn(String username, String password) async {
    SignDataResponse? response = await authRepository.signIn(username, password);

    if (response == null) {
      return null;
    }

    await storage.setString('jwt', response.token);
    return response.user;
  }

  @override
  Future<User?> signUp(String username, String password, String name, String email, String description) async {
    SignDataResponse? response = await authRepository.signUp(username, password, name, email, description);

    if (response == null) {
      return null;
    }

    await storage.setString('jwt', response.token);
    return response.user;
  }

  String? _getToken() {
    String? token = storage.getString('jwt');
    return token;
  }
}
