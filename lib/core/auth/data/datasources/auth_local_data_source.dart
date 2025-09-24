import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varosa_tech/features/auth/data/models/user_model.dart';
import '../../../../features/auth/domain/entities/auth_tokens_entity.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens(AuthTokens tokens);
  Future<AuthTokens?> getTokens();
  Future<void> clearTokens();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
  Future<void> clearAll();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _tokensKey = 'auth_tokens';
  static const String _userKey = 'auth_user';

  @override
  Future<void> saveTokens(AuthTokens tokens) async {
    final prefs = await SharedPreferences.getInstance();
    final tokenJson = jsonEncode(tokens.toJson());
    await prefs.setString(_tokensKey, tokenJson);
  }

  @override
  Future<AuthTokens?> getTokens() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tokenJson = prefs.getString(_tokensKey);

      if (tokenJson == null) return null;

      final tokenMap = jsonDecode(tokenJson) as Map<String, dynamic>;
      return AuthTokens.fromJson(tokenMap);
    } catch (e) {
      // If there's any error parsing tokens, clear them
      await clearTokens();
      return null;
    }
  }

  @override
  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokensKey);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);

      if (userJson == null) return null;

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      // If there's any error parsing user, clear it
      await clearUser();
      return null;
    }
  }

  @override
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  @override
  Future<void> clearAll() async {
    await Future.wait([clearTokens(), clearUser()]);
  }
}
