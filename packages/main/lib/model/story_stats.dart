import 'stats.dart';

class StoryStats {
  final String storyId;
  final String storyName;
  final List<Stats> stats;

  StoryStats({
    required this.storyId,
    required this.storyName,
    required this.stats,
  });
}

// List for story data
final List<StoryStats> statsTmpData = [
  StoryStats(
    storyId: 'the-story-continues',
    storyName: 'Labyrinth of Recursion',
    stats: [
      Stats(
        missionId: 'x3',
        completed: true,
        sizeLimit: 7,
        sizeAchieved: 5,
        speedLimit: 15,
        speedAchieved: 16,
      ),
      Stats(
        missionId: 'x4',
        completed: true,
        sizeLimit: 7,
        sizeAchieved: 8,
        speedLimit: 15,
        speedAchieved: 13,
      ),
      Stats(
        missionId: 'x6',
        completed: false,
        sizeLimit: 7,
        sizeAchieved: 20,
        speedLimit: 15,
        speedAchieved: 38,
      ),
    ],
  ),
  StoryStats(
    storyId: 'first-story',
    storyName: 'First Steps of the King Sds asd as d',
    stats: [
      Stats(
        missionId: 'Uno',
        completed: true,
        sizeLimit: 12,
        sizeAchieved: 11,
        speedLimit: 15,
        speedAchieved: 15,
      ),
    ],
  ),
];
