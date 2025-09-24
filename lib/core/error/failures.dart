// Core error handling for the application

sealed class Failure {
  const Failure({this.message = 'Unexpected error occurred'});
  final String message;
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network error occurred'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred'});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'Unknown error occurred'});
}

// Authentication failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    super.message = 'Authentication error occurred',
  });
}

class AuthorizationFailure extends Failure {
  const AuthorizationFailure({super.message = 'Authorization error occurred'});
}

// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({super.message = 'Validation error occurred'});
}

// Not found failures
class NotFoundFailure extends Failure {
  NotFoundFailure({super.message = 'Resource not found'});
}
