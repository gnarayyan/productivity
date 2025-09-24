import 'package:varosa_tech/features/auth/data/models/user_model.dart';
import 'package:varosa_tech/features/auth/domain/entities/auth_response_entity.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel({
    required super.user,
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return AuthResponseModel(
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }
}
