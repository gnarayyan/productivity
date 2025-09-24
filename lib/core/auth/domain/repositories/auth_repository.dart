import '../../../../features/auth/domain/entities/user_entity.dart';
import '../../../../features/auth/domain/entities/auth_tokens_entity.dart';

abstract class AuthRepository {
  Future<AuthTokens> login(String email, String password);
  Future<AuthTokens> refreshToken(String refreshToken);
  Future<User> getCurrentUser();
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<AuthTokens?> getStoredTokens();
  Future<User?> getStoredUser();
}
