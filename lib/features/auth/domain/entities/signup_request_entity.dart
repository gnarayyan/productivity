import 'package:varosa_tech/core/domain/entities/request_dto.dart';

class SignupRequest extends RequestDTO {
  final String name;
  final String email;
  final String password;

  const SignupRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
  };
}
