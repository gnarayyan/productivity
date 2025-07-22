import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../models/auth_tokens.dart';
import '../../models/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthTokens> login(String email, String password) async {
    try {
      final tokens = await remoteDataSource.login(email, password);

      // Store tokens locally
      await localDataSource.saveTokens(tokens);

      // Get and store user data
      final user = await remoteDataSource.getCurrentUser(tokens.accessToken);
      await localDataSource.saveUser(user);

      return tokens;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthTokens> refreshToken(String refreshToken) async {
    try {
      final newTokens = await remoteDataSource.refreshToken(refreshToken);

      // Store new tokens locally
      await localDataSource.saveTokens(newTokens);

      return newTokens;
    } catch (e) {
      // If refresh fails, clear all stored data
      await localDataSource.clearAll();
      rethrow;
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      // First try to get user from local storage
      final localUser = await localDataSource.getUser();
      if (localUser != null) {
        return localUser;
      }

      // If not found locally, get tokens and fetch from remote
      final tokens = await localDataSource.getTokens();
      if (tokens == null) {
        throw Exception('No authentication tokens found');
      }

      final user = await remoteDataSource.getCurrentUser(tokens.accessToken);
      await localDataSource.saveUser(user);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final tokens = await localDataSource.getTokens();

      if (tokens != null) {
        // Attempt to logout from remote (best effort)
        try {
          await remoteDataSource.logout(tokens.accessToken);
        } catch (e) {
          // Ignore remote logout errors, still clear local data
        }
      }

      // Clear all local data
      await localDataSource.clearAll();
    } catch (e) {
      // Always clear local data even if remote logout fails
      await localDataSource.clearAll();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final tokens = await localDataSource.getTokens();
      return tokens != null && !tokens.isExpired;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AuthTokens?> getStoredTokens() async {
    try {
      return await localDataSource.getTokens();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> getStoredUser() async {
    try {
      return await localDataSource.getUser();
    } catch (e) {
      return null;
    }
  }
}
