import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:varosa_tech/features/auth/data/models/user_model.dart';
import '../../../../features/auth/domain/entities/auth_tokens_entity.dart';
import '../../../../features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokens> login(String email, String password);
  Future<AuthTokens> refreshToken(String refreshToken);
  Future<User> getCurrentUser(String accessToken);
  Future<void> logout(String accessToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  AuthRemoteDataSourceImpl({required this.dio});
  final Dio dio;

  @override
  Future<AuthTokens> login(String email, String password) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock validation
      if (email.isEmpty || password.isEmpty) {
        throw DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 400,
            data: {'message': 'Email and password are required'},
          ),
        );
      }

      if (password.length < 6) {
        throw DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 401,
            data: {'message': 'Invalid credentials'},
          ),
        );
      }

      // Mock successful response
      final mockResponse = {
        'access_token': _generateMockToken(),
        'refresh_token': _generateMockToken(isRefresh: true),
        'expires_in': 3600, // 1 hour
        'token_type': 'Bearer',
      };

      return AuthTokens.fromJson(mockResponse);
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/login'),
        error: e,
      );
    }
  }

  @override
  Future<AuthTokens> refreshToken(String refreshToken) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock validation
      if (refreshToken.isEmpty || !refreshToken.startsWith('refresh_')) {
        throw DioException(
          requestOptions: RequestOptions(path: '/auth/refresh'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/auth/refresh'),
            statusCode: 401,
            data: {'message': 'Invalid refresh token'},
          ),
        );
      }

      // Simulate random token expiration (10% chance)
      if (Random().nextInt(10) == 0) {
        throw DioException(
          requestOptions: RequestOptions(path: '/auth/refresh'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/auth/refresh'),
            statusCode: 401,
            data: {'message': 'Refresh token expired'},
          ),
        );
      }

      // Mock successful refresh response
      final mockResponse = {
        'access_token': _generateMockToken(),
        'refresh_token': _generateMockToken(isRefresh: true),
        'expires_in': 3600, // 1 hour
        'token_type': 'Bearer',
      };

      return AuthTokens.fromJson(mockResponse);
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/refresh'),
        error: e,
      );
    }
  }

  @override
  Future<User> getCurrentUser(String accessToken) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock validation
      if (accessToken.isEmpty || !accessToken.startsWith('access_')) {
        throw DioException(
          requestOptions: RequestOptions(path: '/auth/me'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/auth/me'),
            statusCode: 401,
            data: {'message': 'Invalid access token'},
          ),
        );
      }

      // Mock user response
      final mockResponse = {
        'id': 'user_${Random().nextInt(1000)}',
        'email': 'user@example.com',
        'name': 'John Doe',
        'profile_image_url': 'https://via.placeholder.com/150',
        'created_at': DateTime.now()
            .subtract(const Duration(days: 30))
            .toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      return UserModel.fromJson(mockResponse);
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/me'),
        error: e,
      );
    }
  }

  @override
  Future<void> logout(String accessToken) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));

      // Mock logout (always succeeds for demo)
      return;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/logout'),
        error: e,
      );
    }
  }

  String _generateMockToken({bool isRefresh = false}) {
    final prefix = isRefresh ? 'refresh_' : 'access_';
    final randomPart = List.generate(
      32,
      (index) => Random().nextInt(36).toRadixString(36),
    ).join();
    return '$prefix$randomPart';
  }
}
