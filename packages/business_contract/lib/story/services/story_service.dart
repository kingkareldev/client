import 'package:business_contract/story/entities/story/story_with_missions.dart';

import '../entities/mission/mission.dart';
import '../entities/story/story.dart';
import '../repositories/mission_repository.dart';
import '../repositories/story_repository.dart';

abstract class StoryService {
  final StoryRepository storyRepository;
  final MissionRepository missionRepository;

  StoryService({required this.storyRepository, required this.missionRepository});

  Future<Iterable<Story>?> getStories();

  Future<Iterable<StoryWithMissions>?> getStoriesStats();

  Future<StoryWithMissions?> getStory(String storyUrl);

  Future<Mission?> getMission(String storyUrl, String missionUrl);
}
