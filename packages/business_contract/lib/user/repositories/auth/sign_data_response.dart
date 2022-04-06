import 'package:business_contract/user/entities/user.dart';

class SignDataResponse {
  String token;
  User user;

  SignDataResponse({required this.token, required this.user});
}
