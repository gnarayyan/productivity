import 'package:fpdart/fpdart.dart';
import 'package:varosa_tech/core/error/exceptions.dart';

// abstract class RemoteRepository<T> {
//   Future<Result<List<T>>> getAll();
//   Future<Result<T>> get(String id);
//   Future<Result<T>> create(T category);
//   Future<Result<T>> update(String id, T category);
//   Future<Result<void>> delete(String id);
// }

typedef RepositoryResult<T> = Future<Either<CustomException, T>>;

abstract class RemoteRepository<T> {
  Future<Either<CustomException, List<T>>> getAll();
  Future<Either<CustomException, T>> get(String id);
  Future<Either<CustomException, T>> create(T chat);
  Future<Either<CustomException, T>> update(T chat);
  Future<Either<CustomException, T>> delete(String id);
}
