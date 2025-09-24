import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:varosa_tech/core/error/exceptions.dart';

class ApiService {
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio;

  // GET method
  Future<Either<CustomException, Response>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return Right(response); // Success case
    } catch (e) {
      final CustomException exception = _handleError(
        e,
      ); // Handle error and return Left
      return Left(exception);
    }
  }

  // POST method
  Future<Either<CustomException, Response>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response); // Success case
    } catch (e) {
      final CustomException exception = _handleError(
        e,
      ); // Handle error and return Left
      return Left(exception);
    }
  }

  // PUT method
  Future<Either<CustomException, Response>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response); // Success case
    } catch (e) {
      final CustomException exception = _handleError(
        e,
      ); // Handle error and return Left
      return Left(exception);
    }
  }

  // DELETE method
  Future<Either<CustomException, Response>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio.delete(
        path,
        queryParameters: queryParameters,
      );
      return Right(response); // Success case
    } catch (e) {
      final CustomException exception = _handleError(
        e,
      ); // Handle error and return Left
      return Left(exception);
    }
  }

  CustomException _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const ServerException('Connection timeout');
        case DioExceptionType.badResponse:
          return ServerException('Server error: ${error.response?.statusCode}');
        case DioExceptionType.connectionError:
          return const NetworkException('Network error');
        default:
          return const UnknownException('Unknown error occurred');
      }
    }
    return UnknownException('Unexpected error: $error');
  }
}
