import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varosa_tech/core/constants/api_constants.dart';
import 'package:varosa_tech/features/auth/data/models/user_model.dart';
import 'package:varosa_tech/features/auth/domain/entities/auth_response_entity.dart';
import 'package:varosa_tech/features/auth/domain/repositories/auth_local_repository.dart';

// @LazySingleton(as: AuthLocalRepositoryImpl) // TODO: Add injectable package
@LazySingleton(as: AuthLocalRepository)
class AuthLocalRepositoryImpl implements AuthLocalRepository {
  final SharedPreferences _sharedPreferences;

  AuthLocalRepositoryImpl(this._sharedPreferences);

  @override
  Future<void> saveAuthData(AuthResponse authResponse) async {
    await Future.wait([
      _sharedPreferences.setString(
        ApiConstants.accessTokenKey,
        authResponse.accessToken,
      ),
      _sharedPreferences.setString(
        ApiConstants.refreshTokenKey,
        authResponse.refreshToken,
      ),
      _sharedPreferences.setString(
        ApiConstants.userDataKey,
        jsonEncode(authResponse.user.toJson()),
      ),
    ]);
  }

  @override
  Future<String?> getAccessToken() async {
    return _sharedPreferences.getString(ApiConstants.accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _sharedPreferences.getString(ApiConstants.refreshTokenKey);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final userData = _sharedPreferences.getString(ApiConstants.userDataKey);
    if (userData != null) {
      try {
        final userJson = jsonDecode(userData) as Map<String, dynamic>;
        return UserModel.fromJson(userJson);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> clearAuthData() async {
    await Future.wait([
      _sharedPreferences.remove(ApiConstants.accessTokenKey),
      _sharedPreferences.remove(ApiConstants.refreshTokenKey),
      _sharedPreferences.remove(ApiConstants.userDataKey),
    ]);
  }

  @override
  Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }
}
