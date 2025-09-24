import 'package:fpdart/fpdart.dart';
import 'package:varosa_tech/core/error/exceptions.dart';

import '../error/failures.dart';

/// Base class for all use cases in the application
///
/// Type [T] represents the return type
/// Type [Params] represents the parameters needed for the use case
///
/// Note: This is a simplified version. For production apps, consider using
/// the 'dartz' package for Either type to handle errors functionally.
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

abstract class ParamLessUseCase<T> {
  Future<T> call();
}

class NoParamUseCase<T> {
  final Future<Either<CustomException, T>> Function() callback;

  const NoParamUseCase(this.callback);

  Future<Either<CustomException, T>> call() => callback();
}

/// Use this class when your use case doesn't need any parameters
class NoParams {
  const NoParams();

  @override
  bool operator ==(Object other) => other is NoParams;

  @override
  int get hashCode => 0;
}

/// Base class for use cases that return streams
abstract class StreamUseCase<T, Params> {
  Stream<T> call(Params params);
}

/// Use case that doesn't return anything (void)
abstract class VoidUseCase<Params> {
  Future<void> call(Params params);
}

/// Result wrapper for handling success and failure states
/// This is a simplified version of Either from the dartz package
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

class Error<T> extends Result<T> {
  const Error(this.failure);
  final Failure failure;
}

/// Extension methods for Result
extension ResultExtension<T> on Result<T> {
  /// Fold the result into a single type
  R fold<R>(R Function(Failure failure) onError, R Function(T data) onSuccess) {
    return switch (this) {
      Success<T>(:final data) => onSuccess(data),
      Error<T>(:final failure) => onError(failure),
    };
  }

  /// Check if the result is a success
  bool get isSuccess => this is Success<T>;

  /// Check if the result is an error
  bool get isError => this is Error<T>;

  /// Get the data if success, or null if error
  T? get dataOrNull => switch (this) {
    Success<T>(:final data) => data,
    Error<T>() => null,
  };

  /// Get the failure if error, or null if success
  Failure? get failureOrNull => switch (this) {
    Success<T>() => null,
    Error<T>(:final failure) => failure,
  };
}
