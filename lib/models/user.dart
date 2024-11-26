class User {
  final String? id;
  final String? name;
  final String? nationality;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      nationality: json['nationality'],
    );
  }

  User({
    this.id,
    this.name,
    this.nationality,
  });
}
