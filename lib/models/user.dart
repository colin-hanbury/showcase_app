import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String nationality;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      nationality: json['nationality'],
    );
  }

  User({
    String? id,
    String? name,
    String? nationality,
  })  : id = id ?? '',
        name = name ?? '',
        nationality = nationality ?? '';

  @override
  List<Object> get props => [id, name, nationality];
}
