import 'dart:convert';
import 'dart:io';

import 'package:business_contract/user/entities/user.dart';
import 'package:business_contract/user/repositories/auth/sign_data_response.dart';
import 'package:business_contract/user/repositories/auth_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<SignDataResponse?> signIn(String username, String password) async {
    var url = Uri.https(dotenv.env['SERVER_API_URL']!, '/api/Auth/Login');

    var response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return SignDataResponse(
        token: responseData['token'],
        user: User.fromJson(responseData['user']),
      );
    }

    return null;
  }

  @override
  Future<SignDataResponse?> signUp(
      String username, String password, String name, String email, String description) async {
    var url = Uri.https(dotenv.env['SERVER_API_URL']!, '/api/Auth/Register');

    var response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'username': username,
        'password': password,
        'email': email,
        'description': description,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return SignDataResponse(
        token: responseData['token'],
        user: User.fromJson(responseData['user']),
      );
    }

    return null;
  }

  @override
  Future<User?> getCurrentUser(String token) async {
    var url = Uri.https(dotenv.env['SERVER_API_URL']!, '/api/User/current');

    var response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }

    return null;
  }
}
