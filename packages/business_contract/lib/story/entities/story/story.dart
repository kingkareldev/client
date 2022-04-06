class Story {
  final String url;
  final String name;
  final String description;
  final int missionCount;

  Story({required this.url, required this.name, required this.description, required this.missionCount});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      url: json['url'],
      name: json['name'],
      description: json['description'],
      missionCount: json['missionCount'],
    );
  }
}
