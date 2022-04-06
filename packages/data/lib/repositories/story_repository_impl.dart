import 'dart:convert';
import 'dart:io';

import 'package:business_contract/story/entities/story/story.dart';
import 'package:business_contract/story/entities/story/story_with_missions.dart';
import 'package:business_contract/story/repositories/story_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class StoryRepositoryImpl extends StoryRepository {
  @override
  Future<Iterable<Story>?> getStories(String token) async {
    var url = Uri.https(dotenv.env['SERVER_API_URL']!, '/api/Story');

    var response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var stories = List<Story>.from([]);

      List<dynamic> data = jsonDecode(response.body);
      for (var element in data) {
        stories.add(Story.fromJson(element));
      }

      return stories;
    }

    return null;
  }

  @override
  Future<Iterable<StoryWithMissions>?> getStoriesStats(String token) async {
    var url = Uri.https(dotenv.env['SERVER_API_URL']!, '/api/Stats');

    var response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var stories = List<StoryWithMissions>.from([]);

      List<dynamic> data = jsonDecode(response.body);
      for (var element in data) {
        stories.add(StoryWithMissions.fromJson(element));
      }

      return stories;
    }

    return null;
  }

  @override
  Future<StoryWithMissions?> getStory(String token, String storyUrl) async {
    var url = Uri.https(dotenv.env['SERVER_API_URL']!, '/api/Story/$storyUrl');

    var response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      StoryWithMissions story = StoryWithMissions.fromJson(data);
      return story;
    }

    return null;
  }
}
