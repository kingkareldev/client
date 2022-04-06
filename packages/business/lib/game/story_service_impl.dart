import 'package:business_contract/story/entities/mission/mission.dart';
import 'package:business_contract/story/entities/story/story.dart';
import 'package:business_contract/story/entities/story/story_with_missions.dart';
import 'package:business_contract/story/repositories/mission_repository.dart';
import 'package:business_contract/story/repositories/story_repository.dart';
import 'package:business_contract/story/services/story_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryServiceImpl extends StoryService {
  final SharedPreferences storage;

  StoryServiceImpl({
    required this.storage,
    required StoryRepository storyRepository,
    required MissionRepository missionRepository,
  }) : super(
          storyRepository: storyRepository,
          missionRepository: missionRepository,
        );

  @override
  Future<Mission?> getMission(String storyUrl, String missionUrl) async {
    String? token = _getToken();
    if (token == null) {
      return null;
    }

    return missionRepository.getMission(token, storyUrl, missionUrl);
  }

  @override
  Future<Iterable<Story>?> getStories() async {
    String? token = _getToken();
    if (token == null) {
      return null;
    }

    return storyRepository.getStories(token);
  }

  @override
  Future<Iterable<StoryWithMissions>?> getStoriesStats() async {
    String? token = _getToken();
    if (token == null) {
      return null;
    }

    return storyRepository.getStoriesStats(token);
  }

  @override
  Future<StoryWithMissions?> getStory(String storyUrl) async {
    String? token = _getToken();
    if (token == null) {
      return null;
    }

    return storyRepository.getStory(token, storyUrl);
  }

  String? _getToken() {
    String? token = storage.getString('jwt');
    return token;
  }
}
