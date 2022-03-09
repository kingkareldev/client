class Stats {
  final String? username; // TODO?
  final String missionId;
  final bool completed;
  final int sizeAchieved;
  final int sizeLimit;
  final int speedAchieved;
  final int speedLimit;

  Stats({
    this.username,
    required this.missionId,
    required this.completed,
    required this.sizeLimit,
    required this.sizeAchieved,
    required this.speedLimit,
    required this.speedAchieved,
  });
}
