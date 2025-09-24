import 'package:varosa_tech/features/auth/domain/entities/auth_response_entity.dart';
import 'package:varosa_tech/features/auth/domain/entities/user_entity.dart';

abstract class AuthLocalRepository {
  // Local storage methods
  Future<void> saveAuthData(AuthResponse authResponse);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<User?> getCachedUser();
  Future<void> clearAuthData();
  Future<bool> isLoggedIn();
}
