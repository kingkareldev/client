class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String description;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.description,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      description: json['description'],
    );
  }
}
