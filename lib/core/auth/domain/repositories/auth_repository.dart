import '../../models/auth_tokens.dart';
import '../../models/user.dart';

abstract class AuthRepository {
  Future<AuthTokens> login(String email, String password);
  Future<AuthTokens> refreshToken(String refreshToken);
  Future<User> getCurrentUser();
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<AuthTokens?> getStoredTokens();
  Future<User?> getStoredUser();
}
