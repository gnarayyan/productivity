// Core exceptions for the application

abstract class CustomException implements Exception {
  final String message;

  const CustomException([this.message = 'Unknown error occurred']);

  @override
  String toString() => 'AppException: $message';
}

class ServerException implements CustomException {
  @override
  final String message;

  const ServerException([this.message = 'Server error occurred']);

  @override
  String toString() => 'ServerException: $message';
}

class NetworkException implements CustomException {
  @override
  final String message;

  const NetworkException([this.message = 'Network error occurred']);

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements CustomException {
  @override
  final String message;

  const CacheException([this.message = 'Cache error occurred']);

  @override
  String toString() => 'CacheException: $message';
}

class AuthenticationException implements CustomException {
  @override
  final String message;

  const AuthenticationException([this.message = 'Authentication failed']);

  @override
  String toString() => 'AuthenticationException: $message';
}

class ValidationException implements CustomException {
  @override
  final String message;

  const ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}

class NotFoundException implements CustomException {
  @override
  final String message;

  const NotFoundException([this.message = 'Resource not found']);

  @override
  String toString() => 'NotFoundException: $message';
}

class UnknownException implements CustomException {
  @override
  final String message;

  const UnknownException([this.message = 'Unknown error occured']);

  @override
  String toString() => 'UnknownException: $message';
}
