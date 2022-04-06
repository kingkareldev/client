import '../entities/story/story.dart';
import '../entities/story/story_with_missions.dart';

abstract class StoryRepository {
  Future<Iterable<Story>?> getStories(String token);

  Future<Iterable<StoryWithMissions>?> getStoriesStats(String token);

  Future<StoryWithMissions?> getStory(String token, String storyUrl);
}
