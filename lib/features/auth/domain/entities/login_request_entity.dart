import 'package:varosa_tech/core/domain/entities/request_dto.dart';

class LoginRequest extends RequestDTO {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});

  @override
  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
