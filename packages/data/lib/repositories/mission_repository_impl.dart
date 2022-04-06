import 'dart:convert';
import 'dart:io';

import 'package:business_contract/story/entities/mission/mission.dart';
import 'package:business_contract/story/repositories/mission_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MissionRepositoryImpl extends MissionRepository {
  @override
  Future<Mission?> getMission(String token, String storyUrl, String missionUrl) async {
    var url = Uri.https(dotenv.env['SERVER_API_URL']!, '/api/Mission/$storyUrl/$missionUrl');

    var response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Mission mission = Mission.fromJson(jsonDecode(response.body));
      return mission;
    }

    return null;
  }

  @override
  Future<bool> saveGame(String token, String storyUrl, String gameUrl, String commandsJson, int size, int speed, bool completed) async {
    var url = Uri.https(dotenv.env['SERVER_API_URL']!, '/api/Mission/$storyUrl/$gameUrl');

    var response = await http.put(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode({
        "commands": commandsJson,
        "size": size,
        "speed": speed,
        "completed": completed,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
