import 'package:equatable/equatable.dart';

abstract class User extends Equatable {
  final String id;
  final String email;
  final String name;

  const User({required this.id, required this.email, required this.name});

  Map<String, dynamic> toJson() {
    return {'_id': id, 'email': email, 'name': name};
  }

  @override
  List<Object?> get props => [id, email, name];
}
