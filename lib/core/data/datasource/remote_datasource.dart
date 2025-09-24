import 'package:fpdart/fpdart.dart';
import 'package:varosa_tech/core/error/exceptions.dart';
// import 'package:varosa_tech/core/services/api_service.dart';

abstract class RemoteDataSource<T> {
  // final ApiService apiService;

  // RemoteDataSource(this.apiService);
  Future<Either<CustomException, List<T>>> getAll();
  Future<Either<CustomException, T>> get(String id);
  Future<Either<CustomException, T>> create(T chat);
  Future<Either<CustomException, T>> update(T chat);
  Future<Either<CustomException, T>> delete(String id);
}
